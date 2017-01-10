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
        var response = "Error"
        
        do {
            let count = try ShipmentManager().countTotalShipments()
            let data: [String: Any] = ["count": count]
            response = try data.jsonEncodedString()
        } catch {
            print("Failed to get shipment count")
        }
        
        return response
    }
}
