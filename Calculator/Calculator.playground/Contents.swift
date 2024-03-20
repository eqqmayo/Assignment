import Foundation

// Lv.3
/*
class Calculator {
    
    let add = AddOperation()
    let subtract = SubtractOperation()
    let multiply = MultiplyOperation()
    let devide = DivideOperation()
    let remain = RemainOperation()
    
    func calculate(op: String, num1: Double, num2: Double) -> Double {
        switch op {
        case "+":
            return add.calculate(num1, num2)
        case "-":
            return subtract.calculate(num1, num2)
        case "*":
            return multiply.calculate(num1, num2)
        case "/":
            return devide.calculate(num1, num2)
        case "%":
            return Double(remain.calculate(Int(num1), Int(num2)))
        default:
            return 0
        }
    }
}
    
class AddOperation {
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}

class SubtractOperation {
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

class MultiplyOperation {
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}

class DivideOperation {
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        if num2 == 0 { return 0 }
        return num1 / num2
    }
}
    
class RemainOperation {
    func calculate(_ num1: Int, _ num2: Int) -> Int {
        if num2 == 0 { return 0 }
        return num1 % num2
    }
}

let calculator = Calculator()

let addResult = calculator.calculate(op: "+", num1: 2, num2: 3)
let subtractResult = calculator.calculate(op: "-", num1: 2, num2: 3)
let multiplyResult = calculator.calculate(op: "*", num1: 2, num2: 3)
let divideResult = calculator.calculate(op: "/", num1: 2, num2: 3)
let remainResult = calculator.calculate(op: "%", num1: 2, num2: 3)
 
*/


// Lv.4
class Calculator {
    
    var op: String
    
    init(op: String) {
        self.op = op
    }
    
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        var operation: AbstractOperation
        
        switch op {
        case "+":
            operation = AddOperation()
        case "-":
            operation = SubtractOperation()
        case "*":
            operation = MultiplyOperation()
        case "/":
            operation = DivideOperation()
        default:
            return 0
        }
        return operation.calculate(num1, num2)
    }
}

class AbstractOperation {
    func calculate(_ num1: Double, _ num2: Double) -> Double {
        return 0
    }
}

class AddOperation: AbstractOperation {
    override func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}

class SubtractOperation: AbstractOperation {
    override func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

class MultiplyOperation: AbstractOperation {
    override func calculate(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}

class DivideOperation: AbstractOperation {
    override func calculate(_ num1: Double, _ num2: Double) -> Double {
        if num2 == 0 { return 0 }
        return num1 / num2
    }
}

var calculator = Calculator(op: "+")
let addResult = calculator.calculate(5, 3)

calculator = Calculator(op: "-")
let subtractResult = calculator.calculate(5, 3)

calculator = Calculator(op: "*")
let multiplyResult = calculator.calculate(5, 3)

calculator = Calculator(op: "/")
let divideResult = calculator.calculate(5, 3)


