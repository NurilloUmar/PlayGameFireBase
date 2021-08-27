//
//  HomeVC.swift
//  PlayGameFireBase
//
//  Created by apple on 25/08/21.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var firstCountLbl: UILabel!
    @IBOutlet weak var secondCountLbl: UILabel!
    @IBOutlet weak var firstCard: UIView!
    @IBOutlet weak var secondCard: UIView!
    
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var fBtn: UIButton!
    @IBOutlet weak var sBtn: UIButton!

    var currentRoom : RoomDM!
    var currentListener : ListenerRegistration!
    @IBOutlet weak var maxCountLbl1: UILabel!
    @IBOutlet weak var maxCountLbl2: UILabel!
    
    var currentPlayer:Int = 1
    
    var currentRoomDocumentID : String!
    
    let db = Firestore.firestore()

    
    
    
    var currentMaxCaunt : Int = 0 {
        didSet{
            maxCountLbl1.text = "\(currentMaxCaunt)"
            maxCountLbl2.text = "\(currentMaxCaunt)"

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.db.collection( "rooms").document(self.currentRoomDocumentID).updateData(["player_\(currentPlayer)_a" : true])
        
        self.currentListener =  db.collection("rooms").document(currentRoomDocumentID).addSnapshotListener ({ snapshot, error in
            if let data = snapshot?.data() {
                let room = RoomDM.init(data: data)
                self.currentMaxCaunt = room.maxCount
                self.update(room: room)

            }
        })
        
        
        if currentPlayer == 1 {
            fBtn.isHidden = false
            sBtn.isHidden = true
        }else {
            sBtn.isHidden = false
            fBtn.isHidden = true

        }
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentListener.remove()
        if !currentRoom.player_1_a && !currentRoom.player_2_a{
            db.collection("rooms").document(currentRoomDocumentID).delete()
        }

    }

    
    func update(room : RoomDM){
        
        self.currentRoom = room
        self.roomName.text = room.roomName
        
        //First Player
        self.firstCard.layer.borderWidth = 2
        self.firstCard.layer.borderColor = room.player_1_a ? UIColor.systemGreen.cgColor:UIColor.white.cgColor
        self.firstCountLbl.text = "\(room.player_1_c)"
        
        //Second Player
        print(room.player_1_a,room.player_2_a)
        self.secondCard.layer.borderWidth = 2
        self.secondCard.layer.borderColor = room.player_2_a ? UIColor.systemOrange.cgColor : UIColor.white.cgColor
        self.secondCountLbl.text = "\(room.player_2_c)"
        
        if (room.player_1_c == room.maxCount) || (room.player_2_c == room.maxCount) {
            
            fBtn.isHidden = true
            sBtn.isHidden = true
            
            if room.maxCount == room.player_1_c{
                let vc = LottieVC(nibName: "LottieVC", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.txt = "Player 1 Win"
                present(vc, animated: true, completion: nil)
            }else{
                let vc = LottieVC(nibName: "LottieVC", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.txt = "Player 2 Win"
                present(vc, animated: true, completion: nil)            }
            
        }
        
        
    }
    
    @IBAction func dissMissPressed(_ sender: Any) {
        self.db.collection("rooms").document(self.currentRoomDocumentID).updateData(["player_\(currentPlayer)_a" : false])
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fPressed(_ sender: Any) {
        
        self.db.collection("rooms").document(self.currentRoomDocumentID).updateData(["player_1_c":self.currentRoom.player_1_c+1])
        
        
    }
    @IBAction func sPressed(_ sender: Any) {
        self.db.collection("rooms").document(self.currentRoomDocumentID).updateData(["player_2_c":self.currentRoom.player_2_c+1])
    }
    
}
