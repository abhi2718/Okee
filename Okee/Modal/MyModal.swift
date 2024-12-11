//
//  MyModal.swift
//  Okee
//
//  Created by Abhishek Singh on 10/12/24.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class MyModel: ObservableObject {
    static let shared = MyModel();
    let center = DeviceActivityCenter()
    let store = ManagedSettingsStore()

    private init() {}

    var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            let applications = newValue.applicationTokens
            let categories = newValue.categoryTokens
            let webCategories = newValue.webDomainTokens
            store.shield.applications = applications.isEmpty ? nil : applications
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
            store.shield.webDomains = webCategories
        }
    }

    func initiateMonitoring() {
        // Get the current date and time when the function is called
        let now = Date()
        
        // Extract the hour and minute components from the current time
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        // Calculate the time 30 minutes from now
        if let endDate = calendar.date(byAdding: .minute, value: 30, to: now) {
            let endHour = calendar.component(.hour, from: endDate)
            let endMinute = calendar.component(.minute, from: endDate)
            
            // Create the schedule with the dynamic start and end times
            let schedule = DeviceActivitySchedule(
                intervalStart: DateComponents(hour: currentHour, minute: currentMinute),
                intervalEnd: DateComponents(hour: endHour, minute: endMinute),
                repeats: true,
                warningTime: nil
            )
            
            do {
                try center.startMonitoring(.daily, during: schedule)
            } catch {
                print("Could not start monitoring \(error)")
            }
            
            store.dateAndTime.requireAutomaticDateAndTime = true
            store.account.lockAccounts = true
            store.passcode.lockPasscode = true
            store.siri.denySiri = true
            store.appStore.denyInAppPurchases = true
            store.appStore.maximumRating = 200
            store.appStore.requirePasswordForPurchases = true
            store.media.denyExplicitContent = true
            store.gameCenter.denyMultiplayerGaming = true
            store.media.denyMusicService = false
        } else {
            print("Could not calculate the end time")
        }
    }

    func stopMonitoring() {
        center.stopMonitoring([.daily])
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}
