import UIKit

protocol SelectDateVCDelegate: AnyObject {
    func selectDate(_ date: Date)
}

final class SelectDateVC: BottomSheetViewController {

    weak var delegate: SelectDateVCDelegate?
    
    private let contentView = UIView()
    private let calendar = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        setContent(content: contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .black
    }
}


extension SelectDateVC: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        if let date = dateComponents?.date {
            delegate?.selectDate(date)
            dismissBottomSheet()
        }
    }
}


extension SelectDateVC {
    
    private func createSubviews() {
        createCalendar()
    }
    
    private func createCalendar() {
        contentView.addSubview(calendar)
        calendar.calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.current
        calendar.tintColor = .systemPink
        calendar.backgroundColor = .gray.withAlphaComponent(0.5)
        calendar.overrideUserInterfaceStyle = .dark
        calendar.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        //
        let finalDate = Calendar.current.date(
            byAdding: .year,
            value: 1,
            to: Date()
        )
        let dateInterval = DateInterval(
            start: Date.now,
            end: finalDate ?? Date()
        )
        calendar.availableDateRange = dateInterval
        //
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        calendar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        calendar.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        calendar.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}
