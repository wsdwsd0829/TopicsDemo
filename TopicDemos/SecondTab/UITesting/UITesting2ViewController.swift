//
//  UITesting2ViewController.swift
//  TopicDemos
//
//  Created by Max Wang on 7/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import WebKit

class GoogleURLProtocol: URLProtocol {
    open override class func canInit(with request: URLRequest) -> Bool {
//        print(request.url?.absoluteString ?? "empty url")

        return false
    }
    override static func canInit(with task: URLSessionTask) -> Bool {
        return false
    }
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override init(request: URLRequest, cachedResponse: CachedURLResponse?, client: URLProtocolClient?) {
        super.init(request: request, cachedResponse: cachedResponse, client: client)
    }
    
    override func startLoading() {
        
    }
    override func stopLoading() {
        
    }
    
    private func receive(_ data: Data?, response: URLResponse?, error: Error?) {
        if let response = response {
            print("@@@@@@@@@@@, \(response)")
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = data {
            print("@@@@@@@@@@@, \(data)")
            client?.urlProtocol(self, didLoad: data)
        }
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
}
class UITesting2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(URLProtocol.registerClass(GoogleURLProtocol.self))
        edgesForExtendedLayout = []
        let screen = UIScreen.main.bounds
        let webViewFrame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height/2)
        let webView = WKWebView(frame: webViewFrame)
        view.addSubview(webView)
//        webView.load(URLRequest(url: URL(string: "http://google.com")!))
        
        
        let task = URLSession.shared.dataTask(with:  URL(string: "http://swapi.co/api/people/1/")!, completionHandler: { (data, urlResponse, err) in
            let obj = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(obj)
//            JSONSerializaton.jsonObject
            
//            var backToString = String(data: data!, encoding: String.Encoding.utf8)!
//            print(backToString)
            print(urlResponse!)
        })
//        task.resume()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        URLProtocol.unregisterClass(GoogleURLProtocol)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
