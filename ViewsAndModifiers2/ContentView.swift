//
//  ContentView.swift
//  ViewsAndModifiers2
//
//  Created by Waihon Yew on 30/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // Flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

struct TuperViewContentView: View {
    var body: some View {
        // Swift silently applies a special attribute to the body property
        // called @ViewBuilder. This has the effect of silently wrapping
        // multiple views in one of TupleView containers.
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
    }
}

struct TextContentView: View {
    var body: Text {
        Text("Hello, world!")
    }
}

struct TextPaddingBackgroundContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
    }
}

struct ButtonFrameBackgroundContentView: View {
    var body: some View {
        Button("Hello, world!") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(.red)
    }
}

struct ButtonBackgroundFrameContentView: View {
    var body: some View {
        Button("Hello, world!") {
            print(type(of: self.body))
        }
        .background(.red)
        .frame(width: 200, height: 200)
    }
}

struct TextMaxFrameBackgroundContentView: View {
    var body: some View {
        Text("Hello, world!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
