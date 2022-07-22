
import Foundation
import UIKit

struct K {
    static let DBPath = "https://firebasestorage.googleapis.com/v0/b/reference-proj-git.appspot.com/o/reference-proj-git-default-rtdb-export.json?alt=media&token=b3a1a68d-6d5e-410c-a5bc-786867e922d5"
    
    struct Brand {
        
        static let PBBackgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9254901961, blue: 0.9647058824, alpha: 1)
        static let PBFontColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let PBLines = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let PBBackgroundColorTop = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        static let PBBackgroundColorLowBottom = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        static let PBBackgroundColorEndBottom = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        struct Fonts {
            static let Headline = "Orbitron-Regular"
            static let Body = "Gruppo-Regular"
            
        }

    }
    
    struct Media {
        static let PHOTO = "photo"
        static let VIDEO = "video"
        static let INTERNET = "internet"
        static let LIST = "list"
    }
    
    struct UDefaults {
        static let DATENOW = "dateNow"
        static let LOGIN = "login"
    }
    
    struct Tiles {
        static let HEADLINE = "Headline"
        static let LEARN_MORE = "Learn More"
        static let BRAND_NAME = "ESEN MOTORS"
        static let IMAGE = "image"
        static let VIDEO = "video"
        static let WEBSITE = "website"
    }
    
    struct ErrorMessages {
        static let AN_ERROR_OCCURED = "An error occured"
    }
}
public let dateFormatter = DateFormatter()
