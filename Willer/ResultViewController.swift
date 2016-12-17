//
//  ResultViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (PlayerMidiator.shared.isWerewolfWiped()) {
            self.titleLabel.text = "好人获胜！"
        }
        else if (PlayerMidiator.shared.isTownsfolkWiped() || PlayerMidiator.shared.isPriesthoodWiped()) {
            self.titleLabel.text = "狼人获胜！"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
