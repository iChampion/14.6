//
//  ViewController.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 24.10.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var secondNameText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Persistance.shared.userName != nil {
            nameText.text = Persistance.shared.userName!
        }
        if Persistance.shared.secondName != nil {
            secondNameText.text = Persistance.shared.secondName!
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Persistance.shared.userName = nameText.text
        Persistance.shared.secondName = secondNameText.text
    }
}

