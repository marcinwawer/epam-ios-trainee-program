/*
- The solution should ignore spaces, punctuation, capitalization and control characters.
- The solution should not use any third-party libraries or regular expressions.
- The solution should not consider an empty string or a single character as a palindrome.
*/

import Foundation


public func isPalindrome(input: String) -> Bool {
    // normalizing given input to match requirements, making a char array from this to get direct accesst to input[]
    let normalizedStringArr = Array(normalizeString(input))
    
    // input length after normalization cannot be shorter than 1
    let length = normalizedStringArr.count
    guard length > 1 else { return false }

    // checking if letter from first half of string is equal to the letter from other half, until the loop get to the middle, then we know its palindrome
    for i in 0..<(length / 2) {
        if normalizedStringArr[i] != normalizedStringArr[length-1-i] {
            return false
        }
    }

    return true
}


fileprivate func normalizeString(_ input: String) -> String {
    // set of characters the palindrome function should ignore
    let ignoredChars = CharacterSet.whitespacesAndNewlines
        .union(.punctuationCharacters)
        .union(.controlCharacters)

    // filtering input with the above set
    let filtered = input.unicodeScalars
        .filter { !ignoredChars.contains($0) }
        .map { Character($0) }

    // ingoring capitalization as stated
    return String(filtered).lowercased()
}


// TESTS
fileprivate func runTests() {
    assert(isPalindrome(input: "") == false)
    assert(isPalindrome(input: "a") == false)
    assert(isPalindrome(input: "hello") == false)
    assert(isPalindrome(input: "12345") == false)
    assert(isPalindrome(input: "this is not a palindrome") == false)

    assert(isPalindrome(input: "abba") == true)
    assert(isPalindrome(input: "RaceCar") == true)
    assert(isPalindrome(input: "A man, a plan, a canal: Panama") == true)
    assert(isPalindrome(input: "1a2b2a1") == true)

    assert(isPalindrome(input: "123\u{0001}21") == true)
    assert(isPalindrome(input: "step on n,o. pets") == true)
    assert(isPalindrome(input: "never odd or \neven") == true)
    assert(isPalindrome(input: "race.car") == true)

    let multilineStr = """
        nurses
        run
    """
    assert(isPalindrome(input: multilineStr) == true)

    print("all tests passed")
}


// runTests()