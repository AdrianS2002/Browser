
import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var controller: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://google.ro")!
        controller = SFSafariViewController(url: url)
    }
    
    private var isControllerPresented = false
    override func viewDidAppear(_ animated: Bool) {
        if !isControllerPresented {
            isControllerPresented = true
            present(controller, animated: true)
        }
    }


}

