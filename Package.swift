// Generated automatically by Perfect Assistant Application
// Date: 2017-01-10 20:52:53 +0000
import PackageDescription
let package = Package(
    name: "MultipleServerInstances",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", versions: Version(2,0,0)..<Version(2,9223372036854775807,9223372036854775807)),
        .Package(url: "https://github.com/SwiftORM/SQLite-StORM.git", majorVersion: 1, minor: 0),
    ]
)