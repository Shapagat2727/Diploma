//
//  AddVideoTextViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/25/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import AVFoundation
import ChameleonFramework
class AddVideoTextViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    let imagePicker = UIImagePickerController()
    var videoURL: NSURL?
    var selectedWeek:Week?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var videoTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Week \(selectedWeek!.id+1)"
        imagePicker.delegate = self
        addQuestionButton.layer.borderColor = FlatMint().cgColor
        addQuestionButton.layer.borderWidth = 3.0
        addQuestionButton.layer.cornerRadius = addQuestionButton.frame.size.height/5
        
    }
    @IBAction func selectVideoPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? NSURL{
            videoTextField.text = "\(videoURL)"
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addQuestionsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.newContentSegue, sender: self)
        
    }
    
    
    
}
