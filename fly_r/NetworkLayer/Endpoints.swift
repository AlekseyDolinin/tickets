import Foundation

public enum Endpoint {
    
    case getFlightList(
        origin: String,
        dest: String,
        period: String,
        page: Int
    )
    case getDataCityList

    public static func path(_ type: Endpoint) -> String {
        
        let token = Storage.shared.token
        let prot = Storage.shared.prot
        let host = Storage.shared.host
        let version = Storage.shared.version
        let currency = Storage.shared.currency
        
        switch type {
                        
        case .getFlightList(let origin, let dest, let period, let page):
            return  prot +
                    host +
                    version +
                    "/prices/latest?" +
                    "origin=\(origin)" +
                    "&destination=\(dest)" +
                    "&beginning_of_period=\(period)" +
                    "&period_type=month" +
                    "&currency=\(currency)" +
                    "&page=\(page)" +
                    "&limit=50" +
                    "&show_to_affiliates=true" +
                    "&sorting=price" +
                    "&trip_class=0" +
                    "&one_way=true" +
                    "&token=\(token)"
            
        case .getDataCityList:
            return prot + host + "/data/en/cities.json"
            
        }
    }
}




