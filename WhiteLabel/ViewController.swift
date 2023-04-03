//
//  ViewController.swift
//  WhiteLabel
//
//  Created by Ian Fagundes on 03/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "DefaultProperties", withExtension: "plist") {
            do {
                let data =  try Data(contentsOf: url)
                
                if let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String : Any] {
                    print(dict.keys)
                    if let title = dict["SplashName"] as? String {
                        lbTitle.text = title
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
}

