//
//  ImageOptions.swift
//  ScreenshotAssistant
//
//  Created by Luke Drushell on 2/23/23.
//

import SwiftUI

struct ImageOptions: View {
    
    @Binding var screenshots: [SC]
    @Binding var selectedSC: Int
    
    let mockupTypes = ["Clay", "Template", "iPhone"]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Button {
                    // open file picker
                    let panel = NSOpenPanel()
                    panel.allowedContentTypes = [.image]
                    panel.begin { result in
                        if result == .OK, let url = panel.url {
                            withAnimation {
                                let sourceImage = NSImage(contentsOf: url)!
                                screenshots[selectedSC].image = sourceImage
                            }
                        }
                    }
                } label: {
                    Text("Select Screenshot")
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .background(Color.blue)
                        .cornerRadius(4)
                } .buttonStyle(.borderless)
                HStack {
                    ColorPicker("Background Color", selection: $screenshots[selectedSC].background)
                    ColorPicker("Mockup Color", selection: $screenshots[selectedSC].mockupColor)
                    Picker("", selection: $screenshots[selectedSC].mockupType, content: {
                        ForEach(mockupTypes, id: \.self, content: { type in
                            Text(type)
                        })
                    })
                }
            }
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    TextField("Top Text", text: $screenshots[selectedSC].topText)
                    Text("Text Size:")
                    Slider(value: $screenshots[selectedSC].topSize, in: 12...30)
                }
                HStack {
                    TextField("Bottom Text", text: $screenshots[selectedSC].bottomText)
                    Text("Text Size:")
                    Slider(value: $screenshots[selectedSC].bottomSize, in: 12...30)
                }
                ColorPicker("Text Color", selection: $screenshots[selectedSC].textColor)
            }
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    ColorPicker("Shadow Color", selection: $screenshots[selectedSC].shadowColor)
                    Text("Shadow Radius:")
                    Slider(value: $screenshots[selectedSC].shadowRadius, in: 5...20)
                }
                HStack {
                    Text("Shadow X:")
                    Slider(value: $screenshots[selectedSC].shadowX, in: -15...15)
                    Text("Shadow Y:")
                    Slider(value: $screenshots[selectedSC].shadowY, in: -15...15)
                }
            }
            Divider()
            Button {
                screenshots.remove(at: selectedSC)
            } label: {
                Text("Delete Screenshot")
                    .padding(10)
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .background(Color.red)
                    .cornerRadius(4)
            } .buttonStyle(.plain)
        } .frame(width: (NSScreen.main?.frame.width ?? 1) * 0.35)
    }
}

struct ImageOptions_Previews: PreviewProvider {
    static var previews: some View {
        ImageOptions(screenshots: .constant([SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black.opacity(0.6), shadowRadius: 15, shadowX: 10, shadowY: 10)]), selectedSC: .constant(-1))
    }
}
