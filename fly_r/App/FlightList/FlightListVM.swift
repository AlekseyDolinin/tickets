import UIKit
import SwiftyJSON
import Combine

final class FlightListVM {
        
    private let apiService = APIService()
    private var cancellables: Set<AnyCancellable> = []
    
    var cityFrom: City!
    var cityTo: City!
    var dateDeparture: Date!
    
    var page = 1
    
    @Published var flights: [Flight] = []
    
    func getData() {
        page = 1
        flights.removeAll()
        getDataFlightList()
    }
    
    private func getDataFlightList() {
        let link = Endpoint.path(
            .getFlightList(
                origin: cityFrom?.code ?? "",
                dest: cityTo?.code ?? "",
                period: getPeriod(),
                page: page
            )
        )
        print(link)
        let fetch = apiService.fetchData(link)
            .receive(on: DispatchQueue.main)
        fetch.sink { completion in
            switch completion {
            case .finished:
                print("getDataFlightList: \(completion)")
            case .failure(let error):
                print("getDataFlightList \(error)")
            }
        } receiveValue: { [unowned self] data in
            parseLoadingContent(data)
        }.store(in: &cancellables)
    }
    
    private func getPeriod() -> String {
        let formate = dateDeparture?.convertToString(format: .eight)
        return formate ?? ""
    }
    
    private func parseLoadingContent(_ data: Data) {
        let json = JSON(data)
        print(json)
        for i in json["data"].arrayValue {
            let flight = Flight()
            flight.parse(json: i)
            flights.append(flight)
        }
    }
}
