//
//  Handlers.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

func count(data: [String:Any]) throws -> RequestHandler {
    
    return {
        request, response in
        
        // Get json data to repond with
        let data = Shipments().getCount()
        
        // Respond with our json.
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string: data)
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
}

func trackShipment(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        
        // Setting the response content type explicitly to application/json
        response.setHeader(.contentType, value: "application/json")
        // Adding a new "person", passing the just the request's post body as a raw string to the function.
        response.appendBody(string: Shipments().trackShipment(withJSONRequest: request.postBodyString ?? "Empty Body"))
        // Signalling that the request is completed
        response.completed()
    }
}
