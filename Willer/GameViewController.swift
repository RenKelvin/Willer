//
//  GameViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var consoleLabel1: UILabel!
    @IBOutlet var consoleLabel2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.renderStep(step: GameManager.sharedInstance.nextStep())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func renderStep(step: Step) {
        self.consoleLabel1.text = step.text1
        self.consoleLabel2.text = step.text2
    }

    @IBAction func action1() {
        self.renderStep(step: GameManager.sharedInstance.nextStep())
    }

    @IBAction func action2() {

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
