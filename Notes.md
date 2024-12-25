#  Notes

## do-try-catch-throws

 Do :  we can keep multiple try blocks here not an issue.but if one this fails it will go to the catch block :) to handle this you can use try.
 
 Try : It try to execute the code,
 
 if you're using try? it returns a optional type. if it can't be failed by default. because it returns a value or nil everytime it never go to catch block. use it effectively.
    
 try! -> not recommended it crashes the app if the it throws an error it automatically try to unwrap it or suppose if the value is nil it trys to unwrap and endup in the fatal error, it also doesn't goes to catch block.
 
 Catch : catch the errors - no need of explicitly using error let declarations
 
 Throws : the func / method is eligible to throw an error
 Throw : it throw an error
 
 
 ## All possible ways to handle network call datas
 *Ref : DownloadImgAsync.swift*
 
 1. Completion handler [Unstructured concurrency]
 2. Completion handler w/ result enum [Unstructured concurrency]
 3. Async-Await [ Structured concurrency ]
 
 Best way to do is Async-Await [ Structured concurrency ]
 * It suspend the code there and wait for the call to complete 
 * Give controls to throw error directly and keep the code consistent 
 * Even the API execution takes more time we can control all in consice code with task and multiple parameters 
 * Async - let could be the best way to handle multiple calls and give structured concurrency control over these places. 


## Task 
    Tasks in Swift are part of the concurrency framework introduced at WWDC 2021. A task allows us to create a concurrent environment from a non-concurrent method, calling methods using async/await.
 >>  Task yield : it's a wait yield and execute next all the things
 >>  You can add the detach task to add the detachment to the praent task
 >>  Don't use the detach task if it's possible.
 >>  Task cancel also a great way to cancel suppose if the call is working when it's not necessary at all -
 >> .task{ } in SwiftUI automatically cancel task if the view disappears automatically.
 >> check for cancellation for Cancellation() to externally somethings goes wrong on the app at any point of time.
 
 >> task comes with bunch of API's most useful
    1. Task.sleep
    2. Task.yield
    3. Task.cancel
    4. Task.iscancelled
    5. Task.value
    6. Task.detached
 
 >> Async let creates a promises and wait till all the task get complete and give you the value if you want multiple task result at the time you can go with it
 
 >> You can add the async await to a computed property by Keeping async in the get property of computed one
    Example:
        var computedProperty : Organisation {
            get async {
                await networkcall
            }
        }
 
## Insights 

We can make the completion handler make available for both the completion handler and modern swift concurrency w/ the help of concurrency wrapper w/o breaking any part of codes 

