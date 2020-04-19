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
class TeacherVideoTextViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let realm = try! Realm()
    let imagePicker = UIImagePickerController()
    var videoURL: NSURL?
    var selectedWeek:Week?
 
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var videoTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        do{
            try realm.write{
                selectedWeek?.video = videoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "video url didn't set"
                selectedWeek?.textContent = textView.text
            }
        }catch{
            print("error  saving video url \(error)")
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
        self.title = "Week \(selectedWeek!.id+1)"
        imagePicker.delegate = self
        videoTextField.addTarget(self, action: #selector(TeacherVideoTextViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        videoTextField.text = selectedWeek?.video
        textView.text = selectedWeek?.textContent
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if verifyUrl(urlString: textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)){
            errorLabel.alpha = 0
        }else{
            showError(with: "Can't open this url, please check the format")
        }

      
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
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
    
    

    func showError(with message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
