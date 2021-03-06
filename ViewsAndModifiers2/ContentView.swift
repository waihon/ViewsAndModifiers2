//
//  ContentView.swift
//  ViewsAndModifiers2
//
//  Created by Waihon Yew on 30/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false

    var body: some View {
        let agreedToAll = Binding<Bool>(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        )

        return VStack {
            Toggle("Agree to terms", isOn: $agreedToTerms)
            Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
            Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
            Toggle("Agree to all", isOn: agreedToAll)
        }
        .padding()
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct GridContentView: View {
    var body: some View {
        Text("Grid Stack")
            .prominentTitle()
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct WatermarkContentView: View {
    var body: some View {
        Color.blue
            .frame(width: 300, height: 300)
            .watermarked(with: "100 Days of SwiftUI")
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct TitleStyleContentView: View {
    var body: some View {
        Text("Hello, world!")
            .titleStyle()
    }
}

struct TitleModifierContentView: View {
    var body: some View {
        Text("Hello, world!")
            .modifier(Title())
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}
struct ViewCompositionContentView: View {

    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
    }
}

struct DuplicateModifiersContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("First")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())

            Text("Second")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
}

struct MultipleViewsUsingViewBuilderContentView: View {
    @ViewBuilder var spells: some View {
        Text("Draco dormiens")
            .foregroundColor(.red)
        Text("nunquam titllandus")
            .foregroundColor(.blue)
    }

    var body: some View {
        spells
    }
}

struct MultipleViewsUsingGroupContentView: View {
    var spells: some View {
        Group {
            Text("Draco dormiens")
                .foregroundColor(.red)
            Text("nunquam titllandus")
                .foregroundColor(.blue)
        }
    }

    var body: some View {
        spells
    }
}

struct MultipleViewsUsingVStackContentView: View {
    var spells: some View {
        VStack {
            Text("Draco dormiens")
                .foregroundColor(.red)
            Text("nunquam titllandus")
                .foregroundColor(.blue)
        }
    }

    var body: some View {
        spells
    }
}

struct ViewsAsPropertiesContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titllandus")

    var body: some View {
        VStack {
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
        }
    }
}

struct RegularModifiersBlurContentView: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
            Text("Hufflepuff")
                .blur(radius: 0)
            Text("Ravenclaw")
                .blur(radius: 2)
            Text("Slytherin")
        }
        .blur(radius: 2)
    }
}

struct EnvironmentModifiersFontContentView: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
            Text("Hufflepuff")
                .font(.largeTitle)
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
    }
}

struct ConditionalModifiersIfContentView: View {
    @State private var useRedText = false

    var body: some View {
        if useRedText {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundColor(.red)
        } else {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundColor(.blue)
        }
    }
}

struct ConditionalModifiersTernaryContentView: View {
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
