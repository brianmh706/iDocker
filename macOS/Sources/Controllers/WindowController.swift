//
//  WindowController.swift
//  macOS
//
//  Created by Dmytro Morozov on 12/01/2017.
//  Copyright © 2017 Dmytro Morozov. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.isMovableByWindowBackground = true
        window?.styleMask.insert(NSWindowStyleMask.fullSizeContentView)
    }

}
