//
//  Sphere.swift
//  SphereAndBoxCalculations(assignment1)
//
//  Created by Phys440Zachary on 1/12/24.
//

import SwiftUI
import Observation

@Observable class Sphere{
    var radius = 0.0
    var centerOfSphere = (x:0.0, y:0.0, z:0.0)
    var surfaceArea = 0.0
    var volume = 0.0
    var surfaceAreaText = ""
    var volumeText = ""
    var enableButton = true
    
    
    /// Initializes the Box and Calculates the surface area and volume
    /// - Parameters:
    ///   - r: radius of sphere (units of length)
    func initWithRadius(r:Double) -> Bool {
        if r < 0 {
            radius = 0
        } else {
            radius = r
        }
        
        Task{
            await setButtonEnable(state: false)
            
            let returnedResults = await withTaskGroup(
                of: (Type: String, StringToDisplay: String, Value: Double).self,
                returning: [(Type: String, StringToDisplay: String, Value: Double)].self,
                body: { taskGroup in
                    taskGroup.addTask{ let surfaceAreaResult = await self.calculateSurfaceArea(r: self.radius)
                        
                        return surfaceAreaResult
                    }
                        
                    taskGroup.addTask{ let volumeResult = await self.calculateVolume(r: self.radius)
                        
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
        
        
    
    /// Calculates the surface area of the sphere object
    /// - Parameter r: radius of sphere (units of length)
    /// - Returns: surface area of sphere
    func calculateSurfaceArea(r: Double) async -> (Type: String, StringToDisplay: String, Value: Double){
        // Surface area = 4 * pi * r^2
        let calculatedSurfaceArea = 4 * Double.pi * r * r
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceAreaValue: calculatedSurfaceArea)
        
        return (Type: "Surface Area", StringToDisplay: newSurfaceAreaText, Value: calculatedSurfaceArea)
    }
    
    /// Calculates the volume of the sphere object
    /// - Parameter r: radius of sphere (units of length)
    /// - Returns: volume of sphere
    func calculateVolume(r: Double) async -> (Type: String, StringToDisplay: String, Value: Double){
        //Volume = 4/3 * pi * r^3
        let calculatedVolume = (4/3) * Double.pi * r * r * r
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
