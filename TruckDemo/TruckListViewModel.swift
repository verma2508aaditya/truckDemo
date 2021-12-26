//
//  TruckListViewModel.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 25/12/21.
//

import Foundation
import Alamofire
import ObjectMapper

class TruckListViewModel {
    
    // MARK: - Variables
    
    var trucklistData : [TruckData]?
    var filteredtrucklistData : [TruckData]?
    
    // MARK: - Get Data
    
    func getTruckList(completion: @escaping ([TruckData]?) -> ()) {
        
        guard let urlString = URL(string: CoreConstants.truckListURLString) else { return }
        
        AF.request(urlString).responseDecodable { (reponse:DataResponse<TruckResponseData,AFError>) in
            switch reponse.result {
            case .success(let reponseData):
                self.trucklistData = reponseData.data
                self.filteredtrucklistData = reponseData.data
                completion(reponseData.data)
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
}
