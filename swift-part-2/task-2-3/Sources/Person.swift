import Foundation

class Person {

    static let minAgeForEnrollment = 16

    var name: String
    var age: Int

    var isAdult: Bool {
        age >= 18
    }

    lazy var profileDescription = "\(name) is \(age) years old."


    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // cannot initialize with name value, because it will be the same as designated initializer
    init?(age: Int) {
        guard age >= Self.minAgeForEnrollment else {
            print("person must be at least 16 years old")
            return nil
        }

        self.name = "unknown"
        self.age = age
    }
}