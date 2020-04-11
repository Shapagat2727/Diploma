//
//  TeacherVideoTextViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/25/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import AVFoundation
import ChameleonFramework
import RealmSwift
class TeacherVideoTextViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    let realm = try! Realm()
    let imagePicker = UIImagePickerController()
    var videoURL: NSURL?
    var selectedWeek:Week?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var videoTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        do{
            try realm.write{
                selectedWeek?.video = videoTextField.text ?? "video url didn't set"
                selectedWeek?.textContent = textView.text
            }
        }catch{
            print("error  saving video url \(error)")
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Week \(selectedWeek!.id+1)"
        imagePicker.delegate = self
        
        videoTextField.text = selectedWeek?.video
        textView.text = selectedWeek?.textContent
        
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
    
    

    
    
}
