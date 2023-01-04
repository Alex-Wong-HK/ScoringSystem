//
//  Transcript.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 30/11/2021.
//

import Foundation

struct Transcript:Identifiable, Hashable{
    var name:String
    var id:Double
    var userID:Int
    var eventName:String
    var DAvg:Int
    var EAvg:Int
    var Total:Int
}
