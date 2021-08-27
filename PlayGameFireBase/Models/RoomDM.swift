//
//  RoomDM.swift
//  PlayGameFireBase
//
//  Created by apple on 26/08/21.
//

import Foundation


struct RoomDM {
    
    var isRoomActive : Bool
    var maxCount : Int
    var player_1_c : Int
    var player_2_c : Int
    var player_1_a : Bool
    var player_2_a : Bool
    var roomName : String
    
    
    func getDic()->[String:Any]{
        let dic:[String : Any] = [
            
            "isRoomActive" : self.isRoomActive,
            "maxCount" : self.maxCount,
            "player_1_c" : self.player_1_c,
            "player_2_c" : self.player_2_c,
            "player_1_a" : self.player_1_a,
            "player_2_a" : self.player_2_a,
            "roomName" : self.roomName
            
        ]
        return dic
    }
    
    init(data : [String:Any]) {
        
        self.isRoomActive = data["isRoomActive"] as! Bool
        self.maxCount = data["maxCount"] as! Int
        self.player_1_c = data["player_1_c"] as! Int
        self.player_2_c = data["player_2_c"] as! Int
        self.player_1_a = data["player_1_a"] as! Bool
        self.player_2_a = data["player_2_a"] as! Bool
        self.roomName = data["roomName"] as! String
    }
    
    
    init(isRoomActive: Bool, maxCount: Int, player_1_c: Int, player_2_c: Int, player_1_a: Bool, player_2_a: Bool, roomName: String) {
        self.isRoomActive = isRoomActive
        self.maxCount = maxCount
        self.player_1_c = player_1_c
        self.player_2_c = player_2_c
        self.player_1_a = player_1_a
        self.player_2_a = player_2_a
        self.roomName = roomName
    }
    
     
}
