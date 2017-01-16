//
//  HostService.swift
//  macOS
//
//  Created by Dmytro Morozov on 12/01/2017.
//  Copyright © 2017 Dmytro Morozov. All rights reserved.
//

import Foundation

class HostService {
    
    private let localStore = UserDefaults.standard
    
    private let cloudStore = NSUbiquitousKeyValueStore.default()
    
    private let all = "hosts"
    
    private let one = "host"
    
    func load() -> [Host] {
        if let decoded = localStore.object(forKey: all) as? Data {
            if let hosts = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Host] {
                return hosts
            }
        }
        return [Host]()
    }
    
    func save(_ hosts: [Host]) {
        let encoded = NSKeyedArchiver.archivedData(withRootObject: hosts)
        localStore.set(encoded, forKey: all)
    }
    
    func get() -> Host? {
        if let decoded = localStore.object(forKey: one) as? Data {
            if let host = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Host {
                return host
            }
        }
        return nil
    }
    
    func set(_ host: Host?) {
        defer {
            localStore.synchronize()
        }
        if let host = host {
            let encoded = NSKeyedArchiver.archivedData(withRootObject: host)
            localStore.set(encoded, forKey: one)
        } else {
            localStore.removeObject(forKey: one)
        }
    }
    
    func add(_ host: Host) {
        var hosts = self.load()
        hosts.append(host)
        self.save(hosts)
    }
    
    func update(_ host: Host) {
        var hosts = self.load()
        let index = hosts.index { s in s.host == host.host && s.port == host.port }
        if let index = index {
            hosts[index] = host
            self.save(hosts)
        } else {
            self.add(host)
        }
    }
    
}
