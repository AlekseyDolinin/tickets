import SwiftyJSON

final class Flight {
        
    var departDate: String = ""
    var returnDate: String = ""
    var foundAt: String = ""
    var originCode: String = ""
    var destinationCode: String = ""
    var gate: String = ""
    var duration: Int = 0
    var numberOfChanges: Int = 0
    var tripClass: Int = 0
    var distance: Int = 0
    var price: Int = 0
    var showToAffiliates: Bool = false
    var actual: Bool = false
}


extension Flight {
    
    func parse(json: JSON) {
        departDate = json["depart_date"].stringValue
        returnDate = json["return_date"].stringValue
        foundAt = json["found_at"].stringValue
        originCode = json["origin"].stringValue
        destinationCode = json["destination"].stringValue
        gate = json["gate"].stringValue
        duration = json["duration"].intValue
        numberOfChanges = json["number_of_changes"].intValue
        tripClass = json["trip_class"].intValue
        distance = json["distance"].intValue
        price = json["value"].intValue
        showToAffiliates = json["show_to_affiliates"].boolValue
        actual = json["actual"].boolValue
    }
}
