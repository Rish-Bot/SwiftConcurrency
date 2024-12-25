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

