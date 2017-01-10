//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import SQLiteStORM

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(data: [String:Any]) throws -> RequestHandler {
	return {
		request, response in
		// Respond with a simple message.
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html><title>Hello, shipments!</title><body><p>You can get use this system to retrieve data about our shipments</p><ul><li><a href=\"/count\">Get a count!</a></li></ul></body></html>")
		// Ensure that response.completed() is called when your processing is done.
		response.completed()
	}
}

// Configuration data for two example servers.
// This example configuration shows how to launch one or more servers 
// using a configuration dictionary.

let port1 = 8080, port2 = 8181

let config = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"Public API",
			"port":port1,
			"routes":[
				["method":"get", "uri":"/", "handler":handler],
				["method":"get", "uri":"/count", "handler": count],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		],
		// Configuration data for another server which:
		//	* Redirects all traffic back to the first server.
		[
			"name":"Private API",
			"port":port2,
			"routes":[
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.redirect,
				 "base":"http://localhost:\(port1)"]
			]
		]
	]
]

SQLiteConnector.db = "./db/database"

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: config)
    Database().create()
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

