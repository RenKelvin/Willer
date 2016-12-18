//
//  GameViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    static var deck: Deck?
    static var cards: [Card] = []

    // MARK: - IBOutlets

    @IBOutlet var dayLabel: UILabel!

    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var firstButtonContainer: UIView!
    @IBOutlet var secondButtonContainer: UIView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.onUpdate), name: NSNotification.Name("OnUpdate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.onEnd), name: NSNotification.Name("OnEnd"), object: nil)

        // Game
        GameManager.shared.start(cards: GameViewController.cards)
        GameManager.shared.zeroDay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func firstButtonTapped() {
        GameManager.shared.firstAction()
    }

    @IBAction func secondButtonTapped() {
        GameManager.shared.secondAction()
    }

    // MARK: - General

    func onUpdate() {
        self.update()
    }

    func update() {
        // Info
        self.updateInfo()

        // Battle
        self.updateBattle()

        // Process
        self.updateStep()
    }

    func onEnd() {
        self.end()
    }

    func end() {
        self.performSegue(withIdentifier: "GameResultSegueIdentifier", sender: nil)
    }

    // MARK: - Info area

    func updateInfo() {
        self.dayLabel.text = String(GameManager.shared.currentDay())
        //        if GameManager.shared.currentDay() % 2 == 1 {
        //            self.dayLabel.text = "夜"
        //        }
        //        else {
        //            self.dayLabel.text = "日"
        //        }
    }

    // MARK: - Battle area

    func updateBattle() {
        collectionView.reloadData()
    }

    // MARK: - Process area

    func updateStep() {
        let currentStep = GameManager.shared.currentStep()
        currentStep?.preAction?()

        self.headLabel.text = currentStep?.headText
        self.bodyLabel.text = currentStep?.bodyText

        self.firstButton.setTitle(currentStep?.firstActionText, for: .normal)
        self.secondButton.setTitle(currentStep?.secondActionText, for: .normal)

        self.firstButtonContainer.isHidden = false
        self.secondButtonContainer.isHidden = false
        if currentStep?.secondAction == nil {
            self.secondButtonContainer.isHidden = true
        }
    }

    // MARK: - UICollectionView datasource and delegate

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return GameManager.shared.livingPlayers().count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCellReuseIdentifier", for: indexPath) as! GameCollectionViewCell

        // Configure the cell
        let player = GameManager.shared.livingPlayers()[indexPath.row]
        cell.config(player: player)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Trigger menu
        if PlayerMidiator.shared.maxSelected == 0 {
            let player = GameManager.shared.livingPlayers()[indexPath.row]
            if player.character.id == Constants.Werewolf && StatusMidiator.shared.currentDay%2 == 0 {
                let alertController = UIAlertController(title: "狼人自爆", message: "", preferredStyle: .alert)

                let cancelAction = UIAlertAction(title: "取消", style: .cancel) { action in
                    // ...
                }
                alertController.addAction(cancelAction)

                let doneAction = UIAlertAction(title: "确定", style: .default) { action in
                    // ...
                    _ = (player.character as! Werewolf).abilities[1].action()
                    self.update()
                }
                alertController.addAction(doneAction)

                self.present(alertController, animated: true) {
                    // ...
                }
            }
        }
            // Select players
        else {
            GameManager.shared.selectPlayer(at: indexPath.row)
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

// MARK: -

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet var label: UILabel!

    @IBOutlet var portraitImageView: UIImageView!
    @IBOutlet var noLabel: UILabel!

    func config(player: Player) {
        // Info
        label.text = "\(player.no) " + player.character.name + " \(player.stateMachine.state)" + "\n"
            + player.effectMachine.effectString()

        // Selection
        if player.stateMachine.selected {
            self.contentView.backgroundColor = UIColor.green
        }
        else {
            self.contentView.backgroundColor = UIColor.clear
        }

        //
        self.portraitImageView.layer.cornerRadius = self.portraitImageView.frame.size.width/2
        self.portraitImageView.clipsToBounds = true

        self.noLabel.text = String(player.no)
        
        //
        if player.stateMachine.state == .live {
            self.portraitImageView.image = UIImage(named: "portrait_placeholder")
        }
        else {
            self.portraitImageView.image = UIImage(named: "portrait_placeholder_gray")
        }
    }
    
}
