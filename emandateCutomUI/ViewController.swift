//
//  ViewController.swift
//  emandateCutomUI
//
//  Created by Praveen Girish Nadumani on 28/04/20.
//  Copyright © 2020 Praveen Girish Nadumani. All rights reserved.
//

import UIKit
import Razorpay
import WebKit

class ViewController: UIViewController, RazorpayPaymentCompletionProtocol, WKNavigationDelegate {
    
    var webView: WKWebView!
    var razorpay: RazorpayCheckout!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.webView = WKWebView(frame: self.view.frame)
        self.razorpay = RazorpayCheckout.initWithKey("rzp_test_Bc7pOvh6Z4niGG", andDelegate: self, withPaymentWebView: self.webView)
         self.view.addSubview(self.webView)
        self.webView.navigationDelegate = self
        
    }

    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]){
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        //self.view = view that controller manages
        self.view.sendSubviewToBack(self.webView)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        self.razorpay = nil
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]){
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        //self.view = view that controller manages
        self.view.sendSubviewToBack(self.webView)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        self.razorpay = nil
    }
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        if razorpay != nil{
            self.razorpay.webView(webView, didCommit: navigation)
        }
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError er: Error) {
        if razorpay != nil{
            self.razorpay.webView(webView, didFailProvisionalNavigation: navigation, withError: er)
        }
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError er: Error){
        if razorpay != nil{
            self.razorpay.webView(webView, didFail: navigation, withError: er)
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        if razorpay != nil{
            self.razorpay.webView(webView, didFinish: navigation)
        }
    }
    
    @IBAction func PayNowEmandate(_ sender: UIButton) {
        //        To call create payment method to create a emandate payment
        let options: [String:Any] = [
                       "order_id":"order_EjvAt9yRuYqqvQ",
                      "customer_id":"cust_E6iJLC7aj3Ii3S",
                      "recurring":1,
                      "amount":"0",
                      "contact":"7204795036",
                      "email":"yoyopraveen6@gmail.com",
                      "method":"emandate",
                      "bank": "SBIN",
                      "bank_account[name]": "Gaurav Kumar",
                      "bank_account[account_number]": "1121431121541121",
                      "bank_account[ifsc]": "SBIN0000324",
                      "auth_type": "netbanking"
                ]
        razorpay.authorize(options)
        
        
    }
    

}

