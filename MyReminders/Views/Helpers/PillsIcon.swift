//
//  PillsIcon.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 05/02/2022.
//

import SwiftUI

struct PillsIcon: View {
    @State var systemName: String
    @State var foregroundColor: Color
    @State var backgroundColor: Color
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(foregroundColor)
            .padding(5.0)
            .background(backgroundColor)
            .cornerRadius(6)
    }
}

struct PillsIcon_Previews: PreviewProvider {
    static var previews: some View {
        PillsIcon(systemName: "star.fill", foregroundColor: Color.white, backgroundColor: Color.red)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
