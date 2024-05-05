//
//  HomeComponent.swift
//  PEX
//
//  Created by PEXAVC on 7/18/22.
//  Copyright (c) 2022  Collective, LLC.. All rights reserved.
//
import Granite
import SwiftUI
import Combine

struct Home: GraniteComponent {
    @Command var center: Center
    @Relay var modalService: ModalService
    
}

