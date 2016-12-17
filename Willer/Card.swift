//
//  Card.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

struct Card {

    var id: String = "Card:id"
    var name: String = "Card:name"
    var slogan: String = "Card:slogan"

    static func factory(id: String) -> Card {
        switch id {

        case Constants.Townsfolk:
            return Card.townsfolk

        case Constants.Werewolf:
            return Card.werewolf

        case Constants.Foreteller:
            return Card.foreteller

        case Constants.Witch:
            return Card.witch

        case Constants.Hunter:
            return Card.hunter

        case Constants.Idiot:
            return Card.idiot

        default:
            return Card()
        }
    }
    
}

// MARK: - Stored

extension Card {

    static var townsfolk: Card {
        var card = Card()
        card.id = Constants.Townsfolk
        card.name = "普通村民"
        card.slogan = "没有技能"
        return card
    }

    static var werewolf: Card {
        var card = Card()
        card.id = Constants.Werewolf
        card.name = "狼人"
        card.slogan = "每晚可杀害一人"
        return card
    }

    static var foreteller: Card {
        var card = Card()
        card.id = Constants.Foreteller
        card.name = "预言家"
        card.slogan = "每晚可查验一人"
        return card
    }

    static var witch: Card {
        var card = Card()
        card.id = Constants.Witch
        card.name = "女巫"
        card.slogan = "可救活、毒杀一人"
        return card
    }

    static var hunter: Card {
        var card = Card()
        card.id = Constants.Hunter
        card.name = "猎人"
        card.slogan = "死亡时可枪杀一人"
        return card
    }

    static var idiot: Card {
        var card = Card()
        card.id = Constants.Idiot
        card.name = "白痴"
        card.slogan = "被放逐时可免于死亡"
        return card
    }

}
