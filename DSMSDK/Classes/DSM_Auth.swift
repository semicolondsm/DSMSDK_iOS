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

            AF.request(
                self.baseURL+"/dsmauth/token",
                method: .post,
                parameters: requstBody,
                encoder: JSONParameterEncoder.default
            ).validate().responseData { res in
                switch res.result {
                case .success(let value):
                    if let token = try? JSONDecoder().decode(Token.self, from: value) {
                        handler(token, nil)
                    }
                case .failure(let error):
                    handler(nil, error)
                }
            }
        }
        
    }
    
    public func tokenRefresh(refresh_token: String, handler: @escaping (String?, AFError?)->Void){
        AF.request(
            self.baseURL+"/dsmauth/refresh",
            method: .get,
            headers: ["x-refresh-token":"Bearer "+refresh_token]
        ).validate().responseData { res in
            switch res.result {
            case .success(let value):
                if let token = try? JSONDecoder().decode(Token.self, from: value) {
                    handler(token.Access_Token, nil)
                }
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
    
    public func me(access_token: String, handler: @escaping (PersonInfo?, AFError?)->Void){
        AF.request(
            self.baseURL+"/v1/info/basic",
            method: .get,
            headers: ["Authorization":"Bearer "+access_token]
        ).validate().responseData { res in
            switch res.result {
            case .success(let value):
                if let personInfo = try? JSONDecoder().decode(PersonInfo.self, from: value) {
                    handler(personInfo, nil)
                }
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
}
