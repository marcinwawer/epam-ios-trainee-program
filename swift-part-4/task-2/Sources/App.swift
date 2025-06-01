import Foundation

protocol Shape {
    
    func area() -> Double
    func perimeter() -> Double
}

class Circle: Shape {
    
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        .pi * (radius * radius)
    }

    func perimeter() -> Double {
        2 * .pi * radius
    }
}

class Rectangle: Shape {
    
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        width * height
    }

    func perimeter() -> Double {
        (2 * width) + (2 * height)
    }
}

func generateShape() -> some Shape {
    Circle(radius: 5)
}

func calculateShapeDetails(shape: any Shape) -> (area: Double, perimeter: Double) {
    (shape.area(), shape.perimeter())
}



let circle = Circle(radius: 5)
print("Circle:")
print("Radius: \(circle.radius)")
print("Area: \(circle.area())")
print("Perimeter: \(circle.perimeter())\n")

let rectangle = Rectangle(width: 4, height: 7)
print("Rectangle:")
print("Width: \(rectangle.width), Height: \(rectangle.height)")
print("Area: \(rectangle.area())")
print("Perimeter: \(rectangle.perimeter())\n")

let shape = generateShape()
print("Generated shape:")
print("Area: \(shape.area())")
print("Perimeter: \(shape.perimeter())\n")

let details = calculateShapeDetails(shape: rectangle)
print("Calculated details:")
print("Area: \(details.area), Perimeter: \(details.perimeter)")