//
//  LottieVC.swift
//  PlayGameFireBase
//
//  Created by apple on 27/08/21.
//

import UIKit
import Lottie

class LottieVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    
    var txt:String = ""
    private var animationView : AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = txt
        animationView = .init(name : "win")
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationView?.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant: 0).isActive = true
        animationView?.topAnchor.constraint(equalTo:view.topAnchor,constant: 0).isActive = true
        animationView?.rightAnchor.constraint(equalTo:view.rightAnchor,constant: 0).isActive = true
        
        animationView?.leftAnchor.constraint(equalTo:view.leftAnchor,constant: 0).isActive = true
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        self.animationView?.play()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
            if let window = UIApplication.shared.keyWindow{
            window.rootViewController = LoginVC(nibName: "LoginVC", bundle: nil)
            }
        })
        
        
        
    }
    
    


}
