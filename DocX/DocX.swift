//
//  DocX.swift
//  DocXWriter
//
//  Created by Morten Bertz on 2019/03/10.
//  Copyright © 2019 telethon k.k. All rights reserved.
//

import Foundation

enum DocXSavingErrors:Error{
    case noBlankDocument
    case compressionFailed
}



protocol DocX{
    
    static var fileExtension:String { get }
    
    func docXDocument()throws ->String
    func saveTo(url:URL)throws
}

extension DocX{
    static var fileExtension:String{
        return "docx"
    }
}


