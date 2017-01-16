//
//  Host.swift
//  macOS
//
//  Created by Dmytro Morozov on 12/01/2017.
//  Copyright © 2017 Dmytro Morozov. All rights reserved.
//

import Foundation

class Host : NSObject, NSCoding {
    
    let name: String
    
    let host: String
    
    let port: Int
    
    let icon: String?
    
    let group: String?
    
    init(name: String, host: String, port: Int, icon: String? = nil, group: String? = "Default") {
        self.name = name
        self.host = host
        self.port = port
        self.icon = icon
        self.group = group
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let host = aDecoder.decodeObject(forKey: "host") as? String,
            let port = aDecoder.decodeObject(forKey: "port") as? Int else { return nil }
        let icon = aDecoder.decodeObject(forKey: "icon") as? String
        let group = aDecoder.decodeObject(forKey: "group") as? String
        self.init(name: name, host: host, port: port, icon: icon, group: group)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(host, forKey: "host")
        aCoder.encode(port, forKey: "port")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(group, forKey: "group")
    }
    
}
