//
//  LoginVC.swift
//  PlayGameFireBase
//
//  Created by apple on 25/08/21.
//

import UIKit
import Firebase
import  Lottie

class LoginVC: UIViewController {
    
    @IBOutlet weak var containerV: UIView!
    let db = Firestore.firestore()
    var currentListener : ListenerRegistration!
    
    
    private var animationView : AnimationView?

    
    @IBOutlet weak var roomNameTF: UITextField!{
        didSet{
            roomNameTF.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            roomNameTF.layer.borderWidth = 1
            roomNameTF.layer.cornerRadius = 9
            roomNameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
            roomNameTF.clipsToBounds = true

            roomNameTF.leftViewMode = .always
        }
    }
    
    var rooms : [QueryDocumentSnapshot] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("rooms").getDocuments { snapshot, error in
            if let snap = snapshot{
                self.rooms = snap.documents
            }
        }
    }
    
    
    func lottieFunc(){
        animationView = .init(name : "click")
        animationView?.frame = containerV.bounds
        containerV.addSubview(animationView!)
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationView?.bottomAnchor.constraint(equalTo:containerV.bottomAnchor,constant: 0).isActive = true
        animationView?.topAnchor.constraint(equalTo:containerV.topAnchor,constant: 0).isActive = true
        animationView?.rightAnchor.constraint(equalTo:containerV.rightAnchor,constant: 0).isActive = true
        animationView?.leftAnchor.constraint(equalTo:containerV.leftAnchor,constant: 0).isActive = true
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        self.animationView?.play()

    }
    
    
    // When you press this button ,You can pass next page in th game
    
    @IBAction func goPressed(_ sender: Any) {
        lottieFunc()

        if roomNameTF.text!.isEmpty{
            roomNameTF.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }else {
            
            
            roomNameTF.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)

            let roomID = roomNameTF.text?.replacingOccurrences(of: " ", with: "").lowercased()
            db.collection("rooms").getDocuments { [self] snapshot, error in
                let docIdes : [String] = snapshot!.documents.map{ a in
                    return a.documentID
                }
                if docIdes.contains(roomID!){
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
                        vc.modalPresentationStyle = .fullScreen
                        vc.currentRoomDocumentID = roomID
                        vc.currentPlayer = 2
                        self.present(vc, animated: true, completion: nil)
                    })

                    
                }else {

                    let myRoom : RoomDM = RoomDM(isRoomActive: false, maxCount: (10...50).randomElement() ?? 50, player_1_c: 0, player_2_c: 0, player_1_a: true, player_2_a: false, roomName: roomNameTF.text!)
                    
                    db.collection("rooms").document(roomID!).setData(myRoom.getDic())
                    
                    currentListener =  db.collection("rooms").document(roomID!).addSnapshotListener { snapshot, error in
                        if let _ = snapshot {
                            
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                                let vc = HomeVC(nibName: "HomeVC", bundle: nil)
                                vc.modalPresentationStyle = .fullScreen
                                vc.currentRoomDocumentID = roomID
                                vc.currentPlayer = 1
                                self.present(vc, animated: true, completion: nil)
                            })
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
}
