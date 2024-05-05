import Granite
import SwiftUI
import WebKit

extension Settings: View {
    var aboutPageLinkString: String {
        ""
    }
    
    public var view: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Settings")
                        .font(.title)
                    .padding(.leading, .layer3)
                    
                    Spacer()
                }.padding(.top, .layer5)
                
                Spacer()
            }
        }
    }
}
