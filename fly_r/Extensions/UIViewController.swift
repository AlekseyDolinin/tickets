import Foundation
import UIKit

public extension UIViewController {
        
    func showLoader(addBlure: Bool = false) {
        if addBlure == true {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
        }
        //
        DispatchQueue.main.async {
            let loader = Loader()
            self.view.addSubview(loader)
            self.view.isUserInteractionEnabled = false
            //
            loader.translatesAutoresizingMaskIntoConstraints = false
            loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
    
    func hideLoader() {
        view.subviews.forEach { v in
            if v is Loader {
                v.removeFromSuperview()
                view.isUserInteractionEnabled = true
            }
            if v is UIVisualEffectView {
                v.removeFromSuperview()
            }
        }
    }
}
