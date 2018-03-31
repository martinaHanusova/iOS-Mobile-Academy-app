import UIKit

public class ScoreView: UIView {
    public var data: (name: String, value: Int)? {
        didSet {
            setupContent()
        }
    }
    
    func setupContent() {
        guard let data = self.data else {
            return
        }
        
        let nameLabel = UILabel()
        addSubview(nameLabel)
        nameLabel.font = UIFont(name:"Helvetica", size: 12)
        nameLabel.text = data.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
       nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        let valueLabel = UILabel()
        addSubview(valueLabel)
        valueLabel.text = String(data.value)
        valueLabel.font = UIFont(name:"Helvetica", size: 12)
       valueLabel.translatesAutoresizingMaskIntoConstraints = false
      valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
      valueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        

    }
}
