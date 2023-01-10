//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceViewController: UIViewController {
    
    @IBOutlet var juiceEmojuBundle: [UILabel]!
    @IBOutlet var juiceStoreCountBundle: [UILabel]!
    @IBOutlet var mixJuiceOrderBundle: [UIButton]!
    @IBOutlet var singleJuiceOrderBundle: [UIButton]!
    
    @IBAction func strawBerryAndBannaOrder(_ sender: UIButton) {
        let juiceMaker = makeObject()
        juiceMaker.startMake(mix: .strawberryAndBanana)
        print("딸바쥬스 만들었다 이시키야")
        tempAlert()
    }
    
    @IBAction func mangoAndKiwiOrder(_ sender: UIButton) {
        let juiceMaker = makeObject()
        juiceMaker.startMake(mix: .mangoAndKiwi)
        print("망키쥬스 만들었다 이시키야 망치로 후드려 팰까")
        makeAlert()
    }
    
    @IBAction func strawberryOrder(_ sender: UIButton) {
        let juiceMaker = makeObject()
        juiceMaker.startMake(single: .strawberry)
        print("싱글쥬스다 이시키야")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeInitialStoreCount(by: juiceEmojuBundle)
    }
    
    func makeObject() -> JuiceMaker {
        let calculator = Calculator()
        return JuiceMaker(calculator: calculator)
    }
    
    func makeInitialStoreCount(by fruit: [UILabel]) {
        let juiceMaker = makeObject()
        fruit.forEach { juiceElement in
            // 강제타입변환을 타입캐스팅 방법으로 변환하여 값을 할당할 수 있게끔 변경 요망
            switch juiceElement.text {
            case "🍓":
                juiceStoreCountBundle[0].text = String(juiceMaker.fruitStore.store[.strawberry] ?? 0)
                break
            case "🍌":
                juiceStoreCountBundle[1].text = String(juiceMaker.fruitStore.store[.banana] ?? 1)
                break
            case "🥝":
                juiceStoreCountBundle[2].text = String(juiceMaker.fruitStore.store[.kiwi] ?? 2)
                break
            case "🍍":
                juiceStoreCountBundle[3].text = String(juiceMaker.fruitStore.store[.pineApple] ?? 3)
                break
            case "🥭":
                juiceStoreCountBundle[4].text = String(juiceMaker.fruitStore.store[.mango] ?? 4)
                break
            default:
                print("잘못된 과일이네?")
            }
        }
    }
    
    func tempAlert() {
        // 재고가 있을 경우
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let enoughStoreCountAlert = UIAlertController(title: "쥬스 나왔습니다! 맛있게 드세요!", message: nil, preferredStyle: .alert)
    
        enoughStoreCountAlert.addAction(okAction)
        present(enoughStoreCountAlert, animated: false, completion: nil)
    }
    
    // Boolean 값으로 판별해서 이동하면 좋겠지??
    func makeAlert() {
        let 재고없을때나오는알럿1 = UIAlertAction(title: "네", style: .default) { action in
            print("Alert 닫기")
        }
        
        let 재고없을때나오는알럿2 = UIAlertAction(title: "아니요", style: .default) { action in
            print("재고 수정 화면으로 이동하라잇")
        }
        
        // 재고가 없는 경우
        let lackStoreCountAlert = UIAlertController(title: "재료가 모자라요.", message: "재고를 수정할까요?", preferredStyle: .alert)
        lackStoreCountAlert.addAction(재고없을때나오는알럿1)
        lackStoreCountAlert.addAction(재고없을때나오는알럿2)
        present(lackStoreCountAlert, animated: false, completion: nil)
    }
}

