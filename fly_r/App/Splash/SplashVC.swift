import UIKit
import SwiftyJSON
import Combine

final class SplashVC: UIViewController {

    private let apiService = APIService()
    private var cancellables: Set<AnyCancellable> = []
    
    private var table = UITableView()
    private let header = HeaderFlightList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        showLoader()
        getDataCityList()
    }
    
    deinit { print("deinit SplashVC") }
    
    private func getDataCityList() {
        let link = Endpoint.path(.getDataCityList)
        let fetch = apiService.fetchData(link).receive(on: DispatchQueue.main)
        fetch.sink { [unowned self] completion in
            switch completion {
            case .finished:
                print("getDataCityList: \(completion)")
                presentSetParametersFlightVC()
            case .failure(let error):
                print("getDataCityList \(error)")
            }
        } receiveValue: { [unowned self] data in
            parseLoadingContent(data)
        }.store(in: &cancellables)
    }
    
    private func parseLoadingContent(_ data: Data) {
        let json = JSON(data)
        for i in json.arrayValue {
            let city = City()
            city.parse(json: i)
            if city.hasFlightableAirport {
                Storage.shared.cityList.append(city)
                Storage.shared.cityList.sort(by: { $0.name < $1.name })
            }
        }
    }
    
    
    private func presentSetParametersFlightVC() {
        let vc = SetParametersFlightVC()
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
}
