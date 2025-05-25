/*
- Only parentheses () are considered; other brackets or characters should be ignored.
- The input string might contain multiple lines.
- For example, "(())" is balanced, but "(()" is not.
*/

import Foundation


public func isBalancedParentheses(input: String) -> Bool {
    // no need for stack because we only consider ()
    var balance = 0
    
    // iteration over whole input and incremeting or decrementing balance
    for char in input {
        if char == "(" {
            balance += 1
        } else if char == ")" {
            balance -= 1
            // need to check negative balance, because ")(" is incorrect, but balance at the end would be 0 in that case
            if balance < 0 { return false }
        }
    }

    // true if balance is 0, otherwise false
    return balance == 0
}


// TESTS
fileprivate func runTests() {
    assert(isBalancedParentheses(input: "") == true)
    assert(isBalancedParentheses(input: "hello, world!") == true)
    
    assert(isBalancedParentheses(input: "()") == true)
    assert(isBalancedParentheses(input: "()()") == true)
    assert(isBalancedParentheses(input: "(())") == true)
    assert(isBalancedParentheses(input: "(()(()))()") == true)
    
    assert(isBalancedParentheses(input: "(") == false)
    assert(isBalancedParentheses(input: ")") == false)
    assert(isBalancedParentheses(input: ")(") == false)
    assert(isBalancedParentheses(input: "(()") == false)
    assert(isBalancedParentheses(input: "())") == false)
    
    assert(isBalancedParentheses(input: "a(b)c") == true)
    assert(isBalancedParentheses(input: "a(b)c)d(e)f(") == false)
    
    let multilineBalanced = """
        (
        ())
        ()
        """
    assert(isBalancedParentheses(input: multilineBalanced) == true)
    
    let multilineUnbalanced = """
        ((
        )()
        """
    assert(isBalancedParentheses(input: multilineUnbalanced) == false)
    
    print("all tests passed")
}


// runTests()