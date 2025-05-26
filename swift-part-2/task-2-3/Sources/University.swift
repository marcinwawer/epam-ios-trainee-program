import Foundation

// no need for custom init, because we have memberwise init
struct University {

    let name: String
    let location: String

    var desription: String {
        "University \(name) in \(location)"
    }
}