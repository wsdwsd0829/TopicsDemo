//
//  ApplePayViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/19/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import PassKit
import Stripe

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
        if #available(iOS 10.0, *) {
            if PKPaymentAuthorizationController.canMakePayments(usingNetworks: [.visa, .masterCard]) {
                //Solved: not reaching here even set Test Visa in wallet: need activate in identifier console
                self.present(pavc, animated: true, completion: {
                })
                print("payment ready")
            } else {
                print("payment not setup")
                PKPassLibrary().openPaymentSetup()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: required delegates
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        //MARK: send to stripe
        // 1
        let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
        
        // 2
        
        Stripe.setDefaultPublishableKey("pk_test_qYJrdeM2jDGA4k467Ik6XykD")  // Replace With Your Own Key!
        
        // 3
        STPAPIClient.shared().createToken(with: payment) {
            (token, error) -> Void in
            
            if (error != nil) {
                print(error!.localizedDescription)
                completion(PKPaymentAuthorizationResult(status: .failure, errors: [error!]))
                return
            }
            
            // 4
            let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
            
            // 5
            let url = URL(string: "http://10.15.174.162:5000/pay")  // Replace with computers local IP Address!
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // 6
            let decimalNumber = NSDecimalNumber(mantissa: 200, exponent: -1, isNegative: false)
            let body = ["stripeToken": token?.tokenId ?? "Dummy iD",
                        "amount": "1000",//decimalNumber, //by cents
                "description": "description",
                "shipping": [
                    "city": shippingAddress.City!,
                    "state": shippingAddress.State!,
                    "zip": shippingAddress.Zip!,
                    "firstName": shippingAddress.FirstName!,
                    "lastName": shippingAddress.LastName!]
                ] as [String : Any]
            
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
            
            // 7
            //can send to own server which will send to stripe
            /*
             NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) -> Void in
             if (error != nil) {
             print(error!.localizedDescription)
             completion(PKPaymentAuthorizationStatus.failure)
             } else {
             completion(PKPaymentAuthorizationStatus.success)
             }
             }
             */
            //Test assume send to server & payment processing part success
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
    }
    //!!! if this is not called because other delegate methods is not calling completion and cause blocking
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        //MARK: send to stripe
        // 1
        let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
        
        // 2
        
        Stripe.setDefaultPublishableKey("pk_test_qYJrdeM2jDGA4k467Ik6XykD")  // Replace With Your Own Key!
        
        // 3
        STPAPIClient.shared().createToken(with: payment) {
            (token, error) -> Void in
            
            if (error != nil) {
                print(error!.localizedDescription)
                completion(.failure)
                return
            }
            
            // 4
            let shippingAddress = self.createShippingAddressFromRef(payment.shippingAddress)
            
            // 5
            let url = URL(string: "http://10.15.174.162:5000/pay")  // Replace with computers local IP Address!
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // 6
            let decimalNumber = NSDecimalNumber(mantissa: 200, exponent: -1, isNegative: false)
            let body = ["stripeToken": token?.tokenId ?? "Dummy iD",
                        "amount": "1000",//decimalNumber, //by cents
                "description": "description",
                "shipping": [
                    "city": shippingAddress.City!,
                    "state": shippingAddress.State!,
                    "zip": shippingAddress.Zip!,
                    "firstName": shippingAddress.FirstName!,
                    "lastName": shippingAddress.LastName!]
                ] as [String : Any]
            
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
            
            // 7
            //can send to own server which will send to stripe
            /*
             NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) -> Void in
             if (error != nil) {
             print(error!.localizedDescription)
             completion(PKPaymentAuthorizationStatus.failure)
             } else {
             completion(PKPaymentAuthorizationStatus.success)
             }
             }
             */
            //Test assume send to server & payment processing part success
            completion(PKPaymentAuthorizationStatus.success)
        }
        
        
    }
    
    func createShippingAddressFromRef(_ address: ABRecord!) -> Address {
        var shippingAddress: Address = Address()
        
        shippingAddress.FirstName = ABRecordCopyValue(address, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
        shippingAddress.LastName = ABRecordCopyValue(address, kABPersonLastNameProperty)?.takeRetainedValue() as? String
        
        let addressProperty : ABMultiValue = ABRecordCopyValue(address, kABPersonAddressProperty).takeUnretainedValue() as ABMultiValue
        if let dict : NSDictionary = ABMultiValueCopyValueAtIndex(addressProperty, 0).takeUnretainedValue() as? NSDictionary {
            shippingAddress.Street = dict[String(kABPersonAddressStreetKey)] as? String
            shippingAddress.City = dict[String(kABPersonAddressCityKey)] as? String
            shippingAddress.State = dict[String(kABPersonAddressStateKey)] as? String
            shippingAddress.Zip = dict[String(kABPersonAddressZIPKey)] as? String
        }
        
        return shippingAddress
    }
}
struct Address {
    var Street: String?
    var City: String?
    var State: String?
    var Zip: String?
    var FirstName: String?
    var LastName: String?
    
    init () {
    }
}
