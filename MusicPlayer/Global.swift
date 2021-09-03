//
//  Global.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 9/1/21.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
var screenHeight = screenSize.height
let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
var loadingBlock = Create.indicatorLoading(blocking: true) // LOADING VIEW

extension UIViewController{
    // SHOW ALERT ===========
    func showErrorAlert(errorMsg : String, isAction : Bool, title : String, typeAlert : String, titleSingleButton : String){
        let ac = UIAlertController(title: title, message: errorMsg, preferredStyle: .alert)
        if(isAction){
            var stringOK = "OK"
            
            // Create the actions
            let okAction = UIAlertAction(title: stringOK, style: UIAlertAction.Style.default) { [self]
                UIAlertAction in
            }
            let cancelAction = UIAlertAction(title: "Tidak", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            ac.addAction(okAction)
            ac.addAction(cancelAction)
        }else{
            ac.addAction(UIAlertAction(title: titleSingleButton, style: .default))
        }
        
        self.present(ac, animated:  true)
    }
    
    // KEYBOARD SETTING ===========
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.endEditing(true)
    }
    
    @objc func actionTap(){
        view.endEditing(true)
    }
    
    // DOWNLOAD IMAGE ============
    func downloadImage(_ link: String, linkwithCompletion completion: @escaping (UIImage?)->()) {
        let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, responce, _) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }else{
                completion(UIImage.init(systemName: "tray"))
            }
        }
        task.resume()
    }
}

struct Create {
    static func indicatorLoading(blocking:Bool) -> UIView {
        let indicatorView:UIActivityIndicatorView = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.whiteLarge);
        indicatorView.frame.origin.x = screenWidth/2-indicatorView.frame.size.width/2;
        indicatorView.startAnimating();
        indicatorView.layer.cornerRadius=10.0;
        indicatorView.frame.size.width = indicatorView.frame.size.width*2;
        indicatorView.frame.size.height = indicatorView.frame.size.height*2;
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.7);
        indicatorView.center.x = screenWidth/2;
        indicatorView.center.y = screenHeight/2;
        if(blocking) {
            let view:UIView = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight));
            view.backgroundColor=UIColor.clear;
            view.addSubview(indicatorView);
            return view;
        }
        else {
            return indicatorView;
        }
    }
}
