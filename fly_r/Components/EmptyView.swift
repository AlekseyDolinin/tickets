import UIKit

final class EmptyView: UIView {
    
    init() {
        super.init(frame: .zero)
        frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: UIScreen.main.bounds.width,
                height: 160
            )
        )
        createSubViews()
        alpha = 0
        UIView.animate(withDuration: 2.0) {
            self.alpha = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension EmptyView {
    
    private func createSubViews() {
        createImage()
        createTitle()
    }
    
    private func createImage() {
        let image = UIImageView(
            frame: CGRect(
                x: (UIScreen.main.bounds.width / 2) - 50,
                y: 16,
                width: 100,
                height: 100
            )
        )
        image.image = UIImage(named: "emptyFolder")
        image.contentMode = .scaleAspectFit
        image.tintColor = .darkGray
        addSubview(image)
    }
    
    private func createTitle() {
        let title = UILabel(
            frame: CGRect(
                x: 0,
                y: 120,
                width: UIScreen.main.bounds.width,
                height: 40
            )
        )
        title.font = UIFont.systemFont(
            ofSize: 18,
            weight: .regular
        )
        title.textColor = .darkGray
        title.numberOfLines = 0
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.text = "Nothing found!"
        addSubview(title)
    }
}
