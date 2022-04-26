//
//  DataFactory.swift
//  itronDay
//
//  Created by Сергей Киселев on 12.03.2022.
//

import Foundation

struct Team {
    var number: String = ""
    var date: String = ""
    var event: String = ""
    
    init(raw: [String]) {
        number = raw[0]
        date = raw[1]
        event = raw[2]
    }
}

func loadCSV(from csvName: String) -> [Team] {
    var csvToStruct = [Team]()
    
    //locate the csv file
    guard let filePath = Bundle.main.url(forResource: csvName, withExtension: "csv") else {
        return[]
    }
    
    //convert the contents of the file into one very long string
    var data = ""
    do {
        data = try String(contentsOf: filePath)
    } catch {
        print(error)
        return[]
    }
    
    //split  the long string into an array of "rows"
    //detect "\n" carriage return< then split
    var rows = data.components(separatedBy: "\n")
    
    //count the number of header columns before removing
    let columnCount = rows.first?.components(separatedBy: ",").count
    //rows.removeAll()
    //remove header rows
    //rows.removeFirst()
    
    //if Team.date[] == "01.01.2021" {
    
    //now loop around each row and split into columns
    //if Team == "31.12.21"{
        for row in rows {
            let csvColumns = row.components(separatedBy: ",")
            let teamStruct = Team.init(raw: csvColumns)
            csvToStruct.append(teamStruct)
        }
    //}
//    else {
//        csvToStruct.append("")
//    }
    
    return csvToStruct
    
}
