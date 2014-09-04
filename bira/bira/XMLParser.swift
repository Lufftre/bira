//
//  XMLParser.swift
//  bira
//
//  Created by Erik Linder-Norén on 2014-09-01.
//  Copyright (c) 2014 Ludvig Noring. All rights reserved.
//

import UIKit



protocol XMLParserDelegate{
    func XMLParserError(parser: XMLParser, error: String)
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var filePath: String
    var root: String = ""
    
    override init(){
        self.filePath = ""
    }
    
    
    var delegate: XMLParserDelegate?
    
    var handler: (() -> Void)?
    
    var inItem = false
    var current = String()
    
    var objects = [Dictionary<String, String>]()
    var object = Dictionary<String, String>()
    
    func setFilePath(path: String, root: String){
        self.filePath = path
        self.root = root
    }
    
    func parse(handler: () -> Void){
        self.handler = handler
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            
            let xmlCode = NSData(contentsOfFile: self.filePath)
            if(self.filePath.hasPrefix("http")){
                let parser = NSXMLParser(contentsOfURL: NSURL(string: self.filePath))
                parser.delegate = self
                if !parser.parse() {
                    self.delegate?.XMLParserError(self, error: "Parse Error")
                }
            }
            else{
                let parser = NSXMLParser(data: xmlCode)
                parser.delegate = self
                if !parser.parse() {
                    self.delegate?.XMLParserError(self, error: "Parse Error")
                }
            }
            
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError!) {
        delegate?.XMLParserError(self, error: parseError.localizedDescription)
    }

    
    func parser(parser: NSXMLParser, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if elementName == root{
            object.removeAll(keepCapacity: false)
            inItem = true
        }
        current = elementName
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String!) {
        if !inItem{
            return
        }
        if let temp = object[current]{
            var tempString = temp
            //tempString += temp
            object[current] = tempString
        }
        else{
            object[current] = string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == root{
            inItem = false
            objects.append(object)
        }

    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()){
            if (self.handler != nil){
                self.handler!()
                
            }
        }
    }
}
