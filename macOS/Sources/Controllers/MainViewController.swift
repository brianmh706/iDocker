//
//  SidebarViewController.swift
//  macOS
//
//  Created by Dmytro Morozov on 12/01/2017.
//  Copyright © 2017 Dmytro Morozov. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate, NSSplitViewDelegate {

    @IBOutlet fileprivate weak var outlineView: NSOutlineView!
    
    fileprivate let hostService = HostService()
    
    fileprivate lazy var hosts: [Host]! = {
        [weak self] in
        return self?.hostService.load()
        }()
    
    override func viewDidAppear() {
        let offset = (view.window?.frame.height)! - (view.window?.contentLayoutRect.maxY)!
        outlineView.enclosingScrollView?.contentInsets.top = offset
    }
    
    // MARK: NSOutlineViewDataSource
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return hosts.count + 1
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return index > 0 ? hosts[index - 1] : false
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        if let item = item as? Bool {
            return item
        }
        if let host = item as? Host {
            return host
        }
        return nil
    }
    
    // MARK: NSOutlineViewDelegate
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if let cell = outlineView.make(withIdentifier: "CreateCell", owner: self) as? NSTableCellView, let _ =  item as? Bool {
            return cell
        }
        if let cell = outlineView.make(withIdentifier: "HostCell", owner: self) as? NSTableCellView, let data = item as? Host {
            cell.textField?.stringValue = data.name
            cell.textField?.sizeToFit()
            if let icon = data.icon, let image = NSImage(named: icon) {
                cell.imageView?.image = image
            }
            return cell
        }
        return nil
    }
    
    // MARK: NSSplitViewDelegate
    
    func splitView(_ splitView: NSSplitView, constrainSplitPosition proposedPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if proposedPosition < splitView.bounds.width / 4 {
            return splitView.bounds.width / 4
        }
        if proposedPosition > splitView.bounds.width / 2 {
            return splitView.bounds.width / 2
        }
        return proposedPosition
    }
    
}
