//
//  HeadofJudges.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 30/11/2021.
//

import SwiftUI

struct HeadofJudges: View {
    @ObservedObject var model = CompetitionsViewModel()
    var body: some View {
        NavigationView{
                List(model.list, id:\.id){item in NavigationLink(destination: HeadofJudgesView(competitions: item)){
                        Text(item.name)
                    }
        }.onAppear(perform: {model.getData()})
        .navigationTitle("Click Here To Select Event")
        }
    }
}

struct HeadofJudgesView: View {
    @StateObject var modelAth = AthletesViewModel()
    let competitions:Competitions

    
    var body: some View {
        
        VStack{
            
            HStack() {
                
                Text(competitions.name).frame(maxWidth: .infinity,alignment: .leading).font(.largeTitle)
            }
            .padding([.top, .leading], 50.0)
            Divider()
            HStack() {
                        Text("Sequence").frame(maxWidth: .infinity)
                        Text("Athlete Name").frame(maxWidth: .infinity)
                        Text("Athlete No.").frame(maxWidth: .infinity)
                        Text("Athlete Grade").frame(maxWidth: .infinity)
            }
            List(modelAth.list, id:\.id){item in
                NavigationLink(destination: HeadJudgesDetails(athlet: item,competition: competitions)){
//                NavigationLink(destination: EmptyView()){
                        HStack() {
                            Text(String(item.id)).frame(maxWidth: .infinity)
                                    Text(item.name).frame(maxWidth: .infinity)
                            Text(String(Int(item.UserNumber))).frame(maxWidth: .infinity)
                                    Text(item.grade).frame(maxWidth: .infinity)
                        }
                    
                    
                    
                }.navigationTitle("Competitions")
            }
            .onAppear(){
                modelAth.getData(competitionId: competitions.id)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HeadJudgesDetails: View {
    let athleteObj : Athletes
    let competitions : Competitions
    @ObservedObject var athleteStore = AthletesStore()
    @State var message: String = ""
    init(athlet:Athletes,competition:Competitions){
        competitions = competition
        athleteObj = athlet
    }

    var body: some View {
        VStack(alignment:.leading){
            Text(competitions.name).frame(maxWidth: .infinity,alignment: .leading).font(.largeTitle).foregroundColor(.blue)
            VStack(spacing:0){
                HStack() {
                        Text("Athlete Name").frame(maxWidth: .infinity,alignment: .leading)
                        Text(athleteObj.name).frame(maxWidth: .infinity,alignment: .trailing)
                  
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                HStack() {
                        Text("Athlete No.:").frame(maxWidth: .infinity,alignment: .leading)
                        Text(String(Int(athleteObj.UserNumber))).frame(maxWidth: .infinity,alignment: .trailing)
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                HStack() {
                        Text("Athlete Grade").frame(maxWidth: .infinity,alignment: .leading)
                        Text(athleteObj.grade).frame(maxWidth: .infinity,alignment: .trailing)
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                Divider()
                
                HStack() {
                    NavigationLink(destination: EditJudgesDetails(athleteSto:athleteStore,athleteObj: athleteObj, competition: competitions)) {
                            Label("", systemImage: "pencil").imageScale(.large)
                        }.frame(maxWidth: .infinity,alignment: .leading)
                    
                }.padding()
            }
            
            Divider()
            HStack(){
                
            
            VStack(){
                VStack() {
                    Spacer()
                    VStack(spacing:0){
                        Text("Difficulty Score").frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("D Judge 1: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.d1 != -1){
                                Text(String(athleteStore.athlete.d1)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                        HStack{
                            Text("D Judge 2: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.d2 != -1){
                                Text(String(athleteStore.athlete.d2)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Text("D average score:").foregroundColor(.blue)
                            Text(String(athleteStore.athlete.davg)).frame(maxWidth: .infinity)
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    Spacer()
                    VStack(spacing:0){
                        Text("Execution Score").frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 1: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e1 != -1){
                                Text(String(athleteStore.athlete.e1)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                        HStack{
                            Text("E Judge 2: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e2 != -1){
                                Text(String(athleteStore.athlete.e2)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 3: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e3 != -1){
                                Text(String(athleteStore.athlete.e3)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 4: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e4 != -1){
                                Text(String(athleteStore.athlete.e4)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 5: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e5 != -1){
                                Text(String(athleteStore.athlete.e5)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 6: ").frame(maxWidth: .infinity)
                            if(athleteStore.athlete.e6 != -1){
                                Text(String(athleteStore.athlete.e6)).frame(maxWidth: .infinity).padding()
            //                    Text(String(athleteObj.d1)).frame(maxWidth: .infinity)
                            }else{
                                Text("Nil").frame(maxWidth: .infinity).padding()
                            }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Text("E average score:").foregroundColor(.blue).frame(maxWidth: .infinity)
                            Text(String(athleteStore.athlete.eavg)).frame(maxWidth: .infinity).padding()
                        }.frame(maxWidth: .infinity)
                    }.overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                    
                }.frame(maxWidth: .infinity)
            }
            VStack(){
                Spacer()
                Text("Final Score : "+String(athleteStore.athlete.total)).frame(maxWidth: .infinity)
                Spacer()
                VStack{
                    Text("Remarks (if any) ").frame(maxWidth: .infinity).padding()
                    TextField("Remarks", text: $message).frame(maxWidth: .infinity).multilineTextAlignment(.center).textFieldStyle(.roundedBorder).padding()
                    Button(action: {}) {
                    Label("Add ", systemImage: "arrow.up.bin.fill").imageScale(.large)
                    
                    }.frame(maxWidth: .infinity,alignment: .center).padding()
                    
                }.frame(alignment:.trailing).overlay(RoundedRectangle(cornerRadius: 10)
                                                                                    .stroke(Color.black, lineWidth: 1))
            }.frame(maxWidth: .infinity)
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).onAppear(perform: {
            if(athleteStore.athlete.id != athleteObj.id){
                athleteStore.athlete = athleteObj
            }
            athleteStore.updateCount = athleteStore.updateCount+1
        })
    }
    }
}

struct EditJudgesDetails: View {
    @StateObject var modelAth = AthletesViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var athleteStore : AthletesStore
    var athlete : Athletes
    let competitions : Competitions
    
    @State var d1: String = ""
    @State var d2: String = ""
    @State var e1: String = ""
    @State var e2: String = ""
    @State var e3: String = ""
    @State var e4: String = ""
    @State var e5: String = ""
    @State var e6: String = ""
    @State var davg : String = ""
    @State var eavg : String = ""
    init(athleteSto:AthletesStore,athleteObj: Athletes , competition : Competitions){
        athlete = athleteObj
        competitions = competition
        athleteStore = athleteSto
        
        _d1 = State(initialValue: String(athleteSto.athlete.d1))
        _d2 = State(initialValue: String(athleteSto.athlete.d2))
        _e1 = State(initialValue: String(athleteSto.athlete.e1))
        _e2 = State(initialValue: String(athleteSto.athlete.e2))
        _e3 = State(initialValue: String(athleteSto.athlete.e3))
        _e4 = State(initialValue: String(athleteSto.athlete.e4))
        _e5 = State(initialValue: String(athleteSto.athlete.e5))
        _e6 = State(initialValue: String(athleteSto.athlete.e6))
        _davg = State(initialValue: String(calDavg()))
        _eavg = State(initialValue: String(calEavg()))
        if(athleteSto.athlete.d1 == -1){
            _d1 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.d2 == -1){
            _d2 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e1 == -1){
            _e1 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e2 == -1){
            _e2 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e3 == -1){
            _e3 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e4 == -1){
            _e4 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e5 == -1){
            _e5 = State(initialValue: String("Nil"))
        }
        if(athleteSto.athlete.e6 == -1){
            _e6 = State(initialValue: String("Nil"))
        }
        
    }
    func calDavg()->Int{
        var count = 0
        var total:Double = 0
        
        if(d1.isInt){
            if(Double(d1)! >= 0 && Double(d1)! <= 10){
                count = count+1
                total = total + Double(d1)!
            }
        }
        
        if(d2.isInt){
            if(Double(d2)! >= 0 && Double(d2)! <= 10){
                count = count+1
                total = total + Double(d2)!
            }
        }
        if(total == 0){
            return 0
        }
        return lround(total/(Double(count)))
        
    }
    func calEavg()->Int{
        var count = 0
        var total:Double = 0
        var higtest:Int = 0
        var lower :Int = 100
        if(e1.isInt){
            if(Double(e1)! >= 0 && Double(e1)! <= 10){
                count = count+1
                total = total + Double(e1)!
                if(Int(e1)! < lower){
                    lower = Int(e1)!
                }
                if(Int(e1)! > higtest){
                    higtest = Int(e1)!
                }
            }
        }
        
        if(e2.isInt){
            if(Double(e2)! >= 0 && Double(e2)! <= 10){
                count = count+1
                total = total + Double(e2)!
                if(Int(e2)! < lower){
                    lower = Int(e2)!
                }
                if(Int(e2)! > higtest){
                    higtest = Int(e2)!
                }
            }
        }
        if(e3.isInt){
            if(Double(e3)! >= 0 && Double(e3)! <= 10){
                count = count+1
                total = total + Double(e3)!
                if(Int(e3)! < lower){
                    lower = Int(e3)!
                }
                if(Int(e3)! > higtest){
                    higtest = Int(e3)!
                }
            }
        }
        if(e4.isInt){
            if(Double(e4)! >= 0 && Double(e4)! <= 10){
                count = count+1
                total = total + Double(e4)!
                if(Int(e4)! < lower){
                    lower = Int(e4)!
                }
                if(Int(e4)! > higtest){
                    higtest = Int(e4)!
                }
            }
        }
        if(e5.isInt){
            if(Double(e5)! >= 0 && Double(e5)! <= 10){
                count = count+1
                total = total + Double(e5)!
                if(Int(e5)! < lower){
                    lower = Int(e5)!
                }
                if(Int(e5)! > higtest){
                    higtest = Int(e5)!
                }
            }
        }
        if(e6.isInt){
            if(Double(e6)! >= 0 && Double(e6)! <= 10){
                count = count+1
                total = total + Double(e6)!
                if(Int(e6)! < lower){
                    lower = Int(e6)!
                }
                if(Int(e6)! > higtest){
                    higtest = Int(e6)!
                }
            }
        }
        if(count > 5){
            return lround(Double((Int(total)-higtest-lower))/(Double(count-2)))
        }
        return lround(total/(Double(count)))
        
    }
    var body: some View {
        VStack(alignment:.leading){
            Text(competitions.name).frame(maxWidth: .infinity,alignment: .leading).font(.largeTitle).foregroundColor(.blue)
            VStack(spacing:0){
                HStack() {
                        Text("Athlete Name").frame(maxWidth: .infinity,alignment: .leading)
                        Text(athlete.name).frame(maxWidth: .infinity,alignment: .trailing)
                  
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                HStack() {
                        Text("Athlete No.:").frame(maxWidth: .infinity,alignment: .leading)
                        Text(String(Int(athlete.UserNumber))).frame(maxWidth: .infinity,alignment: .trailing)
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                HStack() {
                        Text("Athlete Grade").frame(maxWidth: .infinity,alignment: .leading)
                        Text(athlete.grade).frame(maxWidth: .infinity,alignment: .trailing)
                }.padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                Divider()
                
                Button(action: {
                    if(d1 == "Nil") {
                        d1 = String("-1")
                    }
                    if(d2 == "Nil") {
                        d2 = String("-1")
                    }
                    if(e1 == "Nil") {
                        e1 = String("-1")
                    }
                    if(e2 == "Nil") {
                        e2 = String("-1")
                    }
                    if(e3 == "Nil") {
                        e3 = String("-1")
                    }
                    if(e4 == "Nil") {
                        e4 = String("-1")
                    }
                    if(e5 == "Nil") {
                        e5 = String("-1")
                    }
                    if(e6 == "Nil") {
                        e6 = String("-1")
                    }
                    if(d1.isInt && d2.isInt&&e1.isInt&&e2.isInt&&e3.isInt&&e4.isInt&&e5.isInt){
                        if(Int(d1)!>=(-1) && Int(d1)!<=10&&Int(d2)!>=(-1) && Int(d2)!<=10&&Int(e1)!>=(-1) && Int(e1)!<=10&&Int(e2)!>=(-1) && Int(e2)!<=10&&Int(e3)!>=(-1) && Int(e3)!<=10&&Int(e4)!>=(-1) && Int(e4)!<=10&&Int(e5)!>=(-1) && Int(e5)!<=10){
                            var catchData :Athletes =  athlete
                            catchData.d1 = Int(d1)!
                            catchData.d2 = Int(d2)!
                            catchData.e1 = Int(e1)!
                            catchData.e2 = Int(e2)!
                            catchData.e3 = Int(e3)!
                            catchData.e4 = Int(e4)!
                            catchData.e5 = Int(e5)!
                            catchData.e6 = Int(e6)!
                            catchData.davg =  Int(davg)!
                            catchData.eavg =  Int(eavg)!
                            catchData.total = (catchData.davg+catchData.eavg)
                            
                            modelAth.writeData(competition: competitions, athlete:catchData )
                            athleteStore.athlete = catchData
                            athleteStore.updateCount = 9999
                            self.presentationMode.wrappedValue.dismiss()
                        }else{
                            //Only can 1-10
                        }
                    }else{
                        //Only Can Number
                    }
                    
                    
                }) {
                Label("Submit", systemImage: "arrow.up.bin.fill").imageScale(.large)
                }.frame(maxWidth: .infinity,alignment: .trailing).padding()
            }
            
            Divider()
            HStack(){
                
            
            
                VStack() {
                   
                    VStack(spacing:0){
                        Text("Difficulty Score").frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("D Judge 1: ").frame(maxWidth: .infinity)
                            TextField("d1", text: $d1).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: d1){
                                    newValue in
                                    davg = String(calDavg())
                                }
                        }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                        HStack{
                            Text("D Judge 2: ").frame(maxWidth: .infinity)
                            TextField("d2", text: $d2).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: d2){
                                    newValue in
                                    davg = String(calDavg())
                                }
                        }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Text("D average score:").foregroundColor(.blue).frame(maxWidth: .infinity)
                            Text(davg).frame(maxWidth: .infinity).padding()
                        }.frame(maxWidth: .infinity)
                    }.overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                }
                VStack{
                    
                
                    VStack(spacing:0){
                        
                        Text("Execution Score").frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 1: ").frame(maxWidth: .infinity)
                            TextField("e1", text: $e1).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e1 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                        HStack{
                            Text("E Judge 2: ").frame(maxWidth: .infinity)
                            TextField("e2", text: $e2).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e2 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 3: ").frame(maxWidth: .infinity)
                            TextField("e3", text: $e3).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e3 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 4: ").frame(maxWidth: .infinity)
                            TextField("e4", text: $e4).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e4 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 5: ").frame(maxWidth: .infinity)
                            TextField("e5", text: $e5).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e5 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        HStack{
                            Text("E Judge 6: ").frame(maxWidth: .infinity)
                            TextField("65", text: $e6).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).keyboardType(.numberPad).textFieldStyle(.roundedBorder)
                                .onChange(of: e6 ){
                                    new in
                                    eavg = String(calEavg())
                                }
                        }.frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Text("E average score:").foregroundColor(.blue).frame(maxWidth: .infinity)
                            Text(eavg).frame(maxWidth: .infinity).padding()
                        }.frame(maxWidth: .infinity)
                    }.overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                }
            }
        
    }
    }
}
