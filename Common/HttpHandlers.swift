//
//  Handlers.swift
//  Swifter
//  Copyright (c) 2014 Damian Kołakowski. All rights reserved.
//

import Foundation

class HttpHandlers {

    class func directory(dir: String) -> ( HttpRequest -> HttpResponse ) {
        return { request in
            if let localPath = request.capturedUrlGroups.first {
                let filesPath = dir.stringByExpandingTildeInPath.stringByAppendingPathComponent(localPath)
                if let fileBody = NSData(contentsOfFile: filesPath) {
                    return HttpResponse.RAW(200, "OK", nil, fileBody)
                }
            }
            return HttpResponse.NotFound
        }
    }

    class func directoryBrowser(dir: String) -> ( HttpRequest -> HttpResponse ) {
        return { request in
            if let pathFromUrl = request.capturedUrlGroups.first {
                let filePath = dir.stringByExpandingTildeInPath.stringByAppendingPathComponent(pathFromUrl)
                let fileManager = NSFileManager.defaultManager()
                var isDir: ObjCBool = false;
                if ( fileManager.fileExistsAtPath(filePath, isDirectory: &isDir) ) {
                    if ( isDir ) {
                        do {
                            let files = try fileManager.contentsOfDirectoryAtPath(filePath)
                            var response = "<h3>\(filePath)</h3></br><table>"
                            response += "".join(files.map({ "<tr><td><a href=\"\(request.url)/\($0)\">\($0)</a></td></tr>"}))
                            response += "</table>"
                            return HttpResponse.OK(.HTML(response))
                        } catch _ {
                        }
                    } else {
                        if let fileBody = NSData(contentsOfFile: filePath) {
                            return HttpResponse.RAW(200, "OK", nil, fileBody)
                        }
                    }
                }
            }
            return HttpResponse.NotFound
        }
    }
}