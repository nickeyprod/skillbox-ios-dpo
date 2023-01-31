//
//  Monster.swift
//  Monster Track
//
//  Created by Николай Ногин on 15.12.2022.
//

struct Monster: Equatable, Codable {
    var name: String
    var level: Int?
    var pic: String
    
    init(name: String, level: Int?) {
        self.name = name
        self.level = level
        self.pic = name.lowercased()
    }
}
