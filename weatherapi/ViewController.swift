//
//  ViewController.swift
//  weatherapi
//
//  Created by Abdulhakim Ajetunmobi on 02/02/2017.
//  Copyright © 2017 abdulajet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var text: UITextField!
    
    @IBOutlet var label: UILabel!

    var appKey = ""
    
    
    @IBAction func button(_ sender: Any) {
        
        let url = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=\(text.text!.replacingOccurrences(of: " ", with: "%20"))&appid=" + appKey)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if  error != nil {
                print(error!)
            }else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        if let description = (((jsonResult as? NSDictionary)?["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                            
                            
                            DispatchQueue.main.sync(execute: {
                                self.label.text = description
                            })
                            
                            
                        }
                        
                        
                        
                    } catch {
                        
                    }
                    
                }
            }
            
        }
        
        task.resume()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

