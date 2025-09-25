import UIKit

extension UITableView {
    
    func createClearFooter(height: CGFloat = 120) {
        tableFooterView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: frame.width,
                height: height
            )
        )
    }
    
    func createClearHeader(height: CGFloat = 120) {
        tableHeaderView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: frame.width,
                height: height
            )
        )
    }
    
    func reloadSectionCustom(
        _ sections: [Int],
        animation: UITableView.RowAnimation = .none
    ){
        beginUpdates()
        reloadSections(
            IndexSet(sections),
            with: animation
        )
        endUpdates()
        layer.removeAllAnimations()
        setContentOffset(
            self.contentOffset,
            animated: false
        )
    }
}
