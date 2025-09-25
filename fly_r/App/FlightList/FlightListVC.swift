import UIKit
import Combine

final class FlightListVC: UIViewController {

    private var vm: FlightListVM!
    private var cancellables: Set<AnyCancellable> = []
    
    private var table = UITableView()
    private let header = HeaderFlightList()
    
    init(
        cityFrom: City,
        cityTo: City,
        dateDeparture: Date
    ) {
        super.init(nibName: nil, bundle: nil)
        header.delegate = self
        header.dateDeparture = dateDeparture
        vm = FlightListVM()
        vm.$flights
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                table.reloadData()
                hideLoader()
                vm.flights.isEmpty ? createEmptyView() : table.createClearFooter()
            }.store(in: &cancellables)
        //
        vm.cityFrom = cityFrom
        vm.cityTo = cityTo
        vm.dateDeparture = dateDeparture
        vm.getData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createSubviews()
    }
    
    deinit { print("deinit FlightListVC") }
    
    private func selectDate() {
        let vc = SelectDateVC()
        vc.delegate = self
        presentBottomSheet(vc: vc)
    }
    
    private func createEmptyView() {
        table.tableFooterView = EmptyView()
    }
    
    private func presentDetailFlightVC(_ flight: Flight) {
        let vc = DetailFlightVC(
            cityFrom: vm.cityFrom,
            cityTo: vm.cityTo,
            flight: flight
        )
        present(
            vc,
            animated: true
        )
    }
}


extension FlightListVC: SelectDateVCDelegate {
    
    func selectDate(_ date: Date) {
        header.dateDeparture = date
        vm.dateDeparture = date
        vm.getData()
    }
}


extension FlightListVC: HeaderFlightListDelegate {
    
    func changeDate() {
        selectDate()
    }
}


extension FlightListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return vm.flights.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FlightItemCell",
            for: indexPath
        ) as! FlightItemCell
        cell.cityFrom = vm.cityFrom
        cell.cityTo = vm.cityTo
        cell.flight = vm.flights[indexPath.row]
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presentDetailFlightVC(vm.flights[indexPath.row])
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 160
    }
}


extension FlightListVC {
    
    private func createSubviews() {
        createTable()
    }
    
    private func createTable() {
        view.addSubview(table)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.keyboardDismissMode = .onDrag
        table.delegate = self
        table.dataSource = self
        table.register(
            FlightItemCell.self,
            forCellReuseIdentifier: "FlightItemCell"
        )
        table.tableHeaderView = header
        //
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
