//import SwiftUI
//import FamilyControls
//import DeviceActivity
//
//struct ContentView: View {
//    @State var model = ScreenTimeSelectAppsModel()
//    let center = DeviceActivityCenter()
//    @State var activities: [DeviceActivityName] = []
//    
//    func scheduleActivity() {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        
//    
//        
//        // **Start time (when button is clicked)**
//        let intervalStart = calendar.dateComponents([.hour, .minute, .second], from: currentDate)
//        
//        // **End time (60 minutes after start)**
//        if let intervalEndDate = calendar.date(byAdding: .minute, value: 60, to: currentDate) {
//            let intervalEnd = calendar.dateComponents([.hour, .minute, .second], from: intervalEndDate)
//            
//            let dynamicSchedule = DeviceActivitySchedule(
//                intervalStart: intervalStart,
//                intervalEnd: intervalEnd,
//                repeats: false
//            )
//            
//            let timeLimitMinutes = 1
//            let selection = model.activitySelection
//            let event = DeviceActivityEvent(
//                applications: selection.applicationTokens,
//                categories: selection.categoryTokens,
//                webDomains: selection.webDomainTokens,
//                threshold: DateComponents(minute: timeLimitMinutes)
//            )
//            
//            let activity = DeviceActivityName("MyApp.ScreenTime")
//            let eventName = DeviceActivityEvent.Name("MyApp.SomeEventName")
//            
//            do {
//                try center.startMonitoring(
//                    activity,
//                    during: dynamicSchedule,
//                    events: [
//                        eventName: event
//                    ]
//                )
//                print("Activity monitoring started successfully at \(currentDate). It will end at \(intervalEndDate).")
//            } catch {
//                print("Failed to start monitoring: \(error.localizedDescription)")
//            }
//        } else {
//            print("Failed to calculate the interval end time.")
//        }
//    }
//    
//    func stopActivity() {
//        center.stopMonitoring([DeviceActivityName("MyApp.ScreenTime")])
//        print("Activity monitoring stopped.")
//    }
//    
//    var body: some View {
//        VStack {
//            ScreenTimeSelectAppsContentView(model: $model)
//            
//            Button(action: scheduleActivity) {
//                Text("Track All Selected Apps Activity")
//            }
//            .buttonStyle(.bordered)
//            .padding([.top],20)
//            
//            Button(action: stopActivity) {
//                Text("Stop Activity")
//            }
//            .buttonStyle(.bordered)
//            .padding([.top,.bottom],20)
//            
//            Button {
//                print(center.activities);
//                activities = center.activities
//            } label: {
//                Text("All Activity")
//            }
//            .buttonStyle(.bordered)
//            .buttonStyle(.bordered)
//            .padding([.top,.bottom],20)
//        }
//        .padding()
//        if activities.count > 0 {
//            VStack {
//                Text("Activity")
//                ForEach(activities, id: \.self) { activity in
//                    Text("\(activity.rawValue)")
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI
import FamilyControls

struct ContentView: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false
    
    var body: some View {
        Button("Select Apps to Discourage") {
            isPresented = true
        }
        .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
        Button("Start Monitoring") {
            model.initiateMonitoring()
        }
        Button("Stop Monitoring") {
            model.stopMonitoring()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
