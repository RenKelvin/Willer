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

    @IBOutlet var dayLabel: UILabel!

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.onUpdate), name: NSNotification.Name("OnUpdate"), object: nil)

        // Game
        GameManager.sharedInstance.start(deck: Deck())
        GameManager.sharedInstance.zeroDay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func firstButtonTapped() {
        // self.secondButton.setTitle(String(arc4random_uniform(UInt32(1000))), for: .normal)
        GameManager.sharedInstance.firstAction()
    }

    @IBAction func secondButtonTapped() {
        GameManager.sharedInstance.secondAction()
    }

    // MARK: - General

    func onUpdate() {
        self.update()
    }

    func update() {
        // Info
        self.updateInfo()

        // Process
        self.updateStep()
    }

    // MARK: - Info area

    func updateInfo() {
        self.dayLabel.text = String(GameManager.sharedInstance.currentDay())
    }

    // MARK: - Battle area

    func updateBattle() {
        
    }

    // MARK: - Process area

    func updateStep() {
        let currentStep = GameManager.sharedInstance.currentStep()

        self.headLabel.text = currentStep?.headText
        self.bodyLabel.text = currentStep?.bodyText

        self.firstButton.setTitle(currentStep?.firstActionText, for: .normal)
        self.secondButton.setTitle(currentStep?.secondActionText, for: .normal)

        self.firstButton.isHidden = false
        self.secondButton.isHidden = false
        if currentStep?.secondAction == nil {
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
