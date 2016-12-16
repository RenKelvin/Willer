//
//  OrderViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var numLabel: UILabel!
    @IBOutlet var sliderButton: UIButton!
    @IBOutlet var sliderFillImageView: UIImageView!
    @IBOutlet var sliderContainerImageView: UIImageView!

    @IBOutlet var sliderButtonLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var sliderFillImageViewWidthConstraint: NSLayoutConstraint!

    @IBOutlet var decksTableView: UITableView!

    var decks: [Deck] = []

    static var num: Int = 9
    let numMin: Int = 4
    let numMax: Int = 16

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func minusButtonTap() {
        if OrderViewController.num > self.numMin {
            OrderViewController.num -= 1
            self.refresh()
        }
    }

    @IBAction func plusButtonTap() {
        if OrderViewController.num < self.numMax {
            OrderViewController.num += 1
            self.refresh()
        }
    }

    @IBAction func sliderButtonDrag(gesture: UILongPressGestureRecognizer) {
        let x = gesture.location(in: self.sliderButton.superview).x

        let xMin: CGFloat = self.sliderContainerImageView.frame.origin.x + 8
        let xMax: CGFloat = self.sliderContainerImageView.frame.origin.x + self.sliderContainerImageView.frame.width - 8

        if (x < xMin || x > xMax) {
            return
        }

        let k = (self.sliderButton.center.x - xMin) / (xMax - xMin)
        let n = Float(self.numMin) + Float(self.numMax - self.numMin) * Float(k)

        OrderViewController.num = Int(round(n))
        self.numLabel.text = String(OrderViewController.num)

        self.sliderButtonLeadingSpaceConstraint.constant = x - self.sliderContainerImageView.frame.origin.x - self.sliderButton.frame.width / 2
        self.sliderFillImageViewWidthConstraint.constant = x - self.sliderFillImageView.frame.origin.x

        if gesture.state == .began || gesture.state == .changed {
            self.sliderButton.isHighlighted = true
        }
        else {
            self.sliderButton.isHighlighted = false
        }
    }

    func refresh() {
        self.numLabel.text = String(OrderViewController.num)

        let xMin: CGFloat = self.sliderContainerImageView.frame.origin.x + 8
        let xMax: CGFloat = self.sliderContainerImageView.frame.origin.x + self.sliderContainerImageView.frame.width - 8

        let k = Float(OrderViewController.num - self.numMin) / Float(self.numMax - self.numMin)
        let x = xMin + (xMax - xMin) * CGFloat(k)

        self.sliderButtonLeadingSpaceConstraint.constant = x - self.sliderContainerImageView.frame.origin.x - self.sliderButton.frame.width / 2
        self.sliderFillImageViewWidthConstraint.constant = x - self.sliderFillImageView.frame.origin.x

        // Update table
        self.decks = MatchManager.shared.decks(for: OrderViewController.num)
        self.decksTableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCellReuseIdentifier", for: indexPath) as! DeckTableViewCell

        // Configure the cell...
        let deck = self.decks[indexPath.row]
        cell.config(deck: deck)

        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "OrderPickSegueIdentifier" {
            let indexPath = self.decksTableView.indexPathForSelectedRow!
            let deck = self.decks[indexPath.row]
            PickViewController.deck = deck
        }
    }
    
}
