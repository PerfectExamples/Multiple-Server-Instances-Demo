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
    var trackingNumber: String = "Error"
    var lastLocation: String = "Error"
    var destination: String = "Error"
    private var delivered: Int = 0
    
    var isDelivered: Bool {
        get {
            return delivered == 1
        }
    }
    
    override open func table() -> String { return "shipments" }
    
    override func to(_ this: StORMRow) {
        id = this.data["id"] as? Int ?? 0
        trackingNumber = this.data["trackingNumber"] as? String ?? "Unknown Tracking Number"
        lastLocation = this.data["lastLocation"] as? String ?? "Not Yet Available"
        destination = this.data["destination"] as? String ?? "Not on File"
        delivered = this.data["delivered"] as? Int ?? 0
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
