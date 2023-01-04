//
//  ContentView.swift
//  ScoringSystem
//
//  Created by Alex Wong on 27/11/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = AthleteViewModel()
    @StateObject var eventModel = eventViewModel()
    @State var index = 0
    var body: some View {
        
        if(index == 1){
            AthleteView(viewModel: model,eventModel: eventModel)
            
            
        }else if(index == 2){
            
            Judges_DscoreView(viewModel: model)
            
            
        }else if(index == 3){
            
            Judges_EscoreView(viewModel: model)
           
            
        }else{
            VStack(spacing:50){
                Text("Please Select Your Role:")
                Button(action:{index = 1} ){
                    HStack{
                        Text("AthleteView")
                        Image(systemName: "person.circle")
                    }
                }
                Button(action:{index = 2} ){
                    HStack{
                        Text("D-judge")
                        Image(systemName: "person.circle")
                    }
                }
                Button(action:{index = 3} ){
                    HStack{
                        Text("E-judge")
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
