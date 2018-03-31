import Foundation
import UIKit

public class ContactUIButton: UIButton {
    
    public convenience init(imageName: String, title: String, clickHandler: ClickHandler) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name:"Helvetica", size: 14)
        addTarget(clickHandler, action: #selector(ClickHandler.click), for: .touchUpInside)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.centerVertically()
    }
    
    public func centerVertically(padding: CGFloat = 3.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
