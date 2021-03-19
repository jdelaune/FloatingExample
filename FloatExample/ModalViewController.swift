//
//  ViewController.swift
//  FloatExample
//
//  Created by Jordan de Laune on 19/03/2021.
//

import UIKit
import FloatingPanel

class ModalViewController: UIViewController, FloatingPanelControllerDelegate {
    var fpc: FloatingPanelController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize a `FloatingPanelController` object.
        fpc = FloatingPanelController()

        // First Attempt: But but still get the bounce using isModalInPresentation
        isModalInPresentation = false
        
        // Second Attempt: A bit hacky but disable the recognizer. Works for the ModalViewController.
        // However when dismissing the floating panel it is pulling down the modal again.
        let recognizers = navigationController?.presentationController?.presentedView?.gestureRecognizers

        if let firstRecognizer = recognizers?.first {
            firstRecognizer.isEnabled = false
        }

        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional

        // Set a content view controller.
        let contentVC = UITableViewController()
        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
        fpc.track(scrollView: contentVC.tableView)

        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
    }
}
