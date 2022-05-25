//
//  ErrorWrapper.swift
//  SwiftTutorials
//
//  Created by Natalya Lysakova on 21.05.2022.
//

import Foundation

struct ErrorWrapper : Identifiable {
    internal init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
    
    var id: UUID
    let error : Error
    let guidance : String

}
