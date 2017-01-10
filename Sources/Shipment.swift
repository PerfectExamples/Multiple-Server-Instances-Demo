//
//  Shipment.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//

import Foundation
import StORM
import SQLiteStORM

class Shipment: SQLiteStORM {
    
    var id: Int = 0
    var trackingNumber: String = "DEFAULT"
    var lastLocation: String = "Toronto, ON"
    var destinationAddress: String = "1234 Main St., New York, NY 10001"
    
    override open func table() -> String { return "shipments" }
    
    override func to(_ this: StORMRow) {
        id = this.data["id"] as? Int ?? 0
        trackingNumber = this.data["tracking_number"] as? String ?? "Unknown Tracking Number"
        lastLocation = this.data["last_hub"] as? String ?? "Not Yet Available"
        destinationAddress = this.data["destination"] as? String ?? "Not on File"
    }
    
    func rows() -> [Shipment] {
        var rows = [Shipment]()
        for i in 0..<self.results.rows.count {
            let row = Shipment()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
}
