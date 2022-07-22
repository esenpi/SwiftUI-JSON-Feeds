
import SwiftUI
import CoreData
@main
struct PBModApp: App {
    
    let persistenceController = PersistenceController.shared
    var network = PBModRepository()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(network).environment(\.managedObjectContext, persistenceController.container.viewContext).onAppear{
                    dateFormatter.dateFormat = "YYYY/MM/dd"
                    if (UserDefaults.standard.bool(forKey: K.UDefaults.LOGIN)){
                        
                        print("testing purpose: true")
                        
                    }else{
                        
                        print("testing purpose: false")
                        
                        UserDefaults.standard.set(dateFormatter.string(from: Date.now),forKey:K.UDefaults.DATENOW)
                    }
                }
        }
    }
}
