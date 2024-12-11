//
//  MyMonitorReportExtension.swift
//  MyMonitorReportExtension
//
//  Created by Abhishek Singh on 05/12/24.
//

import DeviceActivity
import SwiftUI

@main
struct MyMonitorReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
