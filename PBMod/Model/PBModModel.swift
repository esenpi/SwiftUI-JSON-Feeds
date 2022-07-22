
import Foundation

struct Response:Identifiable, Decodable {
    var id: UUID?
    
    var tiles: [Tiles]
}


struct Tiles: Decodable,Hashable {
    var id:Int?
    var name:String
    var headline:String?
    var subline:String?
    var data:String?
    var score:Int?
}
