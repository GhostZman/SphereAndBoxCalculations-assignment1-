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
                TextField("Enter radius of sphere ...", text:$radiusString, onCommit: {self.calculate()})
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
                        TextField("", text: $mySphere.surfaceAreaText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                    HStack {
                        Text("Volume: ")
                        TextField("", text: $mySphere.volumeText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                }
                VStack{
                    Text("Box")
                    HStack {
                        Text("Surface Area: ")
                        TextField("", text: $myBox.surfaceAreaText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                    HStack {
                        Text("Volume: ")
                        TextField("", text: $myBox.volumeText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 0)
                    }
                }
            }
        }
        .padding()
    }
    func calculate() {
        mySphere.enableButton = false
        myBox.enableButton = false
        
        let _ : Bool = mySphere.initWithRadius(r: Double(radiusString)!)
    }
}

#Preview {
    ContentView()
}
