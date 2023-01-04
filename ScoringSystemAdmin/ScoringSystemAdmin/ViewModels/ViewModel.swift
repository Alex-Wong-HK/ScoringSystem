//
//  ViewModel.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 29/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestore


class CompetitionsViewModel:ObservableObject{
    @Published var list = [Competitions]()
    @Published var msg = ""
    func getData(){
        let db = Firestore.firestore()
        db.collection("competition").getDocuments{snapshot ,error in
            
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                          
                            return Competitions(id: d.documentID, name: d["name"] as? String ?? "")
                            
                        }
                    }
                }
            }
            else{
            }
            
        }
    }
    func createEvent(eventName:String){
        let db = Firestore.firestore()
        db.collection("competition").getDocuments{snapshot ,error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        var id:Int = 0
                        var checking:Bool = true
                        snapshot.documents.forEach{
                            d in
                            if (Int((d.documentID)as? String ?? "0")! > id){
                                id = Int((d.documentID)as? String ?? "0")!
                            }
                           
                            if(d["name"] as? String ?? "" == eventName){
                                checking = false
                                self.msg = "Event Name Already Exists. Please Use Other name."
//                                return false
                            }
                        }
                        if(checking){
                            db.collection("competition").document(String(id+1)).setData([
                                "name":eventName
                            ])
                            db.collection("competition").document(String(id+1)).collection("Athlete").document("test").setData(["name":"hi"])
                            db.collection("competition").document(String(id+1)).collection("Athlete").document("test").delete()
                            self.msg = "Create Event Success."
                            self.getData()
                        }
                    }
                }
            }
            else{
            }
            
        }
    }

}
class AthletesViewModel:ObservableObject{
    @Published var list = [Athletes]()
    func writeData(competition:Competitions,athlete:Athletes){
        let db = Firestore.firestore()
        db.collection("competition").document(competition.id).collection("Athlete").document(String(athlete.id)).setData(["Dmark1":athlete.d1,"Dmark2":athlete.d2,"Emark1":athlete.e1,"Emark2":athlete.e2,"Emark3":athlete.e3,"Emark4":athlete.e4,"Emark5":athlete.e5,"Emark6":athlete.e6],merge: true)
        getData(competitionId: competition.id)
    }
    
    func getData(competitionId:String){
        let db = Firestore.firestore()
        
        
        db.collection("competition").document(competitionId).collection("Athlete").getDocuments{snapshot ,error in
            
            if error == nil{
                if(snapshot!.documents.isEmpty){
                    return
                }
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map {
                            d in
                            let d1 = (d["Dmark1"] as? Double ?? (-1))
                            let d2 = (d["Dmark2"] as? Double ?? (-1))
                            let e1 = (d["Emark1"] as? Double ?? (-1))
                            let e2 = (d["Emark2"] as? Double ?? (-1))
                            let e3 = (d["Emark3"] as? Double ?? (-1))
                            let e4 = (d["Emark4"] as? Double ?? (-1))
                            let e5 = (d["Emark5"] as? Double ?? (-1))
                            let e6 = (d["Emark6"] as? Double ?? (-1))
                            var davg:Double = 0
                            var dcount:Double = 0
                            //D Avg
                            if(d1 != -1){
                                davg += d1
                                dcount = dcount+1
                            }
                            if(d2 != -1){
                                davg += d2
                                dcount = dcount+1
                            }
                     
                            //D Avg End
                            //E Avg
                            var eavg:Double = 0
                            var ecount:Double = 0
                            var highest:Double = 0
                            var lower:Double = 100
                            // e1 = 1 ,e2 =2 ....
                            var highestIndex = 0
                            var lowerIndex = 0
                            
                            if(e1 != -1){
                                eavg += e1
                                ecount = ecount+1
                                if(e1 > highest){
                                    highest = e1
                                    highestIndex = 1
                                }
                                if(e1 < lower){
                                    lower = e1
                                    lowerIndex = 1
                                }
                            }
                            if(e2 != -1){
                                eavg += e2
                                ecount = ecount+1
                                if(e2 > highest){
                                    highest = e2
                                    highestIndex = 2
                                }
                                if(e2 < lower){
                                    lower = e2
                                    lowerIndex = 2
                                }
                            }
                            if(e3 != -1){
                                eavg += e3
                                ecount = ecount+1
                                if(e3 > highest){
                                    highest = e3
                                    highestIndex = 3
                                }
                                if(e3 < lower){
                                    lower = e3
                                    lowerIndex = 3
                                }
                            }
                            if(e4 != -1){
                                eavg += e4
                                ecount = ecount+1
                                if(e4 > highest){
                                    highest = e4
                                    highestIndex = 4
                                }
                                if(e4 < lower){
                                    lower = e4
                                    lowerIndex = 4
                                }
                            }
                            if(e5 != -1){
                                eavg += e5
                                ecount = ecount+1
                                if(e5 > highest){
                                    highest = e5
                                    highestIndex = 5
                                }
                                if(e5 < lower){
                                    lower = e5
                                    lowerIndex = 5
                                }
                            }
                            if(e6 != -1){
                                eavg += e6
                                ecount = ecount+1
                                if(e6 > highest){
                                    highest = e6
                                    highestIndex = 6
                                }
                                if(e6 < lower){
                                    lower = e6
                                    lowerIndex = 6
                                }
                            }
                            var countAvg:Int = 0
                            if(ecount > 5){
                                countAvg = lround((eavg - lower - highest)/(ecount-2))
                            }else{
                                countAvg = lround((eavg )/ecount)
                            }
                            var countDAvg:Int = 0
                            if(davg == 0){
                                
                            }else{
                                countDAvg = lround(davg/dcount)
                            }
                            return Athletes(finish: d["finish"] as? Bool ?? true,
                                                         grade: d["grade"] as? String ?? "",
                                                         UserNumber: (d["id"] as? Double)! ,
                                                         name: d["name"] as? String ?? "",
                                                         id: Int(d.documentID)!,
                                                         d1:Int(d1),
                                                         d2:Int(d2),
                                                         e1:Int(e1),
                                                         e2:Int(e2),
                                                         e3:Int(e3),
                                                         e4:Int(e4),
                                                         e5:Int(e5),
                                                         e6:Int(e6),
                                                         davg:countDAvg,
                                                         eavg:countAvg,
                                                         total: (countDAvg+countAvg)
                                         )

                        }
                        
                    }
                }
            }
            else{
                
            }
        }
    }
    func importAthlete(){
        
        //Read plist -> insert to Datebase
    }
}
class AthletesStore:ObservableObject{
    @Published var athlete : Athletes = Athletes(finish: true, grade: "A", UserNumber: 999, name: "WONG", id: 9999, d1: 1, d2: 2, e1: 3, e2: 4, e3: 5, e4: 6, e5: 7,e6:7, davg: 8, eavg: 9, total: 10)
    @Published var updateCount = 0
}

class TranscriptViewModel:ObservableObject{
    @Published var list = [Transcript]()
    func getData(){
        
        let db = Firestore.firestore()
        db.collection("competition").getDocuments{snapshot ,error in
            
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        var  lists = [Transcript]()
                        var  id = 0
                        snapshot.documents.forEach { f in
                            
                            db.collection("competition").document(f.documentID).collection("Athlete").getDocuments{snapshot ,error in
                                    if error == nil{
                                        if let snapshot = snapshot{
                                        
                                                
                                                snapshot.documents.forEach {
                                                    d in
                                                    let d1 = (d["Dmark1"] as? Double ?? (-1))
                                                    let d2 = (d["Dmark2"] as? Double ?? (-1))
                                                    let e1 = (d["Emark1"] as? Double ?? (-1))
                                                    let e2 = (d["Emark2"] as? Double ?? (-1))
                                                    let e3 = (d["Emark3"] as? Double ?? (-1))
                                                    let e4 = (d["Emark4"] as? Double ?? (-1))
                                                    let e5 = (d["Emark5"] as? Double ?? (-1))
                                                    let e6 = (d["Emark6"] as? Double ?? (-1))
                                                    var davg:Double = 0
                                                    var dcount:Double = 0
                                                    var eavg:Double = 0
                                                    var ecount:Double = 0
                                                    //D Avg
                                                    if(d1 != -1){
                                                        davg += d1
                                                        dcount = dcount+1
                                                    }
                                                    if(d2 != -1){
                                                        davg += d2
                                                        dcount = dcount+1
                                                    }
                                             
                                                    //D Avg End
                                                    //E Avg
                                                    
                                                    var highest:Double = 0
                                                    var lower:Double = 100
                                                    // e1 = 1 ,e2 =2 ....
                                                    var highestIndex = 0
                                                    var lowerIndex = 0
                                                    
                                                    if(e1 != -1){
                                                        eavg += e1
                                                        ecount = ecount+1
                                                        if(e1 > highest){
                                                            highest = e1
                                                            highestIndex = 1
                                                        }
                                                        if(e1 < lower){
                                                            lower = e1
                                                            lowerIndex = 1
                                                        }
                                                    }
                                                    if(e2 != -1){
                                                        eavg += e2
                                                        ecount = ecount+1
                                                        if(e2 > highest){
                                                            highest = e2
                                                            highestIndex = 2
                                                        }
                                                        if(e2 < lower){
                                                            lower = e2
                                                            lowerIndex = 2
                                                        }
                                                    }
                                                    if(e3 != -1){
                                                        eavg += e3
                                                        ecount = ecount+1
                                                        if(e3 > highest){
                                                            highest = e3
                                                            highestIndex = 3
                                                        }
                                                        if(e3 < lower){
                                                            lower = e3
                                                            lowerIndex = 3
                                                        }
                                                    }
                                                    if(e4 != -1){
                                                        eavg += e4
                                                        ecount = ecount+1
                                                        if(e4 > highest){
                                                            highest = e4
                                                            highestIndex = 4
                                                        }
                                                        if(e4 < lower){
                                                            lower = e4
                                                            lowerIndex = 4
                                                        }
                                                    }
                                                    if(e5 != -1){
                                                        eavg += e5
                                                        ecount = ecount+1
                                                        if(e5 > highest){
                                                            highest = e5
                                                            highestIndex = 5
                                                        }
                                                        if(e5 < lower){
                                                            lower = e5
                                                            lowerIndex = 5
                                                        }
                                                    }
                                                    if(e6 != -1){
                                                        eavg += e6
                                                        ecount = ecount+1
                                                        if(e6 > highest){
                                                            highest = e6
                                                            highestIndex = 6
                                                        }
                                                        if(e6 < lower){
                                                            lower = e6
                                                            lowerIndex = 6
                                                        }
                                                    }
                                                    var countAvg:Int = 0
                                                    if(ecount > 5){
                                                        countAvg = lround((eavg - lower - highest)/(ecount-2))
                                                    }else{
                                                        countAvg = lround((eavg )/ecount)
                                                    }
                                                    var countDAvg:Int = 0
                                                    if(davg == 0){
                                                        
                                                    }else{
                                                        countDAvg = lround(davg/dcount)
                                                    }
                                                    let tran = Transcript(name: d["name"] as? String ?? "",
                                                                          id:Double(id),
                                                                         userID: (d["id"] as? Int)!,
                                                                         eventName: f["name"] as? String ?? "",
                                                                         DAvg:countDAvg,
                                                                         EAvg:countAvg,
                                                                         Total: (countDAvg+countAvg)
                                                    )
                                                    id = id+1
                                                    lists.append(tran)
                                                    self.list = lists
                                                }
                                              
                                            
                                        }
                                    }
                                }
                    }
                }
            }
            else{
            }
            
        }
        
        }
    }
}
