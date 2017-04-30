//
//  FileHandle+ReadData.swift
//  TopicDemos
//
//  Created by Max Wang on 4/24/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit

extension FileHandle {
    //"SL_intro"
    static func readFile(name: String,
                        type: String,
                         bundle: Bundle? = nil,
                         dataHandler: (Data)->Void = {_ in }) {
        let bundle = bundle ?? Bundle.main
        if let path = bundle.path(forResource: name, ofType: type) {
            let size: Int = try! FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size] as! Int
            print(size)
            let fh = FileHandle(forReadingAtPath: path)!
            var read = 0
            while read < size {
                fh.seek(toFileOffset: UInt64(read))
                let data = fh.readData(ofLength: 100000)
                print(data)
                dataHandler(data)
                read += data.count
                print("Read ------------ \(read)")
            }
            fh.closeFile()
        }
    }
}
