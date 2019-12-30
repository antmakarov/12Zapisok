//
//  Logger.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

enum LogLevel {
    case DEBUG, INFO, ERROR, NETWORK, MARK;
    
    fileprivate func emotionLevel() -> String {
        var emotion = ""
        switch self {
        case .DEBUG:
            emotion =  "\u{0001F937} "
        case .INFO:
            emotion =  "\u{0001F446} "
        case .ERROR:
            emotion =  "\u{0001F621} "
        case .NETWORK:
            emotion = "\u{0001F310} "
        case .MARK:
            emotion =  "\u{0001F340} "
        }
        
        return emotion + "\(self)" + " ➯ "
    }
}

class Logger {
    static func debug(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function, type: LogLevel = .DEBUG) {
        
        var fullLogMessage = type.emotionLevel()
        fullLogMessage += Logger.getCurrentTime() + ": "
        fullLogMessage += URL(fileURLWithPath: fileName).deletingPathExtension().lastPathComponent + " ➯ "
        fullLogMessage += funcName + ":"
        fullLogMessage += "\(line) ➯ "
        
        print(fullLogMessage, msg)
    }
    
    static func error(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: msg as Any, line, fileName, funcName, type: .ERROR)
    }
    
    static func info(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: msg as Any, line, fileName, funcName, type: .INFO)
    }
    
    static func mark(_ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: "MARK", line, fileName, funcName, type: .MARK)
    }
    
    // Current UTC time
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd/HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }
}
