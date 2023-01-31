//
//  TableViewModel.swift
//  MVP_Project
//
//  Created by Николай Ногин on 05.09.2022.
//

import UIKit

class ResultsModel {
    
    var results: [Film] = [Film]()

    
    let errorItem: Film = Film(
        description: "Bad Response From The Server", id: "1",
        image: Constants.errorImg, title: "ERROR OCCURED"
    )
        
}
