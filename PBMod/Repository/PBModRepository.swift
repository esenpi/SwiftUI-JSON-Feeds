
import Foundation
import CoreData
import SwiftUI

class PBModRepository: ObservableObject {
    @Published var users:[Tiles] = []
    @Published var showErrorMsg = false
    private func deleteContext() {
        
        do {
            let fetchRequest: NSFetchRequest<PBModelItem>
            fetchRequest = PBModelItem.fetchRequest()
            // Perform the fetch request
            let objects = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            // Delete the objects
            for object in objects {
                PersistenceController.shared.container.viewContext.delete(object)
            }
            
            // Save the deletions to the persistent store
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            showErrorMsg = true
            let error = error as NSError
            fatalError("\(K.ErrorMessages.AN_ERROR_OCCURED): \(error)")
          
        }
    }
    
    // MARK: Save Function - Save the data into local
    private func saveContext() {
        do {
            
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            showErrorMsg = true
            let error = error as NSError
            fatalError( "\(K.ErrorMessages.AN_ERROR_OCCURED): \(error)")
        }
    }
    func getData(){
        dateFormatter.dateFormat = "YYYY/MM/dd"
        // if user has opened (logged in into) the app for the first time then save the retrieved data into local storage
        if (UserDefaults.standard.bool(forKey: K.UDefaults.LOGIN)){
            /* If the user openes the app a second time during the same day then retrieve the local saved data and not from the server.
             The data time is being used for control this specific date with the userdefaults */
            if(UserDefaults.standard.string(forKey: K.UDefaults.DATENOW) == dateFormatter.string(from: Date.now)){
                
                print("Date does match")
                
            }else{
                
                deleteContext()
                guard let url = URL(string: K.DBPath) else {
                    showErrorMsg = true
                    print("Invalid URL")
                    return
                }
                
                do {
                  
                    let urlRequest = URLRequest(url: url)

                    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                        if let error = error {
                            print("Request error: ", error)
                            return
                        }

                        guard let response = response as? HTTPURLResponse else { return }

                        if response.statusCode == 200 {
                            guard let data = data else { return }
                            DispatchQueue.main.async {
                                do {
                                    let decodedUsers = try JSONDecoder().decode(Response.self, from: data)
                                    self.users = decodedUsers.tiles
                                    for i in 0..<self.users.count{
                                        
                                        let pbModList = PBModelItem(context: PersistenceController.shared.container.viewContext)
//                                        pbModList.id = Int64(self.users[i].id!)
                                        pbModList.name = self.users[i].name
                                        pbModList.data = self.users[i].data
                                        pbModList.headline = self.users[i].headline
                                        pbModList.subline = self.users[i].subline
                                        pbModList.score = Int64(self.users[i].score!)
                                        pbModList.date = dateFormatter.string(from: Date.now)
                                       
                                        
                                        self.saveContext()
                                    }
                                    UserDefaults.standard.set(dateFormatter.string(from: Date.now),forKey:K.UDefaults.DATENOW)
                                    UserDefaults.standard.set(true, forKey: K.UDefaults.LOGIN)
                                } catch let error {
                                    print("Error decoding: ", error)
                                }
                            }
                        }
                    }

                    dataTask.resume()
                    
                    
                } catch {
                    showErrorMsg = true
                    print("Invalid data")
                }
            }
        }else{
            guard let url = URL(string: K.DBPath) else {
                showErrorMsg = true
                print("Invalid URL")
                return
            }
            
            do {
                let urlRequest = URLRequest(url: url)

                let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        print("Request error: ", error)
                        return
                    }

                    guard let response = response as? HTTPURLResponse else { return }

                    if response.statusCode == 200 {
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                            do {
                                let decodedUsers = try JSONDecoder().decode(Response.self, from: data)
                                self.users = decodedUsers.tiles
                                for i in 0..<self.users.count{
                                    
                                    let pbModList = PBModelItem(context: PersistenceController.shared.container.viewContext)
//                                    pbModList.id = Int64(self.users[i].id!)
                                    pbModList.name = self.users[i].name
                                    pbModList.data = self.users[i].data
                                    pbModList.headline = self.users[i].headline
                                    pbModList.subline = self.users[i].subline
                                    pbModList.score = Int64(self.users[i].score!)
                                    pbModList.date = dateFormatter.string(from: Date.now)
                                    
                                    self.saveContext()
                                }
                                UserDefaults.standard.set(dateFormatter.string(from: Date.now),forKey:K.UDefaults.DATENOW)
                                UserDefaults.standard.set(true, forKey: K.UDefaults.LOGIN)
                            } catch let error {
                                print("Error decoding: ", error)
                            }
                        }
                    }
                }

                dataTask.resume()
     
                
            } catch {
                showErrorMsg = true
                print("Invalid data")
            }
          //  dataTask.resume()
        }

      
    }
}
