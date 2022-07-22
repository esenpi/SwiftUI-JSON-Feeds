
import SwiftUI
import AVKit

struct VideoContentDetailView: View {
    var pbModModelItemVideo: FetchedResults<PBModelItem>.Element?
    @State var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: player)
            .onAppear() {
                player = AVPlayer(url: URL(string:pbModModelItemVideo!.data!)!)
            }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight*0.8, alignment: .topLeading).padding()
        
    }
}

struct VideoContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoContentDetailView()
    }
}

