//
//  AthleteView.swift
//  ScoringSystem
//
//  Created by Alex Wong on 2/12/2021.
//

import SwiftUI

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

struct AthleteView: View {
    @ObservedObject var viewModel : AthleteViewModel
    @ObservedObject var eventModel : eventViewModel
    @State var username:String = ""
    @State var userId:String = ""
    @State var grade:String = ""
    var body: some View {
        if(viewModel.athlete == nil){
        VStack{
            VStack{
                Text("Athlete Information :").frame(maxWidth:.infinity, alignment:.leading).font(.headline).padding()
                HStack{
                    Text("Athlete Name :").frame( alignment:.leading).padding()
                    TextField("Athlete Name", text: $username).frame(maxWidth: .infinity).multilineTextAlignment(.leading).textFieldStyle(.roundedBorder).padding()
                }
                HStack{
                    Text("Athlete ID :").frame( alignment:.leading).padding()
                    TextField("Athlete ID", text: $userId).frame(maxWidth: .infinity).multilineTextAlignment(.leading).textFieldStyle(.roundedBorder).keyboardType(.numberPad).padding()
                }
                HStack{
                    Text("Grade :").frame( alignment:.leading).padding()
                    TextField("Grade", text: $grade).frame(maxWidth: .infinity).multilineTextAlignment(.leading).textFieldStyle(.roundedBorder).padding()
                }
                Text(viewModel.msg).padding()
            }
            
            List(eventModel.list, id:\.id){item in
            HStack{
                Text(item.name).frame(maxWidth: .infinity,alignment:.leading)
                
                Button(action:{
                    if(username == "" || userId == "" || grade == ""){
                        viewModel.msg = "Please fill all Athlete Information Before start event."
                    }else{
                        if(userId.isInt){
                            viewModel.startEvent(userid: userId, event: item, username: username, grade: grade)
                        }else{
                            viewModel.msg = "UserID must be Number."
                        }
                    }
                    
                }){
                    Text("Start Event")
                }.frame(maxWidth: .infinity,alignment:.trailing)
            }
            }
        }
        }else{
            VStack{
                Spacer()
                VStack{
                    Text("Athlete Information :").frame(maxWidth:.infinity, alignment:.leading).font(.headline).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
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
                    Text(viewModel.event!.name).frame(maxWidth:.infinity, alignment:.leading).font(.headline).padding().overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)).foregroundColor(Color.blue)
                }.padding()
                Spacer()
                HStack{
                    Button(action:{
                        username = ""
                        userId = ""
                        grade = ""
                        viewModel.finish()
                    }){
                        Text("Finish")
                    }.buttonStyle(GrowingButtonBlue())
                    Button(action:{
                        username = ""
                        userId = ""
                        grade = ""
                        viewModel.cancelEvent()
                    }){
                        Text("Cancel")
                    }.buttonStyle(GrowingButtonRed())
                }
                Spacer()
        }
    }
    }
}


struct GrowingButtonBlue: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct GrowingButtonRed: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
