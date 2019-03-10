//
//  DocXSaving.swift
//  DocXWriter
//
//  Created by Morten Bertz on 2019/03/10.
//  Copyright © 2019 telethon k.k. All rights reserved.
//

import Foundation
import ZipArchive

extension DocX where Self:NSAttributedString{
    
    func saveTo(url:URL)throws{

        let tempURL=FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: false)
        let attributes=[NSAttributedString.DocumentAttributeKey.documentType:NSAttributedString.DocumentType.officeOpenXML]
        let wrapper=try self.fileWrapper(from: NSRange(location: 0, length: self.length), documentAttributes: attributes)
        try wrapper.write(to: tempURL, options: .atomic, originalContentsURL: nil)
        let docPath=tempURL.appendingPathComponent("word").appendingPathComponent("document").appendingPathExtension("xml")
        let xmlData = try self.docXDocument()
        try xmlData.write(to: docPath, atomically: true, encoding: .utf8)
        let zipURL=FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("zip")
        let success=SSZipArchive.createZipFile(atPath: zipURL.path, withContentsOfDirectory: tempURL.path, keepParentDirectory: false)
        guard success == true else{throw DocXSavingErrors.compressionFailed}
        try FileManager.default.removeItem(at: tempURL)
        try FileManager.default.copyItem(at: zipURL, to: url)
        try FileManager.default.removeItem(at: zipURL)
        
    }
}
