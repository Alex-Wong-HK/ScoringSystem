//
//  Home.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 29/11/2021.
//

import Foundation
import SwiftUI

struct HomeView:View{
    @ObservedObject var model = CompetitionsViewModel()
    @State private var alertIsPresented = false
    @State var eventName:String = ""

    var body: some View{
        
        NavigationView{
            
            VStack{
            List(model.list, id:\.id){item in NavigationLink(destination: AthleteView(competitions: item)){
                Text(item.name)
            }
            }.onAppear(perform: {model.getData()})
                .navigationTitle("Click Here To Select Event")
            
            
            
            
            
            VStack{
                TextField("Event Name", text: $eventName).frame(maxWidth: .infinity).padding().multilineTextAlignment(.center).textFieldStyle(.roundedBorder)
                Button(action:{
                                    print(alertIsPresented.toggle())
                                },label:{
                                    Text("Create").foregroundColor(.white).bold().font(.caption)
                                }).frame(width:80,height: 30,alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .alert(isPresented: $alertIsPresented, content: {
                                    Alert(
                                        title:Text("Are You Sure?"),message: Text("To Add this Event("+eventName+")?"),
                                          primaryButton: .destructive(Text("Create"),action: {
                                              model.createEvent(eventName: eventName)
                                          }),
                                          secondaryButton: .cancel())
                                })
                Text(model.msg)
            }}
                  }
    }
}


