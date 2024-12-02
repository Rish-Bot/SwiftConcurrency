//
//  DoTryCatchThrows.swift
//  SwiftConcurrency
//
//  Created by Hari on 02/12/24.
//

import SwiftUI

struct DoTryCatchThrows: View {
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    var body: some View {
        Text(viewModel.text)
            .font(.headline)
            .frame(width: 350, height: 200)
            .foregroundStyle(Color.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoTryCatchThrows()
}
