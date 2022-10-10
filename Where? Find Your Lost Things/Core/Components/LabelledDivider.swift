//
//  LabelledDivider.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import SwiftUI

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, verticalPadding: CGFloat = 10, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.color = color
    }

    var body: some View {
        HStack(spacing: verticalPadding){
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct LabelledDivider_Previews: PreviewProvider {
    static var previews: some View {
        LabelledDivider(label: "OR", verticalPadding: 0)
    }
}
