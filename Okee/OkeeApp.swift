//
//  OkeeApp.swift
//  Okee
//
//  Created by Abhishek Singh on 05/12/24.
//

import SwiftUI
import FamilyControls

@main
struct OkeeApp: App {
    private let authorizationCenter = AuthorizationCenter.shared
    func requestFamilyAuthorization() {
        AuthorizationCenter.shared.requestAuthorization { result in
                 switch result {
                 case .success:
                     print("Success")
                 case .failure(let error):
                     print("error for screentime is \(error)")
                 }
             }
        
//        Task {
//            do {
//                try await authorizationCenter.requestAuthorization(for: .child)
//        
//            }
//            catch {
//                print("Error: \(error)")
//            }
//        }
        _ = AuthorizationCenter.shared.$authorizationStatus
                   .sink() {_ in
                   switch AuthorizationCenter.shared.authorizationStatus {
                   case .notDetermined:
                       print("not determined")
                   case .denied:
                       print("denied")
                   case .approved:
                       print("approved")
                   @unknown default:
                       break
                   }
               }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    requestFamilyAuthorization()
                }
        }
    }
}
