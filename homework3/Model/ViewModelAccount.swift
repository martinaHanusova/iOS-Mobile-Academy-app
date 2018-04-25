//
//  ViewModelAccount.swift
//  homework3
//
//  Created by Martina Hanusova on 17.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

public enum NeedLoginReason {
    case connectionError
    case wrongLogin
    case canNotDownloadDetail
}

public protocol Authenticator {
    func check(onSucces: @escaping () -> Void, onError: @escaping () -> Void)
}

public protocol AccountVM {
    
    init(authenticator: Authenticator?)
    
    // should be true, if we know credentials
    var isLoggedIn: Bool { get }
    // should contain current user's credentials (account id & token)
    var accountCredentials: AccountCredentials? { get }
    
    var needFillInCredentials: (() -> Void)? { get set }
    
    // should be called before trying to login user
    var willTryLogin: (()->Void)? { get set }
    // should be called after login were tried. On error, you should call needLogin
    var didLogin: ((AccountCredentials)->Void)? { get set }
    
    // should be called, when there is no valid credentials
    var needLogin: ((NeedLoginReason?)->Void)? { get set }
    
    // should be called right before profile would be tried to download
    var willDownloadProfile: (()->Void)? { get set }
    // should be called right after profile download. Call this method only and only if there is any profile downloaded
    // on error while downloading you should remove current credentials and call needLogin callback
    var didDownloadProfile: ((BusinessCardContent)->Void)? { get set }
    
    func loginFilled(name: String, password: String)
    // should be called on app start - probably needLogin if there is no credentials, if there are so, you probably should redownload profile
    func loadData()
    
    func loginRequested() 
}

public class ViewModelAccount: AccountVM {
    
    public var isLoggedIn: Bool {
        get {
            return accountCredentials != nil
        }
    }
    
    public var accountCredentials: AccountCredentials? {
        didSet  {
            if let ac = accountCredentials {
                didLogin?(ac)
                findByAccountCredentials(account: ac)
            }
        }
    }
    
    public var needFillInCredentials: (() -> Void)?
    
    public var willTryLogin: (() -> Void)?
    
    public var didLogin: ((AccountCredentials) -> Void)?
    
    public var needLogin: ((NeedLoginReason?) -> Void)?
    
    public var willDownloadProfile: (() -> Void)?
    
    public var didDownloadProfile: ((BusinessCardContent) -> Void)?
    
    private let authenticator: Authenticator?
    
    public required init(authenticator: Authenticator?) {
        self.authenticator = authenticator
    }
    
    public func loadData() {
        if let accountCredentials = accountCredentials {
            findByAccountCredentials(account: accountCredentials)
        } else {
            needLogin?(nil)
        }
    }
    
    private let userDefaultsKey: String = "SavedCredentials"
    
    public func loginRequested() {
        if UserDefaults.standard.value(forKey: userDefaultsKey) != nil {
            if let authenticator = authenticator {
                authenticator.check(onSucces: {
                    self.accountCredentials = self.getUserDefaults(key: self.userDefaultsKey)
                }, onError: {
                    UserDefaults.standard.removeObject(forKey: self.userDefaultsKey)
                    self.needFillInCredentials?()
                })
                return
            }
        }
        self.needFillInCredentials?()
    }
    
    public func loginFilled(name: String, password: String) {
        self.willTryLogin?()
        let login = Login(name, password)
        let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/login")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let model = login
        let data = try? encoder.encode(model)
        
        urlRequest.httpBody = data
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest ){ (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                self.needLogin?(NeedLoginReason.connectionError)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode(AccountCredentials.self, from: data)
                DispatchQueue.main.async {
                    self.saveUserDeaults(credentials: model)
                    self.accountCredentials = model
                }
            } catch {
                DispatchQueue.main.async {
                    self.needLogin?(NeedLoginReason.wrongLogin)
                }
            }
        }
        DispatchQueue.global().async {
            dataTask.resume()
        }
    }
    
    func findByAccountCredentials(account: AccountCredentials) {
        self.willDownloadProfile?()
        
        let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/account/\(account.accountId)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue(account.accessToken, forHTTPHeaderField: "accessToken")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest ){ (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.accountCredentials = nil
                    self.needLogin?(NeedLoginReason.canNotDownloadDetail)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let content = try decoder.decode(BusinessCardContent.self, from: data)
                DispatchQueue.main.async {
                    self.didDownloadProfile?(content)
                }
            } catch {
                DispatchQueue.main.async {
                    self.accountCredentials = nil
                    self.needLogin?(NeedLoginReason.canNotDownloadDetail)
                }
            }
        }
        DispatchQueue.global().async {
            dataTask.resume()
        }
    }
    
    func saveUserDeaults(credentials: AccountCredentials) {
        let model = credentials
        let encoder = JSONEncoder()
        let data = try! encoder.encode(model)
        let json = String(data: data, encoding: .utf8)
        UserDefaults.standard.set(json, forKey: userDefaultsKey)
    }
    
    func getUserDefaults(key: String) -> AccountCredentials {
        let json = UserDefaults.standard.value(forKey: key) as! String
        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)
        let model = try! decoder.decode(AccountCredentials.self, from: data!)
        return model
    }
}
