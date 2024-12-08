//
//  TaskInAsyncAwait.swift
//  SwiftConcurrency
//
//  Created by Hari on 07/12/24.
//

import SwiftUI

struct TaskInAsyncAwait: View {
    var body: some View {
        
        VStack{
            
        }.onAppear{
            Task{
                
            }
        }
        
        
    }
        
}

#Preview {
    TaskInAsyncAwait()
}


/*
 Notes : Task yield : it's a wait yield and execute next all the things 
 */
