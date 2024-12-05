//
//  async-await-deepdrive.swift
//  SwiftConcurrency
//
//  Created by Hari on 05/12/24.
//

import SwiftUI
class asyncAwaitDeepdriveVM : ObservableObject {
    @Published var dataArray : [String] = []
}
struct async_await_deepdrive: View {
    @StateObject private var viewModel =  asyncAwaitDeepdriveVM()
    var body: some View {
        List{
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        
    }
}

#Preview {
    async_await_deepdrive()
}
