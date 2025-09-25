import UIKit

final class SetParametersFlightVC: UIViewController {
    
    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let stack = UIStackView()
    private let buttonSelectFrom = ButtonFirst()
    private let buttonSelectTo = ButtonFirst()
    private let buttonSelectDate = ButtonFirst()
    private let buttonSearch = ButtonFirst()
    
    private enum TypeSelectCity {
        case from
        case to
        case none
    }
    
    private var typeSelectCity: TypeSelectCity = .none
    
    private var cityFrom: City?
    private var cityTo: City?
    private var dateDeparture: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func selectCity() {
        let vc = CityListVC()
        vc.delegate = self
        present(
            vc,
            animated: true
        )
    }
    
    private func selectDate() {
        let vc = SelectDateVC()
        vc.delegate = self
        presentBottomSheet(vc: vc)
    }
    
    private func setSelecCity(_ city: City) {
        if typeSelectCity == .from {
            cityFrom = city
            buttonSelectFrom.setTitle(
                "FROM: \(city.name)",
                for: .normal
            )
        } else if typeSelectCity == .to {
            cityTo = city
            buttonSelectTo.setTitle(
                "TO: \(city.name)",
                for: .normal
            )
        }
        typeSelectCity = .none
        checkFill()
    }
    
    private func setSelecDate(_ date: Date) {
        dateDeparture = date
        if let f = dateDeparture?.convertToString(format: .two) {
            buttonSelectDate.setTitle(
                "DEPARTURE MONTH: \(f.uppercased())",
                for: .normal
            )
        }
        checkFill()
    }
    
    private func checkFill() {
        if cityFrom != nil && cityTo != nil && dateDeparture != nil {
            buttonSearch.alpha = 1.0
            buttonSearch.isUserInteractionEnabled = true
        } else {
            buttonSearch.alpha = 0.25
            buttonSearch.isUserInteractionEnabled = false
        }
    }
    
    private func presentFlightListVC() {
        let vc = FlightListVC(
            cityFrom: cityFrom ?? City(),
            cityTo: cityTo ?? City(),
            dateDeparture: dateDeparture ?? Date()
        )
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
}


extension SetParametersFlightVC: CityListVCDelegate {
    
    func selectCity(_ city: City) {
        setSelecCity(city)
    }
}


extension SetParametersFlightVC: SelectDateVCDelegate {
    
    func selectDate(_ date: Date) {
        setSelecDate(date)
    }
}


extension SetParametersFlightVC {
    
    private func createSubviews() {
        createScroll()
        createViewBack()
        createStack()
        createButtonSelectFrom()
        createButtonSelectTo()
        createButtonSelectDate()
        createButtonSearch()
    }
    
    private func createScroll() {
        view.addSubview(scroll)
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        scroll.showsVerticalScrollIndicator = false
        //
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createViewBack() {
        scroll.addSubview(viewBack)
        //
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        viewBack.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        viewBack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewBack.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        viewBack.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
    }
    
    private func createStack() {
        viewBack.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 16
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 100).isActive = true
        stack.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createButtonSelectFrom() {
        stack.addArrangedSubview(buttonSelectFrom)
        buttonSelectFrom.setTitle(
            "FROM",
            for: .normal
        )
        buttonSelectFrom.setTitleColor(
            .systemPink,
            for: .normal
        )
        let ation = UIAction { [unowned self] _ in
            typeSelectCity = .from
            selectCity()
        }
        buttonSelectFrom.addAction(
            ation,
            for: .touchUpInside
        )
    }
    
    private func createButtonSelectTo() {
        stack.addArrangedSubview(buttonSelectTo)
        buttonSelectTo.setTitle(
            "TO",
            for: .normal
        )
        let ation = UIAction { [unowned self] _ in
            typeSelectCity = .to
            selectCity()
        }
        buttonSelectTo.addAction(
            ation,
            for: .touchUpInside
        )
    }
    
    private func createButtonSelectDate() {
        stack.addArrangedSubview(buttonSelectDate)
        buttonSelectDate.setTitle(
            "DEPARTURE MONTH",
            for: .normal
        )
        let ation = UIAction { [unowned self] _ in
            selectDate()
        }
        buttonSelectDate.addAction(
            ation,
            for: .touchUpInside
        )
    }
    
    private func createButtonSearch() {
        viewBack.addSubview(buttonSearch)
        buttonSearch.setTitleColor(
            .black,
            for: .normal
        )
        buttonSearch.backgroundColor = .systemPink
        buttonSearch.setTitle(
            "SEARCH",
            for: .normal
        )
        let ation = UIAction { [unowned self] _ in
            presentFlightListVC()
        }
        buttonSearch.addAction(
            ation,
            for: .touchUpInside
        )
        buttonSearch.alpha = 0.25
        buttonSearch.isUserInteractionEnabled = false
        //
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 80).isActive = true
        buttonSearch.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -8).isActive = true
        buttonSearch.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        buttonSearch.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
}
