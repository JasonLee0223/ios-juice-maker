//
//  FruitStoreViewController.swift
//  JuiceMaker
//
//  Created by Jason on 2023/01/08.
//

import UIKit

class FruitStoreViewController: UIViewController {
    
    @IBOutlet var fruitEmojiBundle: [UILabel]!
    @IBOutlet var fruitStoreCountBundle: [UILabel]!
    @IBOutlet var stepperBundle: [UIStepper]!
    
    @IBAction func fruitCounting(_ sender: UIStepper) {
        switch fruitEmojiBundle.text {
        case "🍓":
            fruitStoreCountBundle[0].text = Int(sender.value).description
            break
        case "🍌":
            fruitStoreCountBundle[1].text = Int(sender.value).description
            break
        case "🍍":
            fruitStoreCountBundle[2].text = Int(sender.value).description
            break
        case "🥝":
            fruitStoreCountBundle[3].text = Int(sender.value).description
            break
        case "🥭":
            fruitStoreCountBundle[4].text = Int(sender.value).description
            break
        default:
            print("어렵네...")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이런식으로 각각의 stepper의 value값에 할당할 수 있게 잘 생각해보자!
        // for (emoji, storeCount, stepper) in 0...fruitEmojiBundle.count { }
        // 이렇게 같은 수를 돌아서 필요한 것을 넣어보면 어떨까??
        for index in stepperBundle {
            index.value
        }
    }
    
    // fruitEmojiBundle의 각 배열요소마다 text = Optional("이모지")
    // fruitStoreCountBundle의 각 배열요소마다 text = Optional("0")
    // stepperBundle의 각 배열요소마다
}
