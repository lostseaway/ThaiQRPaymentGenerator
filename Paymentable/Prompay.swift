//
//  Created by LostSeaWay on 16/8/2562 BE.
//

public enum Prompay: PaymentableType {
    case nationalId(nationalId: String)
    case mobile(mobile: String)
    
    public var isReusable: Bool {
        switch self {
        case .mobile:
            return true
        case .nationalId:
            return false
        }
    }
    public var merchantField: String {
        return "29"
    }
    
    public func generateMerchantInfo() -> String {
        var merchant = "0016A000000677010111"
        switch self {
        case .mobile(let mobile):
            if mobile.count != 10 {
                fatalError("Mobile Number should contain 10 digis")
            }
            if mobile.first != "0" {
                fatalError("Mobile Number should start with 0")
            }
            
            let subMobile = mobile[mobile.index(mobile.startIndex, offsetBy: 1)...mobile.index(mobile.startIndex, offsetBy: mobile.count - 1)]
            
            
            
            merchant += "01130066" + subMobile
        case .nationalId(let nationalId):
            if nationalId.count != 13 {
                fatalError("Thailand Natinal ID should contain 13 digis")
            }
            merchant += "0213" + nationalId
        }
        
        return merchant
    }
}
