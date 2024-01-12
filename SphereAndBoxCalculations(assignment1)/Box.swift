//
//  Box.swift
//  SphereAndBoxCalculations(assignment1)
//
//  Created by Phys440Zachary on 1/12/24.
//

import SwiftUI
import Observation

@Observable class Box {
    
    var xLength = 0.0
    var yLength = 0.0
    var zLength = 0.0
    var centerOfBox = (x:0.0, y:0.0, z:0.0)
    var surfaceArea = 0.0
    var volume = 0.0
    var surfaceAreaText = ""
    var volumeText = ""
    var enableButton = true
    
    
    /// Initializes the Box and Calculates the surface area and volume
    /// - Parameters:
    ///   - x: length of box in the x direction (units of length)
    ///   - y: length of box in the y direction (units of length)
    ///   - z: length of box in the z direction (units of length)
    func initWithLengths(x:Double, y:Double, z:Double) -> Bool {
        
        xLength = x
        yLength = y
        zLength = z
        
        Task{
            await setButtonEnable(state: false)
            
            let returnedResults = await withTaskGroup(
                of: (Type: String, StringToDisplay: String, Value: Double).self,
                returning: [(Type: String, StringToDisplay: String, Value: Double)].self,
                body: { taskGroup in
                    taskGroup.addTask{ let surfaceAreaResult = await self.calculateSurfaceArea(x: self.xLength, y: self.yLength, z: self.zLength)
                        
                        return surfaceAreaResult
                    }
                        
                    taskGroup.addTask{ let volumeResult = await self.calculateVolume(x: self.xLength, y: self.yLength, z: self.zLength)
                        
                        return volumeResult
                    }
                    
                    
                    
                })
            }
        }
    }
        
        
    
    func calculateSurfaceArea(x: Double, y: Double, z: Double){
        
    }
                
    @MainActor func setButtonEnable(state: Bool){
        
        if state {
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run{
                    self.enableButton = false
                }
            }
        }
    }
}
