import Foundation

public struct PriceFormatter {
    
    private var identifier: String
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: identifier)
        
        return numberFormatter
    }
    
    public init(identifier: String = "tr_TR") {
        self.identifier = identifier
    }
    
    public func format(price: Int) -> String {
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: price)) {
            return formattedNumber
        }
        
        return String(price)
    }
    
}
