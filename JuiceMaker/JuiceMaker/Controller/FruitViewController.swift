//
//  FruitViewController.swift
//  JuiceMaker
//
//  Created by Jason on 2023/01/11.
//

import UIKit

protocol ChangeStockDelegate: AnyObject {
    func changeCurrentStock(vc: FruitViewController)
}


class FruitViewController: UIViewController {
    
    private let fruitStore = FruitStore.shared
    
    @IBAction func touchUpDismissButton(_ sender: UIBarButtonItem) {
        if isStockChanged {
            self.delegate?.changeCurrentStock(vc: self)
        }
        dismiss(animated: true)
    }
    
    @IBOutlet var fruitEmojiBundle: [UILabel]!
    @IBOutlet var fruitStoreCountBundle: [UILabel]!
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineAppleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    weak var delegate: ChangeStockDelegate?
    private var isStockChanged: Bool = false
    
    private func initCountBundle(bundles: [UILabel]) {
        for (bundle, fruit) in zip(bundles, Fruit.allCases) {
            bundle.text = String(fruitStore.sendBackToAvailableStock(fruit: fruit))
        }
    }
    
    private func initSteppers() {
        strawberryStepper.value = Double(fruitStore.sendBackToAvailableStock(fruit: .strawberry))
        bananaStepper.value = Double(fruitStore.sendBackToAvailableStock(fruit: .banana))
        pineAppleStepper.value = Double(fruitStore.sendBackToAvailableStock(fruit: .pineApple))
        kiwiStepper.value = Double(fruitStore.sendBackToAvailableStock(fruit: .kiwi))
        mangoStepper.value = Double(fruitStore.sendBackToAvailableStock(fruit: .mango))
    }
    
    @IBAction func strawberryStepper(_ sender: UIStepper) {
        fruitStoreCountBundle.forEach { label in
            if label.accessibilityLabel == "strawberry" {
                fruitStore.store.updateValue(Int(sender.value), forKey: .strawberry)
                label.text = String(fruitStore.sendBackToAvailableStock(fruit: .strawberry))
                isStockChanged = true
            }
        }
    }
    
    @IBAction func bananaStepper(_ sender: UIStepper) {
        fruitStoreCountBundle.forEach { label in
            if label.accessibilityLabel == "banana" {
                fruitStore.store.updateValue(Int(sender.value), forKey: .banana)
                label.text = String(fruitStore.sendBackToAvailableStock(fruit: .banana))
                isStockChanged = true
            }
        }
    }
    
    @IBAction func pineAppleStepper(_ sender: UIStepper) {
        fruitStoreCountBundle.forEach { label in
            if label.accessibilityLabel == "pineApple" {
                fruitStore.store.updateValue(Int(sender.value), forKey: .pineApple)
                label.text = String(fruitStore.sendBackToAvailableStock(fruit: .pineApple))
                isStockChanged = true
            }
        }
    }
    
    @IBAction func kiwiStepper(_ sender: UIStepper) {
        fruitStoreCountBundle.forEach { label in
            if label.accessibilityLabel == "kiwi" {
                fruitStore.store.updateValue(Int(sender.value), forKey: .kiwi)
                label.text = String(fruitStore.sendBackToAvailableStock(fruit: .kiwi))
                isStockChanged = true
            }
        }
    }
    
    @IBAction func mangoStepper(_ sender: UIStepper) {
        fruitStoreCountBundle.forEach { label in
            if label.accessibilityLabel == "mango" {
                fruitStore.store.updateValue(Int(sender.value), forKey: .mango)
                label.text = String(fruitStore.sendBackToAvailableStock(fruit: .mango))
                isStockChanged = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCountBundle(bundles: fruitStoreCountBundle)
        initSteppers()
    }
}
