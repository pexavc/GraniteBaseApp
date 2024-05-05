//
//  View+Modal.swift
//  
//
//  Created by Ritesh Pakala on 6/5/23.
//

import Foundation
import SwiftUI

extension View {
    func disclaimer(_ text: String, _ modalService: ModalService) -> some View {
        self.onTapGesture {
            modalService.present(GraniteAlertView(message: .init(text)) {
                
                GraniteAlertAction(title: "Done")
            })
        }
    }
}
