//
//  DoTryCatchThrows.swift
//  SwiftConcurrency
//
//  Created by Hari on 02/12/24.
//

import SwiftUI

//do-try-catch-throws-throw
class DoTryCatchThrowsDataManager {
    
    var isActive: Bool = true
    
    //beginer
    func getTitle() -> String{
        "Title 1"
    }
    
    //ok: you handle both the string and Error states in the tuple on yourself.
    func getTitle2() -> (title: String?, error: Error?){
        if isActive{
            return ("Title 2", nil)
        }else{
            return (nil, URLError(.badURL))
        }
        
        
    }
    //good approach using enum w/ success and failure cases in enum
    func getTitle3() -> Result<String, Error>{
        if isActive{
            return .success("Title 3")
        }else {
            return .failure(URLError(.badServerResponse))
        }
    }
    
    //use throws which is most common in real time scenarios.
    func getTitle4() throws -> String { // implicitly it throws an error so use do, try, catch blocks
        if isActive{
            return "Title 4"
        }else{
             throw URLError(.unknown)
        }
    }
    
}

class DoTryCatchThrowsViewModel: ObservableObject {
    
    @Published var text = "Welcome to Do-Try-Catch-Throws"
    
    let manager = DoTryCatchThrowsDataManager() //usually people use dependancy injection here in large project :)
    
    func fetchTitle() { // Control over all the values in the dispaly:)
        //getTitleMethod1: normal method
        /* let text = manager.getTitle()
        self.text = text*/
        
        //getTitleMethod2 : w/ Tuples
        /*let text = manager.getTitle2()
        if let title = text.title{
            self.text = title
        }else{
            self.text = "Error: \(text.error?.localizedDescription ?? "Unknown Error")"
        }*/
        
        //getTitleMethod3: Result enum
        /*
        switch manager.getTitle3() {
        case .success(let success):
            self.text = success
        case .failure(let failure):
            self.text = failure.localizedDescription
        }*/
        
        //getTitleMethod: Throws
        
       
        do {
            self.text = (try? manager.getTitle4()) ?? "nil"
        } catch {
            // no need of explicitly using error let declarations
            self.text = error.localizedDescription
        }
        
        
        manager.isActive.toggle()
    }
    
}

struct DoTryCatchThrows: View {
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.text)
                .padding()
                .font(.headline)
                .frame(width: 350, height: 200)
                .foregroundStyle(Color.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    viewModel.fetchTitle()
                }
        }
       
    }
}

#Preview {
    DoTryCatchThrows()
}

/*Notes
 Do :  we can keep multiple try blocks here not an issue.but if one this fails it will go to the catch block :) to handle this you can use try.
 
 Try : It try to execute the code,
 
 if you're using try? it returns a optional type. if it can't be failed by default. because it returns a value or nil everytime it never go to catch block. use it effectively.
    
 try! -> not recommended it crashes the app if the it throws an error it automatically try to unwrap it or suppose if the value is nil it trys to unwrap and endup in the fatal error, it also doesn't goes to catch block.
 
 Catch : catch the errors - no need of explicitly using error let declarations
 
 Throws : the func / method is eligible to throw an error
 Throw : it throw an error
 */
