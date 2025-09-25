
final class Storage {
    
    static let shared = Storage()
    
    let prot = "https://"
    let host = "api.travelpayouts.com"
    let version = "/v2"
    let token = "321d6a221f8926b5ec41ae89a3b2ae7b"
    let currency = "rub"
    
    var cityList: [City] = []
}
