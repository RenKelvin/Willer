//
//  GameViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

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

        //
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.onUpdate), name: NSNotification.Name("OnUpdate"), object: nil)

        // Game
        GameManager.shared.start(deck: Deck.testDeck())
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

    // MARK: - Info area

    func updateInfo() {
        self.dayLabel.text = String(GameManager.shared.currentDay())
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
        GameManager.shared.selectPlayer(at: indexPath.row)
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
            self.portraitImageView.isHighlighted = false
        }
        else {
            self.portraitImageView.isHighlighted = true
        }
    }
    
}
