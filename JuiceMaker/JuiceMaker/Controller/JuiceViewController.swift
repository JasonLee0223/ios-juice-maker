//
//  JuiceMaker - JuiceViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceViewController: UIViewController {
    
    @IBOutlet var juiceEmojiBundle: [UILabel]!
    @IBOutlet var juiceStoreCountBundle: [UILabel]!
    @IBOutlet var mixJuiceOrderBundle: [UIButton]!
    @IBOutlet var singleJuiceOrderBundle: [UIButton]!
    
    @IBAction func mixJuiceOrder(_ sender: UIButton) {
        guard let juiceType = sender.currentTitle else {
            return
        }
        switch juiceType {
        case "딸바쥬스 주문":
            makeAndUpdate(juiceType: .strawberryBanana)
        case "망키쥬스 주문":
            makeAndUpdate(juiceType: .mangoKiwi)
        default:
            break
        }
    }
    
    @IBAction func singleJuiceOrder(_ sender: UIButton) {
        guard let juiceType = sender.currentTitle else {
            return
        }
        switch juiceType {
        case "딸기쥬스 주문":
            makeAndUpdate(juiceType: .strawberry)
            successAlert(juiceType: "🍓")
        case "바나나쥬스 주문":
            makeAndUpdate(juiceType: .banana)
            successAlert(juiceType: "🍌")
        case "파인애플쥬스 주문":
            makeAndUpdate(juiceType: .pineApple)
            successAlert(juiceType: "🍍")
        case "키위쥬스 주문":
            makeAndUpdate(juiceType: .kiwi)
            successAlert(juiceType: "🥝")
        case "망고쥬스 주문":
            makeAndUpdate(juiceType: .mango)
            successAlert(juiceType: "🥭")
        default:
            break
        }
    }
    
    private let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentStockDisplay(on: juiceEmojiBundle, change: juiceStoreCountBundle)
    }
    
    func currentStockDisplay(on emojiLabels: [UILabel], change countLabels: [UILabel]) {
        for (emojiLabel, countLabel) in zip(emojiLabels, countLabels) {
            guard let checkTest = emojiLabel.text else {
                return
            }
            
            switch checkTest {
            case "🍓":
                countLabel.text = currentStock(fruitName: .strawberry)
            case "🍌":
                countLabel.text = currentStock(fruitName: .banana)
            case "🍍":
                countLabel.text = currentStock(fruitName: .pineApple)
            case "🥝":
                countLabel.text = currentStock(fruitName: .kiwi)
            case "🥭":
                countLabel.text = currentStock(fruitName: .mango)
            default:
                return
            }
        }
    }

    func currentStock(fruitName: Fruit) -> String {
        guard let fruitStock = juiceMaker.fruitStore.store[fruitName] else {
            return ""
        }
        return String(fruitStock)
    }
    
    func makeAndUpdate(juiceType: SingleFruitJuice) {
        juiceMaker.make(single: juiceType)
        currentStockDisplay(on: juiceEmojiBundle, change: juiceStoreCountBundle)
    }
    
    func makeAndUpdate(juiceType: MixFruitJuice) {
        juiceMaker.make(mix: juiceType)
        currentStockDisplay(on: juiceEmojiBundle, change: juiceStoreCountBundle)
    }
    
    func successAlert(juiceType: String) {
        let alert = UIAlertController(title: "", message: "\(juiceType)쥬스 나왔습니다! 맛있게 드세요!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "예", style: .default, handler: nil)
            
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
        }
        
//        func failiureAlert() {
//            let alert = UIAlertController(title: "재료가 모자라요.", message: "재고를 수정할까요?", preferredStyle: .alert)
//
//            let defaultAction = UIAlertAction(title: "예", style: .default, handler: { (action) in self.navigationController?.pushViewController(StockViewController(), animated: true)})
//            let cancleAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
//
//            alert.addAction(defaultAction)
//            alert.addAction(cancleAction)
//
//            present(alert, animated: true, completion: nil)
//        }

}

