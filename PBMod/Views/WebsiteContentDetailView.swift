
import SwiftUI
import WebKit

struct WebsiteContentDetailView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebsiteContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteContentDetailView(url: URL(string: "")!)
    }
}
