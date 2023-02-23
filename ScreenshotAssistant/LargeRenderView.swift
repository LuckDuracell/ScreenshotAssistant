//
//  LargeRenderView.swift
//  ScreenshotAssistant
//
//  Created by Luke Drushell on 2/22/23.
//

import SwiftUI

struct LargeRenderView: View {
    
    let sc: SC
    
    var body: some View {
        VStack {
            Spacer()
            Text(sc.topText)
                .foregroundColor(sc.textColor)
                .font(.system(size: sc.topSize * 4.5, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.top, 100)
                .padding(25)
            Spacer()
            ZStack(alignment: .center) {
                ZStack {
                    Rectangle()
                        .foregroundColor(sc.shadowColor)
                        .frame(width: 1284 * 0.85, height: 2778 * 0.85)
                        .scaleEffect(0.95)
                        .cornerRadius(275)
                        .offset(x: sc.shadowX * 3 , y: sc.shadowY * 3)
                        .blur(radius: sc.shadowRadius * 3)
                    Image(nsImage: sc.image)
                        .resizable()
                        .scaledToFit()
                    //.aspectRatio(0.438, contentMode: .fit)
                        .scaleEffect(0.9)
                        .cornerRadius(275)
                }
                if sc.mockupType == "Clay" {
                    Image("mockup\(sc.mockupType)")
                        .resizable()
                        .scaledToFit()
                    //.aspectRatio(0.4973, contentMode: .fit)
                } else if sc.mockupType == "Template" {
                    Image("mockup\(sc.mockupType)")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(sc.mockupColor)
                    //.aspectRatio(0.4973, contentMode: .fit)
                } else {
                    Image("mockup\(sc.mockupType)")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                    //.aspectRatio(0.4973, contentMode: .fit)
                }
                    
            } .padding(.horizontal)
            Spacer()
            Text(sc.bottomText)
                .foregroundColor(sc.textColor)
                .font(.system(size: sc.bottomSize * 4.5, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 100)
                .padding(25)
            Spacer()
        }
        .scaledToFit()
        .frame(width: 1284, height: 2778)
        .background(sc.background)
    }
}

struct LargeRenderView_Previews: PreviewProvider {
    static var previews: some View {
        LargeRenderView(sc: SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black.opacity(0.6), shadowRadius: 15, shadowX: 10, shadowY: 10))
    }
}
