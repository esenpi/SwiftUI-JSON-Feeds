
import SwiftUI
import Kingfisher

struct ImageContentDetailView: View {
    var pbModModelItemImage: FetchedResults<PBModelItem>.Element?
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                KFImage(URL(string:pbModModelItemImage!.data ?? "")).resizable().scaledToFit().frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight*0.9,alignment: .top)
                
            }}.padding(.trailing,5)
        
    }
}

struct ImageContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageContentDetailView()
    }
}
