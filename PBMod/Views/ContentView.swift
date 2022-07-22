
import SwiftUI
import CoreData
import Kingfisher
import AlertToast

struct ContentView: View {
    @EnvironmentObject var network: PBModRepository
    @FetchRequest(entity: PBModelItem.entity(), sortDescriptors: [])
    private var pbModList: FetchedResults<PBModelItem>
    
    init() {
 
        UITableView.appearance().backgroundColor = K.Brand.PBBackgroundColor
        
    }
    
    var body: some View {
        
        NavigationView {List(pbModList,id:\.self){ tilesIndex in
           
            VStack{
                VStack(spacing:0) {
                    HStack {
                        Text(tilesIndex.headline ?? "")
                            .font(.custom(K.Brand.Fonts.Headline, size: 25))
                            .foregroundColor(Color(uiColor: K.Brand.PBFontColor))
                            .fontWeight(.black).frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight*0.08).background(.white)
                        
                    }.border(Color(uiColor: K.Brand.PBLines),width:1)
                    
                    Spacer()
                    
                    
                    VStack {
                        GeometryReader { proxy in
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    KFImage(URL(string:tilesIndex.data ?? "")).resizable().placeholder {
                                        // Placeholder while downloading.
                                        Image(systemName: K.Media.PHOTO)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .font(.largeTitle)
                                            .opacity(0.3).frame(alignment: .center)
                                    }.frame(alignment: .center).aspectRatio(contentMode: .fit)
                                    Spacer()
                                    
                                }
                                Spacer()
                                
                            }
                        }
                        
                    }.aspectRatio(contentMode: .fit).frame(width:200, height: 200)
                    
                    Spacer().border(.red, width: 1.0)
                    
                    HStack(alignment: .bottom){
                        NavigationLink(destination:ContentDetailView(pbModModelItem: tilesIndex)) {
                            
                            Text(tilesIndex.subline ?? K.Tiles.LEARN_MORE)
                                .font(.headline)
                                .foregroundColor(Color(uiColor: K.Brand.PBFontColor)).frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight*0.08)
                                .minimumScaleFactor(0.5)
                            
                        }.padding([.all],10).background(.white)
                    }.border(Color(uiColor: K.Brand.PBLines),width:1)
                } //VStack
                .frame(maxWidth: .infinity, minHeight: UIScreen.screenHeight*0.40).padding(.all, 0)
                .overlay(RoundedRectangle(cornerRadius: 0).strokeBorder(lineWidth: 1, antialiased: true).foregroundColor(Color(uiColor: K.Brand.PBLines)))
            }.background(LinearGradient(gradient: Gradient(colors: [Color(uiColor: K.Brand.PBBackgroundColorTop), .white, Color(uiColor: K.Brand.PBBackgroundColorLowBottom), Color(uiColor: K.Brand.PBBackgroundColorEndBottom)]), startPoint: .top, endPoint: .bottom)).listRowBackground(Color(K.Brand.PBBackgroundColor))
            
        }.navigationBarTitleDisplayMode(.inline).navigationBarTitle(K.Tiles.BRAND_NAME, displayMode: .inline).toast(isPresenting: $network.showErrorMsg){
            
            // `.alert` is the default displayMode
            AlertToast(displayMode: .banner(.pop), type: .error(.red), title: "\(K.ErrorMessages.AN_ERROR_OCCURED)")
            
            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
            
            //Choose .banner to slide/pop alert from the bottom of the screen
            //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
        }

            
            
        }.onAppear {
          self.network.getData()
            
        }
    }
    
  
    
    // MARK: Deletion Function - If the app has been opened on the second day then delete the prior saved local data

    
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

