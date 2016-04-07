//
//  VideoPickerVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 06/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices

class VideoPopoverVC: UIViewController {

    private var mediaPicker: MediaPicker?;
    private var avPlayerViewController: AVPlayerViewController?;
    private let tempMovieURL = fileURL(file: "temp_video.MOV", under: .CachesDirectory);
    private var videoToPlayURL: NSURL? = nil;
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var pickFromSourceButtons: UIStackView!

    @IBAction func onUseCameraButtonPressed(sender: AnyObject) {
        mediaPicker?.pickUsingCamera();
    }
    @IBAction func onPhotosLibraryButtonPressed(sender: AnyObject) {
        mediaPicker?.pickFromLibrary();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        mediaPicker = MediaPicker(parentVC: self, mediaType: kUTTypeMovie as String);
        if (NSFileManager.defaultManager().fileExistsAtPath(tempMovieURL.path!)) {
            videoToPlayURL = tempMovieURL;
        }
        setUpPlayer();
    }

    func onNewVideo(videoURL: NSURL) {
        deleteFile(file: tempMovieURL);
        myCopy(videoURL, toPath: tempMovieURL);
        videoToPlayURL = tempMovieURL;
    }

    private func setUpPlayer() {
        if let url = videoToPlayURL {
            if avPlayerViewController == nil {
                avPlayerViewController = AVPlayerViewController()
                self.addChildViewController(avPlayerViewController!)
                self.videoContainer.addSubview(avPlayerViewController!.view)
                avPlayerViewController!.view.frame = self.videoContainer.frame
            }
            avPlayerViewController!.player = AVPlayer(URL: url)
        }
    }
    @IBAction func onDeletePressed(sender: AnyObject) {
        let controller = UIAlertController(title: deleteTheVideoText,
            message: nil, preferredStyle: .ActionSheet)

        let yesAction = UIAlertAction(title: yes, style: .Destructive, handler: {
            action in
            self.avPlayerViewController?.player = nil
            self.avPlayerViewController?.view.removeFromSuperview()
            self.avPlayerViewController?.removeFromParentViewController()
            deleteFile(file: self.tempMovieURL);
            self.videoToPlayURL = nil;
        });
        controller.addAction(yesAction)
        controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}