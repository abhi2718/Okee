//
//  ScreenTimeSelectAppsModel.swift
//  Okee
//
//  Created by Abhishek Singh on 05/12/24.
//

import Foundation
import FamilyControls

class ScreenTimeSelectAppsModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}
