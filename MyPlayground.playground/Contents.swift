//: Playground - noun: a place where people can play

import UIKit

let dateFormatter = DateFormatter()
let inputDate = "11/12/2013"
dateFormatter.dateFormat = "MM-dd-yyyy" //iso 8601

let outputDate = dateFormatter.date(from: inputDate)

