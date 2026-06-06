//
//  VynkApp.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import SwiftUI

@main
struct VynkApp: App {
    @State private var appDIContainer = AppDIContainer()
    var body: some Scene {
        WindowGroup {
            RootView(appDIContainer: appDIContainer)
                .environment(\.appDIContainer, appDIContainer)
                .task {
//                    var arrInt = [1,2,3,4,1,2,7,8,9,3,77]
//
//                    var values: [Int] = []
//                    for value in arrInt {
//                        if values.contains(value){
//                            arrInt.removeAll { $0 == value}
//                        }else {
//                            values.append(value)
//                        }
//                    }
//
//                    dump(arrInt)
                    
                    let str = "is this temp arr!!"
                    
                    var characters = Array(str)
    
                    var start = 0
                    var end = characters.count - 1
                    
                    while start < end {
                        let temp = characters[start]
                        characters[start] = characters[end]
                        characters[end] = temp
                        start+=1
                        end-=1
                    }
                    
                    print(String(characters))
                }
        }
    }
    
}
