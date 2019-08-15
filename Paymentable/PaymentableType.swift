//
//  Created by LostSeaWay on 16/8/2562 BE.
//

public protocol PaymentableType {
    var merchantField: String { get }
    var isReusable: Bool { get }
    func generateMerchantInfo() -> String
}
