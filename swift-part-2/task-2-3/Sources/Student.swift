import Foundation 

class Student: Person {

    // this is a static var so it needs to be concurrency safe, otherwise an error (part of swift conccurrency safety checks), so for the sake of this task I just silent this warning
    nonisolated(unsafe) static var studentCount = 0
    
    let studentID: String
    var major: String
    weak var advisor: Professor?

    var formattedID: String {
        "ID: \(self.studentID)".uppercased()
    }


    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)

        Self.studentCount += 1
    }

    // init for basic student
    convenience init(name: String) {
        let id = "S" + String(Self.studentCount)

        self.init(name: name, age: 18, studentID: id, major: "not started")
    }


    deinit {
        print("deinit student \(self.profileDescription)")
        Self.studentCount -= 1
    }
}