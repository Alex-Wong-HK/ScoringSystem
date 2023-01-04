//
//  ViewModel.swift
//  ScoringSystem
//
//  Created by Alex Wong on 2/12/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class AthleteViewModel:ObservableObject{
    @Published var athlete:Athletes? = nil
    @Published var event:Competitions? = nil
    @Published var msg:String = ""
    init(){
        startListen()
    }
    func startListen(){
        let db = Firestore.firestore()
        db.collection("user").document("1")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
                print("Current data: \(data["start"]as? Bool ?? false)")
                if((data["start"]as? Bool ?? false)){
                    let eventname = data["eventname"] as? String ?? "null"
                    let eventid = data["eventID"] as? String ?? "null"
                    let usernumber = data["userid"] as? String ?? "0"
                    let username = data["name"] as? String ?? "Wong"
                    let grade = data["grade"] as? String ?? "Wong"
                    let documentID = data["documentID"] as? Int ?? 0
                    let d1 = (data["d1"] as? Double ?? (-1))
                    let d2 = (data["d2"] as? Double ?? (-1))
                    let e1 = (data["e1"] as? Double ?? (-1))
                    let e2 = (data["e2"] as? Double ?? (-1))
                    let e3 = (data["e3"] as? Double ?? (-1))
                    let e4 = (data["e4"] as? Double ?? (-1))
                    let e5 = (data["e5"] as? Double ?? (-1))
                    let e6 = (data["e6"] as? Double ?? (-1))
                    self.event = Competitions(id: eventid, name: eventname)
                    self.athlete = Athletes(finish: false, grade: grade, UserNumber: Double(usernumber)!, name: username, id: documentID, d1: Int(d1), d2: Int(d2), e1: Int(e1), e2: Int(e2), e3: Int(e3), e4: Int(e4), e5: Int(e5),e6:Int(e6), davg: -1, eavg: -1, total: -1)
                }else if((data["start"]as? Bool ?? false) == false){
                    self.athlete = nil
                }
               
                
            }
    }
 
    func insertToD(mark:Int)-> String{
        var target:String? = "full"
        var msg:String = ""
        if((mark) >= 0 && (mark) <= 10){
            if(self.athlete!.d1 == -1){
                target = "d1"
                msg = "Saved at d1"
            }else if(self.athlete!.d2 == -1){
                target = "d2"
                msg = "Saved at d2"
            }else{
                return "List is full."
                //TODO
            }
            let db = Firestore.firestore()
            db.collection("user").document("1").setData([
                target!:mark
                ],merge: true)
        }else{
            return "Only input Number 0 -10"
        }
        return msg
    }
    func insertToE(mark:Int) -> String{
        var target:String? = "full"
        var msg:String = ""
            if(mark >= 0 && mark <= 10){
                if(self.athlete!.e1 == -1){
                    target = "e1"
                    msg = "Saved at e1"
                }else if(self.athlete!.e2 == -1){
                    target = "e2"
                    msg = "Saved at e2"
                }else if(self.athlete!.e3 == -1){
                    target = "e3"
                    msg = "Saved at e3"
                }else if(self.athlete!.e4 == -1){
                    target = "e4"
                    msg = "Saved at e4"
                }else if(self.athlete!.e5 == -1){
                    target = "e5"
                    msg = "Saved at e5"
                }else if(self.athlete!.e6 == -1){
                    target = "e6"
                    msg = "Saved at e6"
                }else{
                    return "List is full."
                }
                
                let db = Firestore.firestore()
                db.collection("user").document("1").setData([
                    target!:mark
                    ],merge: true)
            }else{
                msg = "Only input Number 0 -10"
            }
        return msg
        
    }
    func startEvent(userid:String,event:Competitions, username:String, grade:String){
        let db = Firestore.firestore()
        db.collection("competition").document(event.id).collection("Athlete").getDocuments(){snapshot ,error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        var checking:Bool = true
                        var getMaxId:Int = 0
                        snapshot.documents.forEach{
                            d in
                            if( Int(Double(d.documentID)!) > getMaxId ){
                                getMaxId = Int(Double(d.documentID)!)
                            }
                            if( (d["id"] as? Int ?? 0) == Int(Double(userid)!) ){
                                checking = false
                                self.msg = "You already have record in this event."
                            }
                        }
                        if(checking){
                            let db = Firestore.firestore()
                            db.collection("user").document("1").setData([
                                "documentID":getMaxId+1,
                                "eventID":event.id,
                                "eventname":event.name,
                                "grade":grade,
                                "name":username,
                                "start":true,
                                "userid": userid,
                                "e1":-1,
                                "e2":-1,
                                "e3":-1,
                                "e4":-1,
                                "e5":-1,
                                "e6":-1,
                                "d1":-1,
                                "d2":-1
                                ])
//                            self.athlete = Athletes(finish: false, grade: grade, UserNumber: Double(userid)!, name: username, id: getMaxId+1, d1: -1, d2: -1, e1: -1, e2: -1, e3: -1, e4: -1, e5: -1,e6:-1, davg: -1, eavg: -1, total: -1)
//                            self.event = event
                        }
                    }
                }
            }
            else{
            }
            
        }
    }
    
    
    func finish(){
        let event:Competitions = self.event!
        let athlete:Athletes = self.athlete!
        let db = Firestore.firestore()
        db.collection("competition").document(event.id).collection("Athlete").document(String(athlete.id)).setData([
            "name":athlete.name,
            "id":athlete.UserNumber,
            "grade":athlete.grade,
            "finish":true,
            "Dmark1":athlete.d1,
            "Dmark2":athlete.d2,
            "Emark1":athlete.e1,
            "Emark2":athlete.e2,
            "Emark3":athlete.e3,
            "Emark4":athlete.e4,
            "Emark5":athlete.e5,
            "Emark6":athlete.e6
        ])
        self.msg = "Competition Complete."
        cancelEvent()
    }
    func cancelEvent(){
        let db = Firestore.firestore()
        db.collection("user").document("1").setData([
            "start":false
        ],merge: true)
    }
}
class eventViewModel:ObservableObject{
    @Published var list = [Competitions]()
    
    init(){
        startListen()
    }
    func getData(){
        let db = Firestore.firestore()
        db.collection("competition").getDocuments{snapshot ,error in
            
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            print(self.list.count)
                            return Competitions(id: d.documentID, name: d["name"] as? String ?? "")
                            
                        }
                    }
                }
            }
            else{
            }
            
        }
    }
    func startListen(){
        let db = Firestore.firestore()
        db.collection("competition")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.list = documents.map { d in
                    print(self.list.count)
                    return Competitions(id: d.documentID, name: d["name"] as? String ?? "")
                    
                }
            }
    }
}
