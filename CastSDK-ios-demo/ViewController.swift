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
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var castButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    
    private var isConnected: Bool = false
    
    let castImage = UIImage(named: "cast")
    let waitImage = UIImage(named: "waiting")
    
    private var mediaInformation: GCKMediaInformation?
    private var sessionManager: GCKSessionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logLabel.text = ""
        castButton.setImage(waitImage, for: .normal)
        
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
        castButton.tintColor = UIColor.black
        
        self.view.addSubview(castButton)
        
        castButton.center = CGPoint(x: self.circleImageView.center.x, y: self.circleImageView.center.y + 20)
    }
    
    func loadImage() {
        if sessionManager.currentSession != nil {
            sendImage()
        } else {
            print("current session is \(sessionManager.currentSession)")
        }
    }
    
    @IBAction func castButtonAction(_ sender: Any) {
        if sessionManager.currentSession != nil {
            isConnected = true
            setCastButtonImage()
        }
        
        loadImage()
    }
    
    
    func sendImage() {
        
        let metadata = GCKMediaMetadata()
        metadata.setString("try! Swift 2019", forKey: kGCKMetadataKeyTitle)
        metadata.setString("from CastSDK-ios-demo",
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: "https://connpass-tokyo.s3.amazonaws.com/thumbs/19/20/19200cc7e95eb5a8a2418add78b11d6b.png")!,
                                   width: 480,
                                   height: 360))
        
        // Define information about the media item.
        let url = URL(string: "https://www.lanches.co.jp/wp-content/uploads/2018/03/try_swift.png")
        guard let mediaURL = url else {
            print("invalid mediaURL")
            return
        }
        
        let mediaInfoBuilder = GCKMediaInformationBuilder(contentURL: mediaURL)
        mediaInfoBuilder.contentID = "https://www.lanches.co.jp/wp-content/uploads/2018/03/try_swift.png"
        mediaInfoBuilder.streamType = GCKMediaStreamType.none
        mediaInfoBuilder.contentType = "image/png"
        mediaInfoBuilder.metadata = metadata
        mediaInformation = mediaInfoBuilder.build()
        
        if let request = sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInformation!) {
            request.delegate = self
        }
        
    }
    
    // MARK: - GCKSessionManagerListener
    func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKSession) {
        print(#function)
        isConnected = true
        
        setCastButtonImage()
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didEnd session: GCKSession, withError error: Error?) {
        print(#function)
        isConnected = false
        
        setCastButtonImage()
    }
    
    func setCastButtonImage() {
        if isConnected {
            self.castButton.setImage(castImage, for: .normal)
        } else {
            self.castButton.setImage(waitImage, for: .normal)
        }
    }
}
