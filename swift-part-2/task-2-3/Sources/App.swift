import Foundation

@main
struct App {
    static func main() {
        runApp()
    }
}

fileprivate func runApp() {
    let uni = University(name: "Politechnika Wroclawska", location: "Wroclaw")
    print(uni.desription)
    print()

    let prof = Professor(name: "Mark", age: 42, faculty: "Computer Science")
    print(prof.fullTitle)
    print()

    let student1 = Student(name: "Alice", age: 20, studentID: "S1001", major: "Mathematics")
    print(student1.profileDescription)
    print(student1.formattedID)
    print("is adult? \(student1.isAdult)")
    student1.advisor = prof
    print()

    let student2 = Student(name: "Bob")
    print(student2.profileDescription)
    print(student2.formattedID)
    print("is adult? \(student2.isAdult)")
    print()

    if let personTooYoung = Person(age: 12) {
        print(personTooYoung.profileDescription)
    } else {
        print("failed to created person")
    }
    print()

    print("total students: \(Student.studentCount)")
    print("total professors: \(Professor.professorCount)")
    print()

    func testScope() {
        print(Student.studentCount)
        let temporaryStudent = Student(name: "Charlie")
        print(temporaryStudent.profileDescription)
        print(Student.studentCount)
    }

    print(Student.studentCount)
    testScope() 
    print(Student.studentCount)
}