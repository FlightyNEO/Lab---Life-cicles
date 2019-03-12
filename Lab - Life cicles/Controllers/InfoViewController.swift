//
//  InfoViewController.swift
//  Lab - Life cicles
//
//  Created by Arkadiy Grigoryanc on 12/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Private properties
    private let cellIdentifier = "MessageCell"
    private let tabBarSegueIdentifier = "TabBarSegue"
    
    private var bottomController: UITabBarController?
    
    private var isMaximize = false
    
    private var messages = [Message]()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var maximizeButton: UIButton!
    
    // MARK: - Constraints outlets
    // Constraints
    @IBOutlet weak var viewTopTableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightCostraints: NSLayoutConstraint!
    @IBOutlet weak var bottomTableViewBottomConstraint: NSLayoutConstraint!
    
    // Constraints mazimizeButton
    @IBOutlet weak var buttonCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Detect orientation
        animateHideButton(UIDevice.current.orientation.isLandscape) {
            // Hide/show button
            self.maximizeButton.isHidden = UIDevice.current.orientation.isLandscape
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
//        // Detect orientation
//        animateHideButton(UIDevice.current.orientation.isLandscape) {
//            // Hide/show button
//            self.maximizeButton.isHidden = UIDevice.current.orientation.isLandscape
//        }
        
        // Set default settings
        bottomController?.tabBar.isHidden = false
        isMaximize = false
        
    }
    
    // MARK: - Actions
    @IBAction func actionMaximize(_ sender: UIButton) {
        
        // Maximize / Minimize tableView
        if isMaximize {
            animateMinimize {
                // Hide tabBar
                self.bottomController?.tabBar.isHidden = false
            }
        } else {
            animateMaximize {
                // Hide tabBar
                self.bottomController?.tabBar.isHidden = true
            }
        }
        
        isMaximize.toggle()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == tabBarSegueIdentifier {
            let destination = segue.destination as! TabBarController
            destination.messageDelegate = self  // Set delegate for TabBarController
            bottomController = destination
        }
        
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.message = messages[indexPath.row]
        return cell
        
    }
    
    
}

// MARK: - MessageProtocol
extension InfoViewController: MessageProtocol {
    
    func newMessage(_ message: Message) {
        
        messages.insert(message, at: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
        
    }
    
}

// MARK: - Animation
extension InfoViewController {
    
    private func animateMaximize(completion: (() -> Void)? = nil) {
        
        // TableVew constraints
        bottomTableViewBottomConstraint.isActive = true
        viewTopTableViewBottomConstraint.isActive = false
        tableViewHeightCostraints.isActive = false
        
        // maximizeButton constraints
        buttonCenterYConstraint.isActive = false
        buttonCenterXConstraint.isActive = false
        
        buttonLeadingConstraint.isActive = true
        buttonBottomConstraint.isActive = true
        
        // Animation
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.maximizeButton.setTitle("▲", for: [])
            
            self.view.layoutIfNeeded()
            
        }) { completed in completion?() }
        
    }
    
    private func animateMinimize(completion: (() -> Void)? = nil) {
        
        // TableVew constraints
        bottomTableViewBottomConstraint.isActive = false
        viewTopTableViewBottomConstraint.isActive = true
        tableViewHeightCostraints.isActive = true
        
        // maximizeButton constraints
        buttonCenterYConstraint.isActive = true
        buttonCenterXConstraint.isActive = true
        
        buttonLeadingConstraint.isActive = false
        buttonBottomConstraint.isActive = false
        
        // Animation
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.maximizeButton.setTitle("▼", for: [])
            
            self.view.layoutIfNeeded()
            
        }) { completed in completion?() }
        
    }
    
    private func animateHideButton(_ flag: Bool, completion: (() -> Void)? = nil) {
        
        // Set alpha component for button background color
        var color = maximizeButton.backgroundColor
        color = color?.withAlphaComponent(flag ? 0 : 1)
        
        // Animation
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            
            self.maximizeButton.backgroundColor = color
            self.maximizeButton.setTitle("▼", for: [])
            
        }) { completed in completion?() }
        
    }
    
}
