//
//  ViewController.swift
//  Lab - Life cicles
//
//  Created by Arkadiy Grigoryanc on 12/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

protocol MessageProtocol {
    func newMessage(_ message: Message)
}

class ViewController: UIViewController {
    
    // MARK: - Private properties
    private var backgroundColor: UIColor?
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet { titleLabel?.text = title }
    }
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //tabBarItem.title = title
        message()
    }
    
    deinit {
        message()
    }
    
    // MARK: - Life cicles
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = view.backgroundColor
        message()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = view.backgroundColor   // Set tint color
        message()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        message()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        message()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        message()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        message()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        message()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        message()
    }
    
    override func loadView() {
        super.loadView()
        message()
    }
    
    // MARK: - Private methods
    private func message(_ function: String = #function) {
        
        let message = Message(functionName: function, title: title, color: backgroundColor, date: Date())
        
        (tabBarController as? TabBarController)?.messageDelegate?.newMessage(message)
    }
    
}
