//
//  ContentView.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 28/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var role:Int = 0
//    var server = Server()
    var body: some View {
        
        if(role == 1){
            TabView{
                HomeView().tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
                TranscriptDisplayView().tabItem(){
                    Image(systemName: "folder.fill.badge.person.crop")
                    Text("Transcript")
                }
            }
        }else if(role == 2){
            HeadofJudges().tabItem(){
                Image(systemName: "person.text.rectangle.fill")
                Text("Head Of Judges")
            }
        }else{
            
            VStack(spacing:50){
                Text("Please Select a Role:")
                Button(action: {role = 1}){
                    HStack{
                        Text("Admin")
                        Image(systemName: "person.circle")
                    }
                    
                }
                Button(action: {role = 2}){
                    HStack{
                        Text("Head of Judges")
                        Image(systemName: "person.circle")
                    }
                    
                }
            }
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

