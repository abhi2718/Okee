//
//  ScreenTimeSelectAppsContentView.swift
//  Okee
//
//  Created by Abhishek Singh on 05/12/24.
//

import SwiftUI

struct ScreenTimeSelectAppsContentView: View {
   
    @State private var pickerIsPresented = false
    @Binding var model: ScreenTimeSelectAppsModel
    

    var body: some View {
        Button {
            pickerIsPresented = true
        } label: {
            Text("Select Apps")
        }
        .familyActivityPicker(
            isPresented: $pickerIsPresented,
            selection: $model.activitySelection
        )
        
    }
}

#Preview {
    let model = ScreenTimeSelectAppsModel()
    //ScreenTimeSelectAppsContentView(model: $model)
}
