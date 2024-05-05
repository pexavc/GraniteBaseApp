//
//  InfoIconView.swift
//  
//
//  Created by PEXAVC on 4/30/23.
//

import Foundation
import SwiftUI
import GraniteUI

struct InfoIconView: View {
    var body: some View {
        VStack {
            Text("i")
                .background(Circle().strokeBorder(.white, lineWidth: 1).frame(width: 16, height: 16))
        }
    }
}

extension View {
    func addInfoIcon(text: String, spacing: CGFloat = 12, _ modalService: ModalService) -> some View {
        HStack(spacing: spacing) {
            InfoIconView()
                .onTapGesture {
                    GraniteHaptic.light.invoke()
                    modalService.present(GraniteAlertView(message: .init(text)) {
                        
                        GraniteAlertAction(title: "Done")
                    })
                }
            self
        }
    }
}
