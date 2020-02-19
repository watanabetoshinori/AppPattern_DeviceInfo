//
//  Cell.swift
//  DeviceInfo
//
//  Created by Watanabe Toshinori on 2020/02/19.
//  Copyright © 2020 Watanabe Toshinori. All rights reserved.
//

import SwiftUI

struct Cell: View {

    var title: String
    
    @Binding var detail: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
                .layoutPriority(1)

            Spacer()

            Text(detail)
                .foregroundColor(.secondary)
        }
    }

}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(title: "Title", detail: .constant("Detail"))
        .frame(width: 320, height: 44)
        .previewLayout(.sizeThatFits)
    }
}
