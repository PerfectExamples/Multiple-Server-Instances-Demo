//
//  Shipment.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//  Modified from the Perfect Template Project

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import SQLiteStORM

Database().create()

// Configuration data for two example servers.
// This example configuration shows how to launch one or more servers 
// using a configuration dictionary.

let port1 = 8080, port2 = 8181

let publicRoutes = [
    ["method":"get", "uri":"/", "handler":handler],
    ["method": "post", "uri":"/track", "handler": trackShipment],
]

let privateRoutes = publicRoutes + [
    ["method":"get", "uri":"/count", "handler": count],
    ["method":"post", "uri":"/create", "handler": createShipment],
    ["method":"post", "uri":"/set/delivered", "handler": setShipmentDelivered],
    ["method":"post", "uri":"/update", "handler": updateShipment],
    ["method":"post", "uri":"/delete", "handler": removeShipment],
]

let config = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves only public API routes
		[
			"name":"Public API",
			"port":port1,
			"routes": publicRoutes,
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		],
		// Configuration data for another server which:
		//	* Serves Private Routes, as well as all public API routes
		[
			"name":"Private API",
			"port":port2,
			"routes": privateRoutes,
//			"filters":[
//                ["type":"request",
//                "priority":"high",
//                "name": AuthFilter()]
//            ]
		]
	]
]

SQLiteConnector.db = "./db/database"

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: config)
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

