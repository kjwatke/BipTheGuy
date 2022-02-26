//
//  ViewController.swift
//  BipTheGuy
//
//  Created by Kevin Watke on 2/24/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var soundPlayer: AVAudioPlayer!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func imagedTapped(_ sender: UITapGestureRecognizer) {
        playSound(name: "punchSound")
        let originalFrame = imageView.frame
        let shrinkWidth: CGFloat = 20
        let shrinkHeight: CGFloat = 20
        
        let smallerFrame = CGRect(
            x: imageView.frame.origin.x + shrinkWidth,
            y: imageView.frame.origin.y + shrinkHeight,
            width: imageView.frame.width - (2 * shrinkWidth),
            height: imageView.frame.height - (2 * shrinkHeight)
        )
        
        imageView.frame = smallerFrame
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: []) { [weak self] in
            
            guard let self = self else { return }
            
            self.imageView.frame = originalFrame
        }
    }
    
    
    @IBAction func photoOrCameraPressed(_ sender: UIButton) {
    
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            
            print("You clicked photo library")
            // TODO: - Add code to pick a photo or take a photo
            
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            
            // TODO: Add code to to take a photo
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    private func showAlert(with title: String, containing message: String) {
    
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    private func playSound(name: String) {
        
        if let sound = NSDataAsset(name: name) {
            do {
                try soundPlayer = AVAudioPlayer(data: sound.data)
                soundPlayer.play()
            }
            catch  {
                print("No sound found")
            }
        }
        
    }
    
}

