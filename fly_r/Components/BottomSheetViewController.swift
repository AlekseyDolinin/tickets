import UIKit

class BottomSheetViewController: UIViewController {

    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var swipeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(
            "Закрыть",
            for: .normal
        )
        button.setTitleColor(
            .systemPink,
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(closeAction),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()
    
    // MARK: - Properties
    // Maximum alpha for dimmed view
    private let maxDimmedAlpha: CGFloat = 0.8
    // Minimum drag vertically that enable bottom sheet to dismiss
    private let minDismissiblePanHeight: CGFloat = 20
    // Minimum spacing between the top edge and bottom sheet
    private var minTopSpacing: CGFloat = 80
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresent()
    }
    
    @objc private func closeAction() {
        self.dismissBottomSheet()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        NSLayoutConstraint.activate([
            // Set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Container View
        view.addSubview(mainContainerView)
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainContainerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: minTopSpacing)
        ])
        
        mainContainerView.addSubview(swipeIndicator)
        NSLayoutConstraint.activate([
            swipeIndicator.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            swipeIndicator.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 8),
            swipeIndicator.widthAnchor.constraint(equalToConstant: 40),
            swipeIndicator.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        mainContainerView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            closeButton.leftAnchor.constraint(equalTo: mainContainerView.leftAnchor, constant: 16.0),
            closeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // Content View
        mainContainerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -0),
            contentView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapDimmedView)
        )
        dimmedView.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePanGesture(_:))
        )
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        mainContainerView.addGestureRecognizer(panGesture)
    }

    @objc
    private func handleTapDimmedView() {
        dismissBottomSheet()
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // get drag direction
        let isDraggingDown = translation.y > 0
        guard isDraggingDown else { return }
        
        let pannedHeight = translation.y
        let currentY = self.view.frame.height - self.mainContainerView.frame.height
        // handle gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            self.mainContainerView.frame.origin.y = currentY + pannedHeight
        case .ended:
            // When user stop dragging
            // if fulfil the condition dismiss it, else move to original position
            if pannedHeight >= minDismissiblePanHeight {
                dismissBottomSheet()
            } else {
                self.mainContainerView.frame.origin.y = currentY
            }
        default:
            break
        }
    }

    private func animatePresent() {
        dimmedView.alpha = 0
        mainContainerView.transform = CGAffineTransform(
            translationX: 0,
            y: view.frame.height
        )
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.mainContainerView.transform = .identity
        }
        // add more animation duration for smoothness
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    public func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {  [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.mainContainerView.frame.origin.y = self.view.frame.height
        }, completion: { [weak self] _ in
            self?.dismiss(animated: false)
        })
    }
    
    // sub-view controller will call this function to set content
    public func setContent(content: UIView) {
        contentView.addSubview(content)
        //
        content.translatesAutoresizingMaskIntoConstraints = false
        content.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        content.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        content.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.layoutIfNeeded()
    }
}

extension UIViewController {
    
    func presentBottomSheet(vc: BottomSheetViewController) {
        DispatchQueue.main.async {
            vc.modalPresentationStyle = .overFullScreen
            self.present(
                vc,
                animated: false,
                completion: nil
            )
        }
    }
}
