//
//  SmallRenderView.swift
//  ScreenshotAssistant
//
//  Created by Luke Drushell on 2/22/23.
//

import SwiftUI

struct SmallRenderView: View {
    
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
                        .frame(width: 1242 * 0.85, height: 2208 * 0.85)
                        .scaleEffect(0.95)
                        .cornerRadius(275)
                        .offset(x: sc.shadowX * 3 , y: sc.shadowY * 3)
                        .blur(radius: sc.shadowRadius * 3)
                    Image(nsImage: sc.image)
                        .resizable()
                        .scaledToFit()
                    //.aspectRatio(0.438, contentMode: .fit)
                        .scaleEffect(0.76)
                        .cornerRadius(275)
                }
                if sc.mockupType == "Clay" {
                    Image("mockup\(sc.mockupType)Small")
                        .resizable()
                        .scaledToFit()
                    //.aspectRatio(0.4973, contentMode: .fit)
                } else if sc.mockupType == "Template" {
                    Image("mockup\(sc.mockupType)Small")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(sc.mockupColor)
                    //.aspectRatio(0.4973, contentMode: .fit)
                } else {
                    Image("mockup\(sc.mockupType)Small")
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
        .frame(width: 1242, height: 2208)
        .background(sc.background)
    }
}

struct SmallRenderView_Previews: PreviewProvider {
    static var previews: some View {
        SmallRenderView(sc: SC(background: .blue, topText: "Top Text", bottomText: "Bottom Text", textColor: .white, image: NSImage(), mockupType: "Clay", mockupColor: .white, topSize: 20, bottomSize: 20, shadowColor: .black.opacity(0.6), shadowRadius: 15, shadowX: 10, shadowY: 10))
    }
}
