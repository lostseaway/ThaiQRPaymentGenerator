//
//  Created by LostSeaWay on 16/8/2562 BE.
//

@objc public class Billpayment: NSObject, PaymentableType {
    let billerId: String
    let ref1: String
    let ref2: String?
    
    public init(billerId: String, ref1: String, ref2: String) {
        self.billerId = billerId
        self.ref1 = ref1
        self.ref2 = ref2
    }
    
    public var merchantField: String = "30"
    public var isReusable: Bool = true
    
    public func generateMerchantInfo() -> String {
        var merchant = "0016A000000677010112"
        merchant += "0115" + billerId
        merchant += "02\(ref1.count)" + ref1
        if let ref2 = ref2 {
            merchant += "03\(ref2.count)" + ref2
        }
        
        return merchant
    }
}
