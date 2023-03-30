//
//  StageInformationClass.swift
//  
//
//  Created by Lee Juwon on 2023/03/30.
//

import Foundation

class StageInformationClass: ObservableObject {
    @Published var stageCounter: Int = 0
    
    func compeleteStage() {
        stageCounter += 1
    }
}
