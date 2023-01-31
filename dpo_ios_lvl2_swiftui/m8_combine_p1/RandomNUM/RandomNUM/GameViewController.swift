//
//  ViewController.swift
//  RandomNUM
//
//  Created by Николай Ногин on 29.11.2022.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    
    private var message = "Здесь появится подсказка"
    private var randomNum = Int.random(in: 1...100)
    private var subscription: AnyCancellable? = nil
    private var timerPublisher: AnyCancellable? = nil
    private var passedTime: Int = 0
    
    private lazy var mainVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var headerSubHeaderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var messageTextFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var gameHeader: UILabel = {
        let label = UILabel()
        label.text = "Угадай число!"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .purple
        return label
    }()
    
    private lazy var gameSubHeader: UILabel = {
        let label = UILabel()
        label.text = "Число от 1 до 100"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gameTime: UILabel = {
        let label = UILabel()
        label.text = "Время: 00:00"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var numGuessTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите число сюда"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать сначала", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(headerSubHeaderStack)
        headerSubHeaderStack.addArrangedSubview(gameHeader)
        headerSubHeaderStack.addArrangedSubview(gameSubHeader)
        
        mainVerticalStack.addArrangedSubview(gameTime)
        
        mainVerticalStack.addArrangedSubview(messageTextFieldStack)
        messageTextFieldStack.addArrangedSubview(messageLabel)
        messageTextFieldStack.addArrangedSubview(numGuessTextField)
        
        mainVerticalStack.addArrangedSubview(restartButton)
        
        applyConstraints()
        
        restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
        
        subscription = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: numGuessTextField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .map { self.checkUserInput(arg: $0) }
            .sink {}
        
            timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map { _ in
                self.passedTime += 1
                let pt = self.passedTime
                return "Прошл\(pt == 1 ? "а" : "о") \(pt) \((pt == 1) ? "секунда" : (pt >= 2 && pt <=  4) ? "секунды" : "секунд")"
            }
            .assign(to: \.text, on: self.gameTime)
    }
    
    func applyConstraints() {
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainVerticalStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        mainVerticalStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        mainVerticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        mainVerticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        headerSubHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        headerSubHeaderStack.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        gameHeader.translatesAutoresizingMaskIntoConstraints = false
        
        messageTextFieldStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        numGuessTextField.translatesAutoresizingMaskIntoConstraints = false
        numGuessTextField.leftAnchor.constraint(equalTo: mainVerticalStack.leftAnchor).isActive = true
        numGuessTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func restartAction(sender: UIButton!) {
        randomNum = Int.random(in: 1...100)
        numGuessTextField.text = ""
        passedTime = 0
        messageLabel.text = "Попробуй угадать еще раз!"
        gameTime.text = "Прошло \(passedTime) секунд"
  
        
        subscription = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: numGuessTextField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .map { self.checkUserInput(arg: $0) }
            .sink {}
        
        timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .map { _ in
            self.passedTime += 1
            let pt = self.passedTime
            return "Прошл\(pt == 1 ? "а" : "о") \(pt) \((pt == 1) ? "секунда" : (pt >= 2 && pt <=  4) ? "секунды" : "секунд")"
        }
        .assign(to: \.text, on: self.gameTime)
    }
    
    func checkUserInput(arg: String) {
        if let safeNum = Int(arg) {
            
            if safeNum > self.randomNum {
                self.messageLabel.text = "Загаданное число меньше"
                self.messageLabel.textColor = .red
            } else if safeNum < self.randomNum {
                self.messageLabel.text = "Загаданное число больше"
                self.messageLabel.textColor = .brown
            } else {
                self.messageLabel.text = "Угадали!"
                self.messageLabel.textColor = .red
                self.timerPublisher?.cancel()
                self.gameTime.text = "Вы угадали за \(self.passedTime) секунд"
                self.subscription?.cancel()
            }
            
        }
    }
}

