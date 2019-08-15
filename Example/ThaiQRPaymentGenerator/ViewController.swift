//
//  ViewController.swift
//  ThaiQRPaymentGenerator
//
//  Created by lostseaway on 08/16/2019.
//  Copyright (c) 2019 lostseaway. All rights reserved.
//

import UIKit
import ThaiQRPaymentGenerator

class ViewController: UIViewController {

    @IBOutlet weak var QRImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qrString = ThaiQRPaymentGenerator.generate(type: Prompay.nationalId(nationalId: "1111111111111"), paymentAmount: nil, isReusable: true)

        print(qrString)

        let qrImage = ThaiQRPaymentGenerator.generateQRImage(from: qrString)

        QRImageView.image = qrImage
    }

}

