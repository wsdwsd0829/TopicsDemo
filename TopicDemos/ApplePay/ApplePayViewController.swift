//
//  ApplePayViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/19/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import PassKit

//TODO: send to backend
class ApplePayViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    let request = PKPaymentRequest()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PKPaymentAuthorizationViewController.canMakePayments() {
            //request must set
            request.supportedNetworks = [.visa, .masterCard]
            request.currencyCode = "USD";
            request.countryCode = "US"
            request.merchantIdentifier = "merchant.com.maxsida.applepaysandbox";
            request.merchantCapabilities = .capability3DS
            
            //Item price
            let decimalNumber = NSDecimalNumber(mantissa: 200, exponent: -1, isNegative: false) //=20
            let item = PKPaymentSummaryItem(label: "item label", amount: decimalNumber)
            request.paymentSummaryItems = [item, item]
            
            let shipDecimalNumber =  NSDecimalNumber(mantissa: 5, exponent: 0, isNegative: false)
            
            //ship method
            let shipMethod = PKShippingMethod(label: "ship method standard 5", amount: shipDecimalNumber)
            shipMethod.identifier = "ship method 1"
            request.shippingMethods = [shipMethod]
            
            //ask user to input / select
            request.requiredBillingAddressFields = .all
            request.requiredShippingAddressFields = [.all]
            
            //Create Apple pay btn
            let payBtn = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
            payBtn.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
            self.view.addSubview(payBtn)
        
            payBtn.addTarget(self, action: #selector(ApplePayViewController.buttonClicked(_:)), for: .touchUpInside)
        }
        // Do any additional setup after loading the view.
    }
    //start payment
    func buttonClicked(_ sender: Any) {
        let pavc = PKPaymentAuthorizationViewController(paymentRequest: request)
        pavc.delegate = self
        if PKPaymentAuthorizationController.canMakePayments(usingNetworks: [.visa, .masterCard]) {
            //Solved: not reaching here even set Test Visa in wallet: need activate in identifier console
            self.present(pavc, animated: true, completion: {
            })
            print("payment ready")
        } else {
            print("payment not setup")
            PKPassLibrary().openPaymentSetup()
        }
    }
    
    //MARK: required delegates
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //!!! if this is not called because other delegate methods is not calling completion and cause blocking
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        //can send to own server and then verify success
        completion(.success)
    }
}
