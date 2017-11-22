//
//  Extension.swift
//  SetOfPractice
//
//  Created by 배지영 on 2017. 11. 15..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation

extension Array {
    func remove(index:Int) -> Array {
        var newArr = Array()
        for i in 0...self.count-1 {
            if index != i {
                newArr.append(self[i])
            }
        }
        return newArr
    }
    
}

extension String {
    func extract(from:Int, to:Int) -> String {
        let chars = Array(self)
        var newStr = ""
        for index in from...to {
            newStr += String(chars[index])
        }
        return newStr
    }
    
    func except(from:Int, to:Int) -> String {
        let chars = Array(self)
        var newStr = ""
        var current = 0
        for char in chars {
            if current < from || to < current {
                newStr += String(char)
            }
            current += 1
        }
        return newStr
    }
    
    func split(endOfPart:Int...) -> [String] {
        var parts = endOfPart
        if endOfPart.last != self.count - 1 {
            parts.append(self.count - 1)
        }
        var result = [String]()
        var start = 0
        for end in parts {
            result.append(extract(from: start, to: end))
            start = end + 1
        }
        return result
    }
    
    func read(index:Int) -> Character? {
        var current = 0
        for char in self {
            if current == index {
                return char
            }
            current += 1
        }
        return nil
    }
    
    
    
}

