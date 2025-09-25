import UIKit

class ControllerModal: UIViewController {
    
    let topBar = TopNavigatonView()
    private var actionClose: UIAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopbar()
        view.backgroundColor = .black
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    private func setTopbar() {
        view.addSubview(topBar)
        topBar.backgroundColor = .darkGray.withAlphaComponent(0.25)
        actionClose = UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true)
        })
        topBar.buttonClose.addAction(
            actionClose,
            for: .touchUpInside
        )
        //
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func removeActionCloseModal() {
        topBar.buttonClose.removeAction(
            actionClose,
            for: .allEvents
        )
    }
}
