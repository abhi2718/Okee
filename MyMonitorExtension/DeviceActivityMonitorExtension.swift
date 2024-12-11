//
//  DeviceActivityMonitorExtension.swift
//  MyMonitorExtension
//
//  Created by Abhishek Singh on 05/12/24.
//
import MobileCoreServices
import DeviceActivity
import ManagedSettings
import Foundation
// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    override func intervalDidStart(for activity: DeviceActivityName) {
               super.intervalDidStart(for: activity)
               print("interval did start")
                let model = MyModel.shared
        
                let applications = model.selectionToDiscourage.applicationTokens
                store.shield.applications = applications.isEmpty ? nil : applications
                store.dateAndTime.requireAutomaticDateAndTime = true
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
        store.dateAndTime.requireAutomaticDateAndTime = false
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        print("eventDidReachThreshold -->")
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        print("intervalWillStartWarning -->")
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        print("intervalWillEndWarning -->")
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        print("eventWillReachThresholdWarning -->")
        // Handle the warning before the event reaches its threshold.
    }
}


