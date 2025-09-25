import Foundation

extension Date {
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(
            byAdding: .second,
            value: Int(timeZoneOffset),
            to: nowUTC
        ) else {
            print("error to localDate")
            return Date()
        }
        return localDate
    }
}


extension Date {
    
    func convertToString(format: TypeDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        let formatDate: String = formatter.string(from: self)
        return formatDate
    }
}


extension Date {

    enum TypeDate: String {
        case one = "dd MMMM YYYY"
        case two = "MMMM"
        case three = "MMMM yyyy"
        case four = "HH:mm"
        case five = "yyyy-MM"
        case six = "yyyy-MM-dd"
        case eight = "yyyy-MM-01"
    }

    static func type(_ type: TypeDate) -> String {
        return type.rawValue
    }
}
