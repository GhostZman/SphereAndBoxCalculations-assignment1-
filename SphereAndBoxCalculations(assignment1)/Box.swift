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
        
        if (x<0 || y<0 || z<0) {
            xLength = 0
            yLength = 0
            zLength = 0
            
        } else {
            xLength = x
            yLength = y
            zLength = z
        }
        
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
                    
                    var combinedTaskResults :[(Type: String, StringToDisplay: String, Value: Double)] = []
                    for await result in taskGroup{
                        combinedTaskResults.append(result)
                    }
                    return combinedTaskResults
                })
                let sortedCombinedResults = returnedResults.sorted(by: { $0.0 < $1.0})
                print(returnedResults)
                print(sortedCombinedResults)
                
                await setButtonEnable(state: true)
            }
            return true
        }
        
        
    
    /// Calculates the surface area of a box
    /// - Parameters:
    ///   - x: length of box in the x direction (units of length)
    ///   - y: length of box in the y direction (units of length)
    ///   - z: length of box in the z direction (units of length)
    /// - Returns: the surface area of the box
    func calculateSurfaceArea(x: Double, y: Double, z: Double) async -> (Type: String, StringToDisplay: String, Value: Double){
        // Surface area = 2(xy + yz + xz)
        let calculatedSurfaceArea = 2*(x*y + y*z + x*z)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceAreaValue: calculatedSurfaceArea)
        
        return (Type: "Surface Area", StringToDisplay: newSurfaceAreaText, Value: calculatedSurfaceArea)
    }
    
    /// Calculates the volume of a box
    /// - Parameters:
    ///   - x: length of box in the x direction (units of length)
    ///   - y: length of box in the y direction (units of length)
    ///   - z: length of box in the z direction (units of length)
    /// - Returns: the volume of the box
    func calculateVolume(x: Double, y: Double, z: Double) async -> (Type: String, StringToDisplay: String, Value: Double){
        //Volume = xyz
        let calculatedVolume = x*y*z
        let newVolumeText = String(format: "%7.5", calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volumeValue: calculatedVolume)
        
        return (Type: "Volume", StringToDisplay: newVolumeText, Value: calculatedVolume)
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
    @MainActor func updateSurfaceArea(surfaceAreaTextString: String){
        surfaceAreaText = surfaceAreaTextString
    }
    @MainActor func newSurfaceAreaValue(surfaceAreaValue: Double){
        self.surfaceArea = surfaceAreaValue
    }
    @MainActor func updateVolume(volumeTextString: String){
        volumeText = volumeTextString
    }
    @MainActor func newVolumeValue(volumeValue: Double){
        self.volume = volumeValue
    }
}
