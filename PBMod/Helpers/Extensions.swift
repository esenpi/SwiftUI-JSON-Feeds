
import Foundation
import UIKit
import SwiftUI

// Extensions in order to make life easier for our colleagues 

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standard = UINavigationBarAppearance()
        standard.backgroundColor = K.Brand.PBBackgroundColor // For standard small
        
        let compact = UINavigationBarAppearance()
        compact.backgroundColor = K.Brand.PBBackgroundColor // For compact-height
        
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.backgroundColor = K.Brand.PBBackgroundColor // For large titles
        
        navigationBar.standardAppearance = standard
        navigationBar.compactAppearance = compact
        navigationBar.scrollEdgeAppearance = scrollEdge
    }
}
