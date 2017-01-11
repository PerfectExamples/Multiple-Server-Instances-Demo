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

// This is the main 'handler' function to put a standard message on get requests to the root uri
func handler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        // Respond with a simple message.
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>Hello, shipments!</title><body><p>You can use this system to retrieve data about our shipments, such as sending a json post request to /track with a trackingNumber property containing the number you would like to track, assuming shipments have been added.</p></body></html>")
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
}

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
        // Tracking a shipment using incoming JSON
        response.appendBody(string: Shipments().trackShipment(withJSONRequest: request.postBodyString ?? "Empty Body"))
        // Signalling that the request is completed
        response.completed()
    }
}
