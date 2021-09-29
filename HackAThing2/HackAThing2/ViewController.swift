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
        
        // implement the delegate so that did add anchors gets called
        arView.session.delegate = self
        
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
        let tapLocation = recognizer.location(in:arView)
        
        // Use a raycast to determine if this location is intersecting with a real world physical surface
        
        // We are use plane detection to find these surfaces
        // set allowing to either be more or less precise about what planes are allowed
        // Then we set to only find horizontal planes
        let results = arView.raycast(from: tapLocation , allowing: .estimatedPlane, alignment: .horizontal)
        
    
        // Check if we have a result
        if let firstResult = results.first{
            // All objects must be added to anchors
            // To create multi user AR experiences we synchronize to these anchors
            
            let anchor = ARAnchor(name:"shoe",transform: firstResult.worldTransform)
            
            arView.session.add(anchor: anchor)
            
            print("shoed added")
        }else{
            
            let verticalResults = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
            
            if let verticalResult = verticalResults.first{
                let anchor = ARAnchor(name:"clock", transform: verticalResult.worldTransform)
                arView.session.add(anchor: anchor)
                print("clock added")
            }else{
                
                print("No Surface found")
            }
            
        }
        
       
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor){
        // All objects in reality scene are entities, in this case model entity
        
        
        // Create a model entity
        
        guard let path = Bundle.main.path(forResource: entityName, ofType: "usdz")else{
            fatalError("Couldn't find file")
        }
        let url = URL(fileURLWithPath: path)
       
        
        let entity = try! ModelEntity.loadModel(contentsOf: url, withName:"BearStatue")
        
        
        // Allow us to drag and rotate object
        entity.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation, .translation, .scale], for: entity)
        
        

        // Create anchor entity
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(entity)
        
        // Add it to our scene
        arView.scene.addAnchor(anchorEntity)
        
    }


}

// Author of tutorial notes that there are easier ways to just place an object using RealityKit, but we are using ARkit to allow for future more complicated effects
extension ViewController : ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // Go through the anchors
        for anchor in anchors{
            if let anchorName = anchor.name, (anchorName == "shoe" || anchorName == "clock"){
                placeObject(named:anchorName, for: anchor)
                
            }
        }
    }
    
}
