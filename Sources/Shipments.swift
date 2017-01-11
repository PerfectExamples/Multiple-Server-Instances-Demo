//
//  Shipments.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//

import Foundation

struct Shipments {
    
    func getCount() -> String {
        var response = "{\"Error\": \"An Unknown Error Occured\"}"
        
        do {
            let count = try ShipmentManager().countTotalShipments()
            let data: [String: Any] = ["count": count]
            response = try data.jsonEncodedString()
        } catch {
            print("Failed to get shipment count")
        }
        
        return response
    }
    
    func trackShipment(withTrackingNumber trackingNumber: String) -> String {
        var response = "{\"Error\": \"No Shipment Exists with the Specified Tracking Number\"}"
        
        do {
            let shipment = try ShipmentManager().getShipment(fromTrackingNumber: trackingNumber)
            let data: [String: Any] = ["Tracking Number": shipment.trackingNumber, "LastLocation": shipment.lastLocation, "Destination": shipment.destination]
            response = try data.jsonEncodedString()
        } catch {
            print("Failed to get tracking information for shipment")
        }
        
        return response
    }
    
    func trackShipment(withJSONRequest json: String) -> String {
        var response = "{\"Error\": \"No Shipment Exists with the Specified Tracking Number\"}"
        
        do {
            let dict = try json.jsonDecode() as! [String: String]
            
            if let trackingNumber = dict["trackingNumber"] {
                let shipment = try ShipmentManager().getShipment(fromTrackingNumber: trackingNumber)
                let data: [String: Any] = ["Tracking Number": shipment.trackingNumber, "LastLocation": shipment.lastLocation, "Destination": shipment.destination, "Delivered": shipment.isDelivered]
                response = try data.jsonEncodedString()
            }
        } catch {
            print("Failed to get shipment information for tracking number")
        }
        
        return response
    }
}
