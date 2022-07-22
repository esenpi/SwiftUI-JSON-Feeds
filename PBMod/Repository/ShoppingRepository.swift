
import CoreData
import SwiftUI
class ShoppingRepository: ObservableObject {
    
    @Published var shoppingShowToast = false
    
    func addProduct(productName:String) {
        
        withAnimation {
            let product = Item(context: PersistenceController.shared.container.viewContext)
            product.productName = productName
            
            if (product.productName == nil || product.productName == ""){
                shoppingShowToast = true
            } else if (product.productName == " "){
                //This area can be expanded with various of scenarios e.g. using strange characters etc. and showing an error message to the user
                print("WHY? (╯°□°)╯︵ ┻━┻")
            } else {
                saveContext()
            }
            
        }
    }
    
    private func saveContext() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            shoppingShowToast = true
            let error = error as NSError
            fatalError("\(K.ErrorMessages.AN_ERROR_OCCURED): \(error)")
        }
    }
    
    public func deleteIndex(at offsets: IndexSet) {
        do{
            let fetchRequest: NSFetchRequest<Item>
            fetchRequest = Item.fetchRequest()
            // Perform the fetch request
            let productObjects = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        for index in offsets {
              let productObjectsIndex = productObjects[index]
            PersistenceController.shared.container.viewContext.delete(productObjectsIndex)
          }
            try PersistenceController.shared.container.viewContext.save()
        }catch{
            shoppingShowToast = true
            let error = error as NSError
            fatalError("\(K.ErrorMessages.AN_ERROR_OCCURED): \(error)")
        }
    }
}
