import UIKit
import Combine

final class CityListVM {
        
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var cityListFiltered: [City] = []
    var searchText = "" {
        didSet {
            if searchText == "" {
                cityListFiltered = Storage.shared.cityList
            } else {
                cityListFiltered = Storage.shared.cityList.filter({
                    $0.name.lowercased().contains(searchText.lowercased())
                })
            }
        }
    }
}
