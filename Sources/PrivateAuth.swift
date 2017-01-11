//
//  PrivateAuth.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/11/17.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct AuthFilter: HTTPRequestFilter {
    func filter(request: HTTPRequest, response: HTTPResponse, callback: (HTTPRequestFilterResult) -> ()) {
        
        let privateAPIKey = "13100E4F22B84AD0A11E"
        
        if let token = request.header(.custom(name: "token")) {
            if token == privateAPIKey {
                callback(.continue(request, response))
            }
        }
        
        callback(.halt(request, response))
    }
}
