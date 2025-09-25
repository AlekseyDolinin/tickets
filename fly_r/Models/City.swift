import SwiftyJSON

final class City {
        
    var name: String = ""
    var code: String = ""
    var hasFlightableAirport: Bool = false
}

extension City {
    
    func parse(json: JSON) {
         name = json["name"].stringValue
         code = json["code"].stringValue
         hasFlightableAirport = json["has_flightable_airport"].boolValue
    }
}
