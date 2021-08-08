//
//  SelectLevelViewController.swift
//  quizapp2021
//
//  Created by futoshi on 2021/08/03.
//

import UIKit

class SelectLevelViewController: UIViewController {
    
    @IBOutlet var level1: UIButton!
    @IBOutlet var level2: UIButton!
    @IBOutlet var level3: UIButton!

    //選択したレベルを入れる箱
    var selectTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        level1.layer.borderWidth = 2
        level1.layer.borderColor = UIColor.black.cgColor
        level2.layer.borderWidth = 2
        level2.layer.borderColor = UIColor.black.cgColor
        level3.layer.borderWidth = 2
        level3.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! quizViewController
        quizVC.selectLevel = selectTag
    }
    
    
    
    @IBAction func levelButtonAction(sender :UIButton){
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    
    
    
    
}
