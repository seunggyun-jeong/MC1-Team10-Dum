//
//  File.swift
//  
//
//  Created by Lee Juwon on 2023/03/29.
//

import Foundation

class LeafViewModel: ObservableObject {
    @Published var countLeaf = 10
    
    func removeLeaf() {
        self.countLeaf -= 1
    }
}
