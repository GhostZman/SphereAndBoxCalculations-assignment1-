//
//  ContentView.swift
//  SphereAndBoxCalculations(assignment1)
//
//  Created by Phys440Zachary on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var myBox = Box()
    @Bindable var mySphere = Sphere()
    @State var radiusString = "1.0"
    var body: some View {
        VStack{
            HStack {
                Text("Radius: ")
                    .padding(.top)
                    .padding(.bottom, 15)
                TextField("Enter radius of sphere ...", text:$radiusString)
                    .padding(.horizontal)
                    .frame(width: 100)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
            }
            HStack {
                VStack{
                    Text("Sphere")
                    HStack {
                        Text("Surface Area: ")
                        Text("\(mySphere.surfaceArea, specifier: "%.2f")")
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                    HStack {
                        Text("Volume: ")
                        Text("\(mySphere.volume, specifier: "%.2f")")
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                }
                VStack{
                    Text("Bounding Box")
                    HStack {
                        Text("Surface Area: ")
                        Text("\(myBox.surfaceArea, specifier: "%.2f")")
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                    HStack {
                        Text("Volume: ")
                        Text("\(myBox.volume, specifier: "%.2f")")
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                }
            }
            Button("Calculate", action: {self.calculate()})
                .padding(.bottom)
                .padding()
                .disabled(mySphere.enableButton == false)
                .disabled(myBox.enableButton == false)
        }
        .padding()
    }
    func calculate() {
        mySphere.enableButton = false
        myBox.enableButton = false
        
        let _ : Bool = mySphere.initWithRadius(r: Double(radiusString)!)
        let _ : Bool = myBox.initWithLengths(x: Double(radiusString)!, y: Double(radiusString)!, z: Double(radiusString)!)
    }
}

#Preview {
    ContentView()
}
