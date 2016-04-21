//
//  AudioRecorderVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 06/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVFoundation

class MediaPopoverAudioVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, MediaPopover {
// Delegate stuff
	var delegate: MediaPopoverDataDelegate?;

// Internal stuff
	private var recorder: AVAudioRecorder?;
	private var player: AVAudioPlayer?;
	private var session: AVAudioSession?;
	private let settings: [String: AnyObject] = [
		AVFormatIDKey: Int(kAudioFormatAppleIMA4), AVSampleRateKey: 44100.0,
		AVNumberOfChannelsKey: 2, AVEncoderBitRateKey: 12800, AVLinearPCMBitDepthKey: 16,
		AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue]
	private var recording = false;
	private var playing = false;

// UI stuff
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
		adjustButtons();
	}
///
/// Cancel any playback/recording
///
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated);
		if let player = player where playing {
			player.stop();
		}
		if let recorder = recorder where recording {
			recorder.stop();
		}
	}
///
/// Creates and sets up the audio session. If a failure occurs, the session is set to nil.
///
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
///
/// Creates the recorder. If a recorder creation fails, it will be nil.
///
	private func setUpRecorder() {
		guard session != nil else { return }
		do {
			let temp = NSURL(fileURLWithPath: NSTemporaryDirectory())
				.URLByAppendingPathComponent("temp_recording.caf")
			try recorder = AVAudioRecorder(URL: temp, settings: settings)
			recorder?.prepareToRecord();
			recorder?.delegate = self;
		} catch {
			recorder = nil;
		}
	}
///
/// Creates the audio player, and assigns it the persistentAudioFileURL as file to play
/// If creation fails or the file doesn't exist, the player is set to nil.
///
	private func setUpPlayer() {
		guard recorder != nil else { return }
		guard session != nil else { return }
		if let playFile = delegate?.audio {
			do {
				try player = AVAudioPlayer(contentsOfURL: playFile)
				player?.delegate = self;
			} catch let e {
				print(e);
				// player = nil;
			}
		} else {
			player = nil;
		}
	}
///
/// When delete pressed, stop any potential playing item,
/// delete the persistent audio file, and adjust buttons
///
	@IBAction func onDeleteButtonPressed(sender: UIButton) {
		if !playing && !recording {
			player?.stop();
			player = nil;
			delegate?.audio = nil;
			adjustButtons();
		}
	}
///
/// If recording, stop the recording
/// If not recording, start recording
/// Disable all other buttons if we record
///
	@IBAction func onRecordButtonPressed(sender: UIButton) {
		guard !playing else { return; }
		guard recorder != nil else { return; }
		guard session != nil else { return; }

		if recording {
			recorder?.stop();
		} else {
			recording = true;
			adjustButtons();
			recorder?.recordForDuration(NSTimeInterval(30.0));
		}
	}

///
/// When the recording finished, delete the old persistent file,
/// copy the one from the recorder to the persistent file, and give it to the avpplayer
/// adjust the buttons -- disable the play and delete buttons
///
	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
		if (flag) {
			delegate?.audio = recorder.url;
			setUpPlayer();
		} else {
			delegate?.audio = nil;
			alertWithMessage(self, title: "Failed to record.");
		}
		recording = false;
		adjustButtons();
	}

///
/// If playing, stop playing
/// If not playing, start playing
/// Disable all other buttons while playing
///
	@IBAction func onPlayButtonPressed(sender: UIButton) {
		guard !recording else { return; }
		guard session != nil else { return; }
		guard player != nil else { return; }

		if playing {
			playing = false;
			adjustButtons();
			self.player?.stop();
		}
		else {
			playing = true;
			adjustButtons();
			self.player?.play();
		}
	}

///
/// When the playing finishes, reenable the play button
///
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
		playing = false;
		adjustButtons();
	}

	private func adjustButtons() {
		guard nil != session || nil != recorder else {
			setStates(recordState: false, playState: false, deleteState: false);
			return;
		}
		if player == nil {
			setStates(recordState: true, playState: false, deleteState: false);
		} else {
			if recording {
				setStates(recordState: true, playState: false, deleteState: false);
			} else if (playing) {
				setStates(recordState: false, playState: true, deleteState: false);
			} else {
				setStates(recordState: true, playState: true, deleteState: true);
			}
		}
		playerButtonState();recordButtonState();
	}
///
/// Sets the states of the three buttons. If a button is disabled it's alpha will be changed to 0.5
///
	private func setStates(recordState recordState: Bool, playState: Bool, deleteState: Bool) {
		recordButton.enabled = recordState ;
		recordButton.alpha = recordState ? 1 : 0.5;
		playButton.enabled = playState ;
		playButton.alpha = playState ? 1 : 0.5;
		deleteButton.enabled = deleteState ;
		deleteButton.alpha = deleteState ? 1 : 0.5;
	}

	func playerButtonState() {
		if !playing {
			playButton.setImage(UIImage(named: "play"), forState: .Normal);
			playButton.backgroundColor = nil;
			playLabel.text = "play";
		} else {
			playButton.setImage(UIImage(named: "stop"), forState: .Normal);
			playButton.backgroundColor = UIColor.redColor();
			playLabel.text = "stop";
		}
	}

	func recordButtonState() {
		if !recording {
			recordButton.setImage(UIImage(named: "mic-2"), forState: .Normal);
			recordButton.backgroundColor = nil;
			recordingLabel.text = "record";
		} else {
			recordButton.setImage(UIImage(named: "stop"), forState: .Normal);
			recordButton.backgroundColor = UIColor.redColor();
			recordingLabel.text = "stop";
		}
	}
}
