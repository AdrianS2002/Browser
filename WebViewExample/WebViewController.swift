

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak private var urlTextField: UITextField!
    @IBOutlet weak private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    private func goTo(url: URL) {
        let urlRequest =  URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func submit() {
        if let url = URL(string: urlTextField.text ?? ""), urlTextField.text!.isValidUrl {
            goTo(url: url)
        } else {
            let controller = UIAlertController(
                title: "Invalid URL",
                message: "Choose an option",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let searchOnGoogleAction = UIAlertAction(
                title: "Google it!",
                style: .default) { [weak self] _ in
                    guard let self else {return}
                    let googleURLString = "https://www.google.com/search?q=\(self.urlTextField.text ?? "")"
                    if let googleURL = URL(string: googleURLString) {
                        self.goTo(url: googleURL)
                    }
                }
            controller.addAction(cancelAction)
            controller.addAction(searchOnGoogleAction)
            present(controller, animated: true)
        }
    }
    
    @IBAction private func onBackPressed(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction private func onForwardPressed(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction private func onGoPressed(_ sender: Any) {
        submit()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString ?? ""
        print(url)
        decisionHandler(.allow)
    }
}

extension String {
    
    var isValidUrl: Bool {
        let regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        return contains(regex)
    }
    
}
