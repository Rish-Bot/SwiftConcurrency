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
 Notes:)
 >>  Task yield : it's a wait yield and execute next all the things
 >>  You can add the detach task to add the detachment to the praent task
 >>  Don't use the detach task if it's possible.
 >>  Task cancel also a great way to cancel suppose if the call is working when it's not necessary at all -
 >> .task{ } in SwiftUI automatically cancel task if the view disappears automatically. 
 */
