//
//  DSM_Auth.swift
//  DSMSDK
//
//  Created by 김수완 on 2020/12/23.
//

import UIKit
import Alamofire

public let DSMAUTH = DSMAuth.shared

public class DSMAuth {
    static public let shared = DSMAuth()
    
    private var baseURL = "https://developer.ddyzd.click"
    
    private var _client_id: String = ""
    private var _client_secret: String = ""
    private var _redirctURL: String = ""
    
    private var _code: String = ""
    
    private var complitionHandler: ((String)->Void)?
    
    public func initialize(client_id: String, client_secret: String, redirctURL: String){
        _client_id = client_id
        _client_secret = client_secret
        _redirctURL = redirctURL
    }
    
    
    
    public func  loginWithDSMAuth(vc: UIViewController, handler: @escaping (Token?, AFError?)->Void){
        let WKView = LoginWebViewViewController()
        WKView.initialize(client_id: _client_id,
                          redirctURL: _redirctURL)
        vc.present(WKView, animated: true)
        
        WKView.getCode{ code in
            let requstBody: [String : String] = [
                "client_id": self._client_id,
                "client_secret": self._client_secret,
                "code":code
            ]
            
            AF.request(self.baseURL+"/dsmauth/token", method: .post, parameters: requstBody, encoder: JSONParameterEncoder.default).validate().responseJSON{ res in
                switch res.result
                {
                case .success(let value):
                    if let processedValue = value as? [String : String] {
                        
                        
                        
                        let token = Token(Access_Token: processedValue["access_token"]!,
                                          Refresh_Token: processedValue["refresh_token"]!)
                        
                        handler(token, nil)
                    }
                case .failure(let error):
                    handler(nil,error)
                }
                
            }
        }
        
    }
    
    public func tokenRefresh(refresh_token: String, handler: @escaping (String?, AFError?)->Void){
        AF.request(self.baseURL+"/dsmauth/refresh", method: .get, headers: ["x-refresh-token":"Bearer "+refresh_token]).validate().responseJSON{ res in
            switch res.result
            {
            case.success(let value):
                if let processedValue = value as? [String:String]{
                    let accessToken = processedValue["access_token"]
                    
                    handler(accessToken, nil)
                }
            case .failure(let error):
                handler(nil,error)
            }
        }
    }
    
    public func me(access_token: String, handler: @escaping (personInfo?, AFError?)->Void){
        AF.request(self.baseURL+"/v1/info/basic", method: .get, headers: ["Authorization":"Bearer "+access_token]).validate().responseJSON{ res in
            switch res.result
            {
            case.success(let value):
                if let processedValue = value as? [String:String]{
                    let myInfo = personInfo(name: processedValue["name"]!,
                                            StudentID: processedValue["gcn"]!,
                                            email: processedValue["email"]!)
                    
                    handler(myInfo,nil)
                }
            case.failure(let error):
                handler(nil, error)
            }
        }
    }
}
