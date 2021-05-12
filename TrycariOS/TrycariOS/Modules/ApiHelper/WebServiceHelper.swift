//
//  WebServiceHelper.swift
//  TrycariOS
//
//  Created by Musthafa on 10/05/21.
//

import Foundation
import Alamofire



typealias SuccessBlock = (_ result: Data?) -> Void
typealias FailureBlock = (_ httpULResponse: URLResponse?, _ error: Error?) -> Void
typealias CompletionBlock = (_ result:Codable?, _ error:Error?) -> Void


protocol WebServiceHelperProtocol {

    
    func request<T: Codable>(_ apiEndPoint: String,
                             httpMethod: AMHttpMethod,
                             payload: Codable,
                             responseClass: T.Type,
                             completionBlock: @escaping CompletionBlock)
    
    func requestDataFromURL<T: Codable>(_ apiEndPoint: String,
                             responseClass: T.Type,
                             completionBlock: @escaping CompletionBlock)
}

class WebServiceHelper: WebServiceHelperProtocol {
    
    lazy var session: URLSession = createURLSession()
    
    private func createURLSession() -> URLSession {
        return URLSession(configuration: getSessionConfiguration())
    }
    
    private func getSessionConfiguration() -> URLSessionConfiguration {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120
        sessionConfig.timeoutIntervalForResource = 0
        sessionConfig.httpAdditionalHeaders = [:]
        return sessionConfig
    }    
    
    func request<T>(_ apiEndPoint: String, httpMethod: AMHttpMethod, payload: Codable, responseClass: T.Type, completionBlock: @escaping CompletionBlock) where T : Decodable, T : Encodable {
        
    }
    
    func requestDataFromURL<T>(_ apiEndPoint: String, responseClass: T.Type, completionBlock: @escaping CompletionBlock) where T : Decodable, T : Encodable {
        let url = URL(string: "\(WebServiceURLs.baseURL)\(apiEndPoint)" )!
        let task = session.dataTask(with: url) { jsonData, response, error in
           
            guard error == nil else {
                print ("error: \(error!)")
               completionBlock(nil,error)
                return
            }
            
            guard let resultData = jsonData else {
                let noDataerror = WebServiceError.noInterNet
                completionBlock(nil,noDataerror)
                return
            }
            
            guard let result =  try? JSONDecoder().decode(responseClass.self, from: resultData) else {
                let noDataerror = WebServiceError.noInterNet
                completionBlock(nil,noDataerror)
                return
            }
            completionBlock(result,nil)
          
        }
        task.resume()
    }
}
