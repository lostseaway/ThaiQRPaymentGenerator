//
//  Created by LostSeaWay on 16/8/2562 BE.
//

@objc public class Prompay: NSObject, PaymentableType {
    let type: String
    let id: String
    
    public init(prompayId: String) {
        if prompayId.count != 13 && prompayId.count != 10 {
            fatalError("Error: Input Mismatch")
        }
        
        if prompayId.count == 13 {
            type = "N"
        }
        else {
            type = "M"
        }
        
        self.id = prompayId
    }
    
    public var isReusable: Bool {
        if type == "N" {
            return false
        }
        return true
    }
    public var merchantField: String {
        return "29"
    }
    
    public func generateMerchantInfo() -> String {
        var merchant = "0016A000000677010111"
        if type == "M" {
            let subMobile = id[id.index(id.startIndex, offsetBy: 1)...id.index(id.startIndex, offsetBy: id.count - 1)]
            
            
            
            merchant += "01130066" + subMobile
        }
        else {
            merchant += "0213" + id
        }
        
        return merchant
    }
}
