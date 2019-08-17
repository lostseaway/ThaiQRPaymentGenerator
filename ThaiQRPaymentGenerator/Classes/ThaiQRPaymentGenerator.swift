//
//  Created by LostSeaWay on 16/8/2562 BE.
//

import UIKit
@objc public class ThaiQRPaymentGenerator: NSObject {
    public static func generate(type: PaymentableType, paymentAmount: Double?, isReusable: Bool) -> String {
        var template = "000201"
        
        template += "01021" + (isReusable && type.isReusable ? "1" : "2")
        
        let merchantInfo = type.generateMerchantInfo()
        template += type.merchantField + "\(merchantInfo.count)" + merchantInfo
        
        template += "5303764"
        
        if let amount = paymentAmount {
            var strAmount = ""
            if amount.rounded() == amount {
                strAmount = String(format: "%.2f", amount)
            }
            else {
                strAmount = String(amount)
            }
            
            template += "54\(String(format: "%02d", strAmount.count))\(strAmount)"
        }
        
        template += "5802TH"
        template += "6304"
        let checksum = crc16ccitt(data: template.utf8.map{ $0 })
        template += String(format: "%04X", checksum)
        return template
    }
    
    public static func generateQRImage(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    private static func crc16ccitt(data: [UInt8],seed: UInt16 = 0xFFFF, final: UInt16 = 0xffff)->UInt16{
        var crc = seed
        data.forEach { (byte) in
            crc ^= UInt16(byte) << 8
            (0..<8).forEach({ _ in
                crc = (crc & UInt16(0x8000)) != 0 ? (crc << 1) ^ 0x1021 : crc << 1
            })
        }
        return UInt16(crc & final)
    }
}
