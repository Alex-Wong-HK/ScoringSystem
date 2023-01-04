//
//  Judges_Escore.swift
//  ScoringSystem
//
//  Created by Alex Wong on 2/12/2021.
//

import SwiftUI

struct Judges_EscoreView: View {
    @State var mark:String = ""
    @ObservedObject var viewModel : AthleteViewModel
    @State var msg:String = ""
    var body: some View {
        if(viewModel.athlete == nil){
            Text("Please Wait for Event Start")
        }else{
            VStack{
                Spacer()
                VStack{
                    Text(viewModel.event!.name).frame(maxWidth:.infinity, alignment:.leading).font(.headline).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)).foregroundColor(Color.blue)
                    HStack{
                        Text("Athlete Name :").frame(maxWidth:.infinity, alignment:.leading).padding()
                        Text(viewModel.athlete!.name).frame(maxWidth:.infinity, alignment:.trailing).padding()
                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    HStack{
                        Text("Athlete ID :").frame(maxWidth:.infinity, alignment:.leading).padding()
                        Text(String( Int(viewModel.athlete!.UserNumber))).frame(maxWidth:.infinity, alignment:.trailing).padding()
                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    HStack{
                        Text("Grade :").frame( maxWidth:.infinity,alignment:.leading).padding()
                        Text(viewModel.athlete!.grade).frame(maxWidth:.infinity, alignment:.trailing).padding()
                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    
                }.padding()
                
                VStack{
                    Text(msg)
                    Text("Execution Score:")
                    TextField("Score", text: $mark).frame(maxWidth: .infinity).multilineTextAlignment(.leading).textFieldStyle(.roundedBorder).padding()
                    
                    Button(action:{
                        if(mark.isInt){
                            msg = viewModel.insertToE(mark: Int(mark)!)
                            mark = ""
                        }else{
                            msg = "You only can input number."
                            mark = ""
                        }
                        
                       
                    }){
                        Text("Submit")
                    }.buttonStyle(GrowingButtonBlue())
                }
                Spacer()
            }
        }
    }
}

