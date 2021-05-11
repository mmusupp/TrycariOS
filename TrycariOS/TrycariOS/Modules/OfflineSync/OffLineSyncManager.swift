//
//  OffLineSyncManager.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import Foundation
import Reachability
class OffLineSyncManager {
    var reachability: Reachability?
    static let shared = OffLineSyncManager()
    
    private init() { }
    
    func startNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
       do {
        try reachability = Reachability()
        try reachability?.startNotifier()
       }catch{
         print("could not start reachability notifier")
       }
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi, .cellular:
          print("Reachable via WiFi")
      case .unavailable:
        print("Network not reachable")
      case .none:
        break;
      }
    }
    
    
    func stopNotifier()  {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

}


extension OffLineSyncManager {
    func syncPEndingdataToserver()  {
        let unSyncPosts = PostDBModel.getunSyncData()
        //TODO: update the unsync data to server.
        // once we got success response update to local db
        

    }
}
