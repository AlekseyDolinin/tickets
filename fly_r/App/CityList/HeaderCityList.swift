import UIKit

protocol HeaderCityListDelegate: AnyObject {
    func search(text: String)
}

final class HeaderCityList: UIView {
        
    weak var delegate: HeaderCityListDelegate?
    
    private var stack = UIStackView()
    private let searchInput = SearchTextField()
    private var separator = Separator()
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    @objc
    private func performSearch() {
        let currentText = searchInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        delegate?.search(text: currentText)
    }
}


extension HeaderCityList: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        timer?.invalidate()
        let currentText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if currentText.count >= 1 {
             timer = Timer.scheduledTimer(
                timeInterval: 0.75,
                target: self,
                selector: #selector(performSearch),
                userInfo: nil,
                repeats: false)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.search(text: "")
        return true
    }
}


extension HeaderCityList {

    private func createSubViews() {
        createStack()
        createSearchInput()
        createSeparator()
    }
    
    private func createStack() {
        addSubview(stack)
        stack.spacing = 16
        stack.axis = .vertical
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    private func createSearchInput() {
        stack.addArrangedSubview(searchInput)
        searchInput.delegate = self
    }
            
    private func createSeparator() {
        stack.addArrangedSubview(separator)
    }
}
