//
//  GameViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!

    // MARK: -

    var currentStep: Step?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GameManager.sharedInstance.zeroDay()
        self.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func firstButtonTapped() {
        let result = currentStep?.firstAction?()
        if result != nil && result! {
            self.updateStep()
        }
    }

    @IBAction func secondButtonTapped() {
        let result = currentStep?.secondAction?()
        if result != nil && result! {
            self.updateStep()
        }
    }

    // MARK: - General

    func update() {

        // Control
        self.updateStep()
    }

    // MARK: - Info area



    // MARK: - Play area



    // MARK: - Step area

    func updateStep() {
        self.currentStep = GameManager.sharedInstance.currentStep()

        self.renderStep()
    }

    func renderStep() {
        self.headLabel.text = self.currentStep?.headText
        self.bodyLabel.text = self.currentStep?.bodyText

        self.firstButton.setTitle(self.currentStep?.firstActionText, for: .normal)
        self.secondButton.setTitle(self.currentStep?.secondActionText, for: .normal)

        if self.currentStep?.secondAction == nil {
            self.secondButton.isHidden = true
        }
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
