//
//  TranscriptView.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 30/11/2021.
//

import SwiftUI


struct TranscriptDisplayView: View {
    @ObservedObject var model = TranscriptViewModel()
    var body: some View {
        
        VStack{
            Divider()
            HStack() {
                Text("Athlete Name").frame(maxWidth: .infinity)
                Text("Athlete No.").frame(maxWidth: .infinity)
                Text("Competition Event").frame(maxWidth: .infinity)
                Text("DAvg").frame(maxWidth: .infinity)
                Text("EAvg").frame(maxWidth: .infinity)
                Text("Total").frame(maxWidth: .infinity).foregroundColor(.red)
            }
            List(model.list, id:\.id){item in
                        HStack() {
                            Text(item.name).frame(maxWidth: .infinity)
                            Text(String(item.id)).frame(maxWidth: .infinity)
                            Text(item.eventName).frame(maxWidth: .infinity)
                            Text(String(item.DAvg)).frame(maxWidth: .infinity)
                            Text(String(item.EAvg)).frame(maxWidth: .infinity)
                            Text(String(item.Total)).frame(maxWidth: .infinity)
                                    
                        }
            }
            .onAppear(){
                model.getData()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}
