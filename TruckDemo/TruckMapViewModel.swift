//
//  TruckMapViewModel.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 26/12/21.
//

import Foundation
import Alamofire
class TruckMapViewModel {
    var trucklistData : [TruckData]?
    
    func getTruckList(completion: @escaping ([TruckData]?) -> ()) {
        
        guard let urlString = URL(string: CoreConstants.truckListURLString) else { return }
        
        AF.request(urlString).responseDecodable { (reponse:DataResponse<TruckResponseData,AFError>) in
            switch reponse.result {
            case .success(let reponseData):
                self.trucklistData = reponseData.data
                completion(reponseData.data)
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
}

