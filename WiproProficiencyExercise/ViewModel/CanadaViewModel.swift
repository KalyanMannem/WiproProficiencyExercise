//
//  CanadaViewModel.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation

class CanadaViewModel: NSObject
{
    var dataModel: CanadaDataModel!
    func getCanadaDetails(url : String, completion: @escaping (Result<CanadaDataModel,APIServiceError>) -> ())
    {
        APIClient().getDataFrom(for: CanadaDataModel.self, url: url) {[weak self](result) in
            switch result
            {
            case .success(let data):
                self?.dataModel = data
                completion(.success(self!.dataModel))
            case .failure(let error):
                print(error)
            }
        }
    }
}
