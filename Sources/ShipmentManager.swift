//
//  ShipmentManager.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//

import Foundation
import SQLiteStORM

struct ShipmentManager {
    
    func countTotalShipments() throws -> Int {
        
        let package = Shipment()
        
        var count = 0
        
        do {
            let rows = try package.sqlRows("SELECT COUNT(*) FROM shipments", params: [])
            
            for row in rows {
                if let results = row.data["COUNT(*)"] as? Int {
                    count = results
                }
            }
            
        } catch {
            throw error
        }
        
        return count
    }
    
    func createNewShipment(toAddress address: String, fromTerminal terminal: String) throws -> Shipment {
        
        let trackingNumber = UUID()
        
        let obj = Shipment()
        obj.trackingNumber = "\(trackingNumber)"
        obj.destination = address
        obj.lastLocation = terminal
        
        do {
            try obj.save {id in obj.id = id as! Int }
        } catch {
            throw error
        }
        
        return obj
        
    }
    
    func getShipment(fromTrackingNumber trackingNumber: String) throws -> Shipment {
        
        let getObj = Shipment()
        var findObj = [String:Any]()
        
        findObj["trackingNumber"] = trackingNumber
        
        do {
            try getObj.find(findObj)
        } catch {
            throw error
        }
        print("Object fetched with id of: \(getObj.id), and tracking number of: \(getObj.trackingNumber)")
        
        return getObj
    }
    
    func getShipments(forAddress address: String) throws -> [Shipment] {
        
        var shipments = [Shipment]()
        let getObj = Shipment()
        
        do {
            try getObj.select(whereclause: "destination = $1", params: [address], orderby: ["id"])
            
            for row in getObj.rows() {
                shipments.append(row)
            }
        } catch {
            throw error
        }
        
        return shipments
    }
    
    func updateShipment(usingTrackingNumber trackingNumber: String, withNewDestination destination: String? = nil, updateLastLocation hub: String?) throws {
        
        do {
            let shipment = try getShipment(fromTrackingNumber: trackingNumber)
            
            if let address = destination {
                shipment.destination = address
            }
            
            if let location = hub {
                shipment.lastLocation = location
            }
            
            try shipment.save()
            
        } catch {
            throw error
        }
    }
    
    func removeShipment(usingTrackingNumber trackingNumber: String) throws {
        
        do {
            let shipment = try getShipment(fromTrackingNumber: trackingNumber)
            try shipment.delete()
        } catch {
            throw error
        }
        
    }
    
    func setShipmentDelivered(usingTrackingNumber trackingNumber: String) throws {
        
        do {
            let shipment = try getShipment(fromTrackingNumber: trackingNumber)
            
            shipment.setDelivered()
            try shipment.save()
            
        } catch {
            throw error
        }
        
    }
    
}
