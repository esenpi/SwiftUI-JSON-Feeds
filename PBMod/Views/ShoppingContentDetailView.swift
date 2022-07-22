
import SwiftUI
import CoreData
import AlertToast

struct ShoppingContentDetailView: View {
    
    @State public var productName: String = ""
    @EnvironmentObject var networkShopping: ShoppingRepository
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var products: FetchedResults<Item>
    
    var body: some View {
        VStack {
            TextField("Product name", text: $productName).padding().background(Color.black.opacity(0.1)).cornerRadius(15)
            HStack {
                Spacer()
                Button("Add") {
                  
                   networkShopping.addProduct(productName: productName)
            
                }.disabled(productName.isEmpty)
                Spacer()
                Button("Clear") {
                    productName = ""
                    
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            List {
                ForEach(products) { product in
                    HStack {
                        Text(product.productName ?? "Not found")
                        Spacer()
                        
                    }
                }.onDelete(perform: networkShopping.deleteIndex)
            }
            
        }.navigationTitle("Shopping List").toast(isPresenting: $networkShopping.shoppingShowToast){
            
            // `.alert` is the default displayMode
            AlertToast(displayMode: .banner(.pop), type: .error(.red), title: "\(K.ErrorMessages.AN_ERROR_OCCURED)")
            
            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
            
            //Choose .banner to slide/pop alert from the bottom of the screen
            //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
        }
        
        
    }
  
 
    
   
}

struct ShoppingContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingContentDetailView()
    }
}

