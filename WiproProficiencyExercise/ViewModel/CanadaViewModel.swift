//
//  CanadaViewModel.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation

class CanadaViewModel{
    func getCanadaDetails(url : String, completion: @escaping (Result<CanadaDataModel,APIServiceError>) -> ()){
        APIClient().getDataFrom(for: CanadaDataModel.self, url: url) {(result) in
         completion(result)
        }
    }
}
