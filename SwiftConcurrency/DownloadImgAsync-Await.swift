//
//  DownloadImgAsync-Await.swift
//  SwiftConcurrency
//
//  Created by Hari on 02/12/24.
//

import SwiftUI
//DataManager: which controls all the logics from the ViewModel - Global place

//ViewModel Class it has all the datas


struct DownloadImgAsync_Await: View {
    var body: some View {
        ZStack{
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.green,.blue,.red)
                .frame(width: 200, height: 200)
            
        }
    }
}

#Preview {
    DownloadImgAsync_Await()
}
