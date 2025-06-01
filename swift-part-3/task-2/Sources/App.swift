import Foundation

@main
struct App {
    static func main() {
        runApp()
    }
}

fileprivate func runApp() {
    var mySchool = School()

    let alice = School.Person(name: "Alice", role: .student)
    let bob = School.Person(name: "Bob", role: .teacher)
    let charlie = School.Person(name: "Charlie", role: .administrator)
    let diana = School.Person(name: "Diana", role: .student)
    let eve = School.Person(name: "Eve", role: .teacher)

    mySchool.addPerson(alice)
    mySchool.addPerson(bob)
    mySchool.addPerson(charlie)
    mySchool.addPerson(diana)
    mySchool.addPerson(eve)
    mySchool.addPerson(alice) // duplicate

    print("Number of students: \(countStudents(at: mySchool))")
    print("Number of teachers: \(countTeachers(at: mySchool))")
    print("Number of administrators: \(countAdministrators(at: mySchool))")

    print("List of students:")
    for student in mySchool[.student] {
        print("- \(student.name)")
    }
}