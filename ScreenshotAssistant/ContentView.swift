//
//  ContentView.swift
//  ScreenshotAssistant
//
//  Created by Luke Drushell on 2/22/23.
//

import SwiftUI
import Foundation

//6.5" = 1284x2778
//5.5" = 1242x2208

struct ContentView: View {
    
    @State private var largeScreenshots: [SC] = [SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black.opacity(0.6), shadowRadius: 15, shadowX: 10, shadowY: 10)]
    
    @State private var smallScreenshots: [SC] = [SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black.opacity(0.6), shadowRadius: 15, shadowX: 10, shadowY: 10)]
    
    @State var selectedSC = -1
    @State var selectedSCSmall = -1
    
    let sizes = ["6.5 [1284x2778]", "5.5 [1242x2208]"]
    @State var selectedSize = "6.5 [1284x2778]"
    
    func selectedCount() -> Int {
        if selectedSize == "6.5 [1284x2778]" {
            return largeScreenshots.count
        }
        return smallScreenshots.count
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Screenshot Assistant")
                    .font(.largeTitle.bold())
                    .padding(.leading, 20)
                Spacer()
                Picker("Screenshots Size", selection: $selectedSize, content: {
                    ForEach(sizes, id: \.self) { size in
                        Text(size)
                    }
                }) .frame(width: 250)
                    .onChange(of: selectedSize, perform: { _ in
                        selectedSC = -1
                    })
                Button {
                    var images: [NSImage] = []
                    for img in (selectedSize == "6.5 [1284x2778]" ? largeScreenshots : smallScreenshots) {
                        if selectedSize == "6.5 [1284x2778]" {
                            let renderer = ImageRenderer(content: LargeRenderView(sc: img))
                            let newImage = renderer.nsImage
                            if newImage != nil { images.append(newImage!) }
                        } else {
                            let renderer = ImageRenderer(content: SmallRenderView(sc: img))
                            let newImage = renderer.nsImage
                            if newImage != nil { images.append(newImage!) }
                        }
                    }
                    saveResizedImages(images)
                } label: {
                    Image(systemName: "arrow.down.doc.fill")
                        .font(.largeTitle.bold())
                        .padding(.trailing, 20)
                } .buttonStyle(.borderless)
            }
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if selectedSize == "6.5 [1284x2778]" {
                            ForEach(largeScreenshots.indices, id: \.self, content: { index in
                                let sc = largeScreenshots[index]
                                VStack {
                                    Spacer()
                                    Text(sc.topText)
                                        .foregroundColor(sc.textColor)
                                        .font(.system(size: sc.topSize, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding(.top)
                                        .padding(5)
                                    Spacer()
                                    ZStack(alignment: .center) {
                                        Image(nsImage: sc.image)
                                            .resizable()
                                            .scaledToFit()
                                        //.aspectRatio(0.438, contentMode: .fit)
                                            .scaleEffect(0.95)
                                            .cornerRadius(5)
                                            .shadow(color: sc.shadowColor, radius: sc.shadowRadius, x: sc.shadowX, y: sc.shadowY)
                                        if sc.mockupType == "Clay" {
                                            Image("mockup\(sc.mockupType)")
                                                .resizable()
                                                .scaledToFit()
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        } else if sc.mockupType == "Template" {
                                            Image("mockup\(sc.mockupType)")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(sc.mockupColor)
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        } else {
                                            Image("mockup\(sc.mockupType)")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color.black)
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        }
                                        
                                    } .padding(.horizontal)
                                    Spacer()
                                    Text(sc.bottomText)
                                        .foregroundColor(sc.textColor)
                                        .font(.system(size: sc.bottomSize, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom)
                                        .padding(5)
                                    Spacer()
                                } .aspectRatio(0.462, contentMode: .fit)
                                    .background(sc.background)
                                    .cornerRadius(25)
                                    .onTapGesture {
                                        selectedSC = index
                                    }
                            })
                            Button {
                                if largeScreenshots.isEmpty {
                                    largeScreenshots.append(
                                        SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black, shadowRadius: 15, shadowX: 10, shadowY: 10)
                                    )
                                } else {
                                    largeScreenshots.append(largeScreenshots.last!)
                                }
                                selectedSC = largeScreenshots.count - 1
                            } label: {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .aspectRatio(0.462, contentMode: .fit)
                                    .cornerRadius(25)
                                    .overlay(alignment: .center, content: {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color(nsColor: NSColor.lightGray))
                                    })
                            }.buttonStyle(.borderless)
                        } else {
                            ForEach(smallScreenshots.indices, id: \.self, content: { index in
                                let sc = smallScreenshots[index]
                                VStack {
                                    Spacer()
                                    Text(sc.topText)
                                        .foregroundColor(sc.textColor)
                                        .font(.system(size: sc.topSize, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding(.top)
                                        .padding(5)
                                    Spacer()
                                    ZStack(alignment: .center) {
                                        Image(nsImage: sc.image)
                                            .resizable()
                                            .scaledToFit()
                                        //.aspectRatio(0.438, contentMode: .fit)
                                            .scaleEffect(0.755)
                                            .cornerRadius(5)
                                            .shadow(color: sc.shadowColor, radius: sc.shadowRadius, x: sc.shadowX, y: sc.shadowY)
                                        if sc.mockupType == "Clay" {
                                            Image("mockup\(sc.mockupType)Small")
                                                .resizable()
                                                .scaledToFit()
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        } else if sc.mockupType == "Template" {
                                            Image("mockup\(sc.mockupType)Small")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(sc.mockupColor)
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        } else {
                                            Image("mockup\(sc.mockupType)Small")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color.black)
                                            //.aspectRatio(0.4973, contentMode: .fit)
                                                .shadow(color: .clear, radius: 0)
                                        }
                                        
                                    } .padding(.horizontal)
                                    Spacer()
                                    Text(sc.bottomText)
                                        .foregroundColor(sc.textColor)
                                        .font(.system(size: sc.bottomSize, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom)
                                        .padding(5)
                                    Spacer()
                                } .aspectRatio(0.5625, contentMode: .fit)
                                    .background(sc.background)
                                    .cornerRadius(25)
                                    .onTapGesture {
                                        selectedSCSmall = index
                                    }
                            })
                            Button {
                                if smallScreenshots.isEmpty {
                                    smallScreenshots.append(
                                        SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black, shadowRadius: 15, shadowX: 10, shadowY: 10)
                                    )
                                } else {
                                    smallScreenshots.append(smallScreenshots.last!)
                                }
                                selectedSCSmall = smallScreenshots.count - 1
                            } label: {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .aspectRatio(0.462, contentMode: .fit)
                                    .cornerRadius(25)
                                    .overlay(alignment: .center, content: {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color(nsColor: NSColor.lightGray))
                                    })
                            }.buttonStyle(.borderless)
                        }
                    }
                }
                Divider()
                Spacer()
                if selectedSize == "6.5 [1284x2778]" {
                    if selectedSC != -1 && largeScreenshots.count > selectedSC {
                        ImageOptions(screenshots: $largeScreenshots, selectedSC: $selectedSC)
                    }
                } else {
                    if selectedSCSmall != -1 && smallScreenshots.count > selectedSCSmall {
                        ImageOptions(screenshots: $smallScreenshots, selectedSC: $selectedSCSmall)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SC: Hashable {
    var background: Color // Done
    var topText: String // Done
    var bottomText: String // Done
    var textColor: Color // Done
    var image: NSImage // Done
    var mockupType: String
    var mockupColor: Color
    var topSize: CGFloat // Done
    var bottomSize: CGFloat // Done
    var shadowColor: Color // Done
    var shadowRadius: CGFloat // Done
    var shadowX: CGFloat // Done
    var shadowY: CGFloat // Done
}
