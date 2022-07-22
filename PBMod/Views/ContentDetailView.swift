
import SwiftUI

struct ContentDetailView: View {
    
    var pbModModelItem: FetchedResults<PBModelItem>.Element?
    var networkShopping = ShoppingRepository()
    var body: some View {

        // checking which type of tiles needs to be shown 
        if (pbModModelItem!.name == K.Tiles.IMAGE){
            ImageContentDetailView(pbModModelItemImage: pbModModelItem)
        }
        else if(pbModModelItem!.name == K.Tiles.VIDEO){
            VideoContentDetailView(pbModModelItemVideo:pbModModelItem)
        }
        else if(pbModModelItem!.name == K.Tiles.WEBSITE){
            
            WebsiteContentDetailView(url: URL(string:pbModModelItem!.data!)!)
        }
        
        else{
            ShoppingContentDetailView().environmentObject(networkShopping)
        }
    }
}



struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
