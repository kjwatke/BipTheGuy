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
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        
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
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            
            guard let self = self else { return }
            self.accessPhotoLibrary()
            
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            
            guard let self = self else { return }
            self.accessCamera()
            
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            imageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func accessPhotoLibrary() {
        
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func accessCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
            
        }
        else {
            showAlert(with: "Camera Not Available", containing: "There is no camera available on this device.")
        }
    }
}

