import UIKit

final class ViewPlane: UIView {
        
    weak var delegate: HeaderFlightListDelegate?
    
    private var stack = UIStackView()
    private var iconPlane = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        setDots()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setDots() {
        let countDots = 32
        for i in (0...countDots) {
            let dot = UIView()
            dot.backgroundColor = .darkGray
            stack.addArrangedSubview(dot)
            let sizeDot: CGFloat = (i == 0 || i == countDots) ? 10 : 3
            dot.layer.cornerRadius = sizeDot / 2
            //
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.heightAnchor.constraint(equalToConstant: sizeDot).isActive = true
            dot.widthAnchor.constraint(equalToConstant: sizeDot).isActive = true
        }
    }
}


extension ViewPlane {

    private func createSubViews() {
        createStack()
        createIconPlane()
    }
    
    private func createStack() {
        addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .equalCentering
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func createIconPlane() {
        addSubview(iconPlane)
        iconPlane.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold
        )
        let imageIcon = UIImage(
            systemName: "airplane.circle.fill",
            withConfiguration: configuration
        )
        iconPlane.image = imageIcon
        iconPlane.tintColor = .darkGray
        iconPlane.backgroundColor = .black
        iconPlane.layer.cornerRadius = 10
        iconPlane.clipsToBounds = true
        //
        iconPlane.translatesAutoresizingMaskIntoConstraints = false
        iconPlane.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconPlane.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconPlane.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconPlane.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
