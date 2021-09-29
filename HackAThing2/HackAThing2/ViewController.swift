//
//  ViewController.swift
//  HackAThing2
//
//  Created by James  Fleming on 9/28/21.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    
    
    // Override the view didAppear, happens when our view appears on the users screen I believe
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup AR view (in reality kit this is automatically done, but in advanced AR applications likely want to override this
        
        setupARView()
        
        // #selector allows us to use an objective c method
        arView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(recognizer:))))
        
    }
    
    // MARK: Setup Methods
    // Start the AR session with our desired configuration
    func setupARView(){
        // Disable the automatic ar configuration
        arView.automaticallyConfigureSession = false
        
        // now create our own
        // We choose world tracking but face tracking and image tracking exists
        // Let means this configuration is a constant, makes sense!
        let configuration = ARWorldTrackingConfiguration()
        
        // Allow plane detection on both axis
        configuration.planeDetection = [.horizontal, .vertical]
        // Will automatically install reflections and make objects in the environment look as real as possible (IOS 12 and above)
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration)
    }
    
    // MARK: Object Placement
    // marks this swift code to be "visible" (not sure what that means) from Objective C code.
    @objc
    func handleTap(recognizer: UITapGestureRecognizer){
        // Translate tap into coordinate in space
        let location = recognizer.location(in:arView)
        
        // Use a raycast to determine if this location is intersecting with a real world physical surface
        
        // We are use plane detection to find these surfaces
        
        
        
    }
    
    
    
   
}
