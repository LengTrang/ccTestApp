//
//  ViewController.swift
//  ClevlandClinic
//
//  Created by Leng Trang on 1/29/17.
//  Copyright © 2017 Amarenthe. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var CCFirstNameTxtFld: UITextField!
    @IBOutlet weak var CCLastNameTxtFld: UITextField!
    @IBOutlet weak var CCDOBTxtFld: UITextField!
    @IBOutlet weak var CCAppointmentBtn: UIButton!
    
    let acceptibleNameSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,.’\"- "
    let acceptibleDOBSet = "1234567890/"
    
    var nameFilter : CharacterSet = CharacterSet()
    var dobFilter : CharacterSet = CharacterSet()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameFilter = CharacterSet(charactersIn: acceptibleNameSet).inverted
        dobFilter = CharacterSet(charactersIn: acceptibleDOBSet).inverted
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstNameChange(_ sender: Any) {
    }
    
    @IBAction func textfieldChanges(_ sender: UITextField){
        if sender == CCDOBTxtFld{
            sender.text = sender.text!.trimmingCharacters(in: dobFilter)
            
        }else {
            sender.text = sender.text!.trimmingCharacters(in: nameFilter)
        }
        
    }
    @IBAction func dobEditEnd(_ sender: Any) {
        let dateStr = CCDOBTxtFld.text
        
        let dateFormatter = DateFormatter()
        //            let inputDate = "2015-06-18T19:00:53-07:00"
        dateFormatter.dateFormat = "mm/dd/yyyy" //iso 8601
        
        let outputDate = dateFormatter.date(from: dateStr!)
        
        if (outputDate != nil){
            print(outputDate!)
        }else{
            
            let alertController = UIAlertController(title: "Incorrect Format", message: "Please enter in the format of MM/DD/YYYY", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true)
            
            print("Fail")
        }
    }

    @IBAction func setAppointment(_ sender: Any) {
        let json : [String : Any] = ["firstName" : CCFirstNameTxtFld.text!, "lastName" : CCLastNameTxtFld.text!, "dob" : CCDOBTxtFld.text!]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "https://test.appointmentpass.com/patients")!
        
        // Test Data
//        let url = URL(string: "https://httpbin.org/post")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
        let alertController = UIAlertController(title: "ClevelandClinic", message: "Your appointment has been sent.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true)
        
    }
}

