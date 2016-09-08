//
//  GreetingViewController.swift
//  MVVM test
//
//  Created by Serhii Onopriienko on 9/9/16.
//  Copyright © 2016 Edsson. All rights reserved.
//

import UIKit

protocol GreetingViewModel {
    
    var person: Person? {get set}
    var greetingDidShow: ((String) -> Void)? { get set }
    var greetingDidHide: ((String) -> Void)? { get set }
    var didUpdatePerson: ((String) -> Void)? { get set }
    
    func generatePerson()
    func showGreeting()
    func hideGreeting()
}

class GreetingViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    
    var viewModel: GreetingViewModel! {
        didSet {
            viewModel.generatePerson()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        
        //Binding
        viewModel.greetingDidShow = {
            self.greetingLabel.text = $0
        }
        
        viewModel.greetingDidHide = {
            self.greetingLabel.text = $0
        }
        
        viewModel.didUpdatePerson = {
            self.updatedLabel.text = $0
        }
    }
    
    @IBAction func updateAction(sender: AnyObject) {
        viewModel.generatePerson()
    }

    @IBAction func showAction(sender: AnyObject) {
        viewModel.showGreeting()
    }
    
    @IBAction func hideAction(sender: AnyObject) {
        viewModel.hideGreeting()
    }
}


extension GreetingViewController {
    
    class ViewModel: GreetingViewModel {
        
        var person: Person? {
            didSet {
                didUpdatePerson?(NSDate().dateStringWithFormat("HH:mm:ss"))
            }
        }
        
        var greetingDidShow: ((String) -> Void)?
        var greetingDidHide: ((String) -> Void)?
        var didUpdatePerson: ((String) -> Void)?

        func generatePerson() {
            let firstName = String(Int(arc4random_uniform(6) + 1))
            let lastName = String(Int(arc4random_uniform(6) + 1))
            self.person = Person(firstName: firstName, lastName: lastName)
        }
        
        func showGreeting() {
            let firstName = person?.firstName ?? "Unnown"
            let lastName = person?.lastName ?? "Unnown"
            greetingDidShow?("Hello" + " " + firstName + " " + lastName)
        }
        
        func hideGreeting() {
            greetingDidHide?("")
        }
    }
}
