//
//  AudioRecorderVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 06/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorderVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    private var recording = false;
    private var playing = false;
    private let tempAudioFileURL = fileURL(file: "temp.caf", under: .CachesDirectory);

    private var recorder: AVAudioRecorder?;
    private var player: AVAudioPlayer?;
    private var session: AVAudioSession?;
    private let settings: [String: AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatAppleIMA4), AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey: 2, AVEncoderBitRateKey: 12800, AVLinearPCMBitDepthKey: 16,
        AVEncoderAudioQualityKey: AVAudioQuality.Max.rawValue]

    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSession();
        setUpRecorder();
        setUpPlayer();
        setButtonsEnabledness();
    }
    private func setUpSession() {
        let session = AVAudioSession.sharedInstance();
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord,
                withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
            try session.setActive(true);
            self.session = session;
        } catch {
            self.session = nil;
        }
    }

    private func setUpRecorder() {
        guard session != nil else { return }
        do {
            try recorder = AVAudioRecorder(URL: tempAudioFileURL, settings: settings)
            recorder?.prepareToRecord();
            recorder?.delegate = self;
        } catch {
            recorder = nil;
        }
    }

    private func setUpPlayer() {
        guard recorder != nil else { return }
        guard session != nil else { return }
        if fileExists(tempAudioFileURL) {
            do {
                try player = AVAudioPlayer(contentsOfURL: tempAudioFileURL)
                player?.delegate = self;
            } catch {
                // player = nil;
            }
        } else {
            player = nil;
        }
    }

    private func setButtonsEnabledness() {
        guard recorder != nil else { return }
        guard session != nil else { return }
        let duration = player?.duration ?? 0.0;
        if (duration == 0.0) {
            playButton.alpha = 0.5;
            deleteButton.alpha = 0.5;
            playButton.enabled = false;
            deleteButton.enabled = false;
        } else {
            playButton.alpha = 1;
            deleteButton.alpha = 1;
            playButton.enabled = true;
            deleteButton.enabled = true;
        }
    }

    @IBAction func onDeleteButtonPressed(sender: UIButton) {
        if playing {
            player?.stop();
            player = nil
        }
        deleteFile(file: tempAudioFileURL);
    }
    @IBAction func onRecordButtonPressed(sender: UIButton) {
        guard !playing else { return; }
        guard recorder != nil else { return; }
        guard session != nil else { return; }

        if recording {
            recorder?.stop();
            sender.setImage(UIImage(named: "mic-2"), forState: .Normal);
            recordingLabel.text = "start recording";
            sender.backgroundColor = nil;
            setUpPlayer();
            setButtonsEnabledness();
        } else {
            recorder?.recordForDuration(NSTimeInterval(60.0));
            sender.setImage(UIImage(named: "stop"), forState: .Normal);
            sender.backgroundColor = UIColor.redColor();
            recordingLabel.text = "recording...";
        }
        recording = !recording;
    }
    @IBAction func onPlayButtonPressed(sender: UIButton) {
        guard !recording else { return; }
        guard session != nil else { return; }
        guard player != nil else { return; }

        if playing {
            player?.stop();
            sender.setImage(UIImage(named: "play"), forState: .Normal);
            playLabel.text = "play";
            sender.backgroundColor = nil;
        } else {
            player?.play();
            sender.setImage(UIImage(named: "stop"), forState: .Normal);
            sender.backgroundColor = UIColor.redColor();
            playLabel.text = "stop";
        }
        playing = !playing;
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(UIImage(named: "play"), forState: .Normal);
        playButton.backgroundColor = nil;
    }
}
