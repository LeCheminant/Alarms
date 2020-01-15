//
//  AlarmController.swift
//  Alarm
//
//  Created by Jacob LeCheminant on 1/13/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(){
        
    }
    
    func cancelUserNotifications() {
        
    }
}

class AlarmController {
    var alarms: [Alarm] = []
    
    static let sharedInstance = AlarmController()
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)

        saveToPersistentStore()
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        saveToPersistentStore()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        
        saveToPersistentStore()
    }
    
    //MARK: Persistence
    
    func createFileURLForPersistence() -> URL {
        //Grab the users document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //Create the new fileURL on user's phone
        let fileURL = urls[0].appendingPathComponent("Alarm.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        //Create an instance of JSON Encoder
        let jsonEncoder = JSONEncoder()
        //Attempt to convert our alarms to JSON
        do {
            let jsonAlarm = try jsonEncoder.encode(alarms)
            // With the new json(d) alarm, save it to the users device
            try jsonAlarm.write(to: createFileURLForPersistence())
        } catch let encodingError {
            // Handle the error, if there is one
            print("There was an error saving!! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        // The data we want will be JSON, and I want it to be an Alarm
        let jsonDecoder = JSONDecoder()
        // Decode the data
        do {
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedAlarms
        } catch let decodingError {
            print("There was an error decoding!! \(decodingError.localizedDescription)")
        }
    }
    
} // End of class
