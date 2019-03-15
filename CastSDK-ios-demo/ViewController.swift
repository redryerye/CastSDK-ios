//
//  ViewController.swift
//  CastSDK-ios-demo
//
//  Created by Yuki Yamamoto on 2019/01/26.
//  Copyright © 2019 Yuki Yamamoto. All rights reserved.
//

import UIKit
import GoogleCast

class ViewController: UIViewController, GCKSessionManagerListener, GCKRemoteMediaClientListener, GCKRequestDelegate {
    
    @IBOutlet weak var demoLabel: UILabel!
    
    private var mediaInformation: GCKMediaInformation?
    private var sessionManager: GCKSessionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setCastButton()
        
        sessionManager = GCKCastContext.sharedInstance().sessionManager
        sessionManager.add(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setCastButton() {

        let castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        castButton.tintColor = UIColor.blue
        
        
        self.view.addSubview(castButton)
        
        castButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
    }
    
    func loadImage() {
        if sessionManager.currentSession != nil {
            sendImage()
        } else {
            print("current session is \(sessionManager.currentSession)")
        }
    }
    
    func sendImage() {
        let metadata = GCKMediaMetadata()
        metadata.setString("Big Buck Bunny (2008)", forKey: kGCKMetadataKeyTitle)
        metadata.setString("Big Buck Bunny tells the story of a giant rabbit with a heart bigger than " +
            "himself. When one sunny day three rodents rudely harass him, something " +
            "snaps... and the rabbit ain't no bunny anymore! In the typical cartoon " +
            "tradition he prepares the nasty rodents a comical revenge.",
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg")!,
                                   width: 480,
                                   height: 360))
        
        // Define information about the media item.
        let url = URL(string: "https://www.gstatic.com/webp/gallery3/1.png")
        guard let mediaURL = url else {
            print("invalid mediaURL")
            return
        }
        
        let mediaInfoBuilder = GCKMediaInformationBuilder(contentURL: mediaURL)
        mediaInfoBuilder.contentID = "https://www.gstatic.com/webp/gallery3/1.png"
        mediaInfoBuilder.streamType = GCKMediaStreamType.none
        mediaInfoBuilder.contentType = "image/png"
        mediaInfoBuilder.metadata = metadata
        mediaInformation = mediaInfoBuilder.build()
        
        if let request = sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInformation!) {
            request.delegate = self
        }
        
    }
    
    @IBAction func askForCurrentSession(_ sender: Any) {
        print("current session: \(String(describing: sessionManager.currentSession))")
        
        loadImage()
    }
    
    // MARK: - GCKSessionManagerListener
    func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKSession) {
        print(#function)
    }
}
