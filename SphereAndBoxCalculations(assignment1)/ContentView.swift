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
    
    var body: some View {
        HStack {
            Text("Radius: ")
            
            //TextField("Enter radius of sphere ...")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
