//
//  Common.swift
//  DSMSDK
//
//  Created by 김수완 on 2020/12/23.
//

import Foundation

final public class DSMSDKCommon{
    
    public static let shared = DSMSDKCommon()
    
    private var _client_id : String? = nil
    private var _client_secret : String? = nil
    private var _redirctURL : String? = nil
    
    public init(){
        _client_id = nil
        _client_secret = nil
        _redirctURL = nil
    }
    
    public static func initSDK(client_id : String, client_secret : String, redirctURL : String){
        DSMSDKCommon.shared.initialize(client_id : client_id, client_secret : client_secret, redirctURL : redirctURL)
    }
    
    private func initialize(client_id : String, client_secret : String, redirctURL : String){
        _client_id = client_id
        _client_secret = client_secret
        _redirctURL = redirctURL
        DSMAuth.shared.initialize(client_id: client_id,
                        client_secret: client_secret,
                        redirctURL: redirctURL)
    }
}
