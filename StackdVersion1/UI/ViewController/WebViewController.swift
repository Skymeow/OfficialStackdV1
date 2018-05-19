//
//  YoutubeViewController.swift
//  testOpenLink
//
//  Created by Sky Xu on 4/4/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import WebKit

protocol OpenedViewDelegate: class {
    func changeXis()
}

class WebViewController: UIViewController, WKUIDelegate {

    weak var openedViewdelegate: OpenedViewDelegate?
    var urlStr: String!
    var webView: WKWebView!
    var btn: UIButton!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        view = webView
        let frame = CGRect(x: 0, y: 0, width: 85, height: 45)
        let customizedBackView = StackdWebLabelView(frame: frame)
        customizedBackView.delegate = self
        view.addSubview(customizedBackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.addLoadingIndicator()
        let myURL = URL(string: self.urlStr)
        if let unwrappedURL = myURL {
            let myRequest = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: myRequest, completionHandler: { (data, response, err) in
                if err == nil {
                    DispatchQueue.main.async {
                        self.webView.load(myRequest)
                        self.removeLoadingIndcator()
                    }
                } else {
                    print("ERROR: \(err)")
                }
            }).resume()
        }
    }
    
    func addLoadingIndicator(){
        guard let loadingIndicator = Bundle.main.loadNibNamed("LoadingIndicator",
                                                              owner:self, options:nil)![0] as? LoadingIndicatorView else{
                                                                return
        }
        loadingIndicator.configView(with: "Loading Webview", at: view.center)
        view.addSubview(loadingIndicator)
    }

    func removeLoadingIndcator(){
        for view in view.subviews{
            if view is LoadingIndicatorView{
                view.removeFromSuperview()
                break
            }
        }
    }

}

extension WebViewController: WebActionDelegate {
    func backTapped() {
        if(webView.canGoBack) {
            //Go back in webview history
            webView.goBack()
        } else {
            //Pop view controller to preview view controller
            self.openedViewdelegate?.changeXis()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
