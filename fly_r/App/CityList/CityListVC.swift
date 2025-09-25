import UIKit
import Combine

protocol CityListVCDelegate: AnyObject {
    func selectCity(_ city: City)
}

final class CityListVC: ControllerModal {
    
    weak var delegate: CityListVCDelegate?
    
    private var vm: CityListVM!
    private var cancellables: Set<AnyCancellable> = []
    
    private var table = UITableView()
    private let header = HeaderCityList()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        header.delegate = self
        vm = CityListVM()
        vm.$cityListFiltered
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                table.reloadData()
                hideLoader()
            }.store(in: &cancellables)
        vm.cityListFiltered = Storage.shared.cityList
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
    }
    
    deinit { print("deinit CityListVC") }
}



extension CityListVC: HeaderCityListDelegate {
    
    func search(text: String) {
        vm.searchText = text
    }
}


extension CityListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return vm.cityListFiltered.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityItemCell",
            for: indexPath
        ) as! CityItemCell
        cell.city = vm.cityListFiltered[indexPath.row]
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        delegate?.selectCity(vm.cityListFiltered[indexPath.row])
        dismiss(animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 100
    }
}


extension CityListVC {
    
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
            CityItemCell.self,
            forCellReuseIdentifier: "CityItemCell"
        )
        table.tableHeaderView = header
        table.createClearFooter()
        //
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
