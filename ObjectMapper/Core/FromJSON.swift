//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

import Foundation

class FromJSON<CollectionType> {
    
    func baseType<FieldType>(inout field: FieldType, object: AnyObject?) {
        if let value: AnyObject = object {
            switch FieldType.self {
            case is String.Type:
                field = (value as String) as FieldType
            case is Bool.Type:
                field = (value as Bool) as FieldType
            case is Int.Type:
                field = (value as Int) as FieldType
            case is Double.Type:
                field = (value as Double) as FieldType
            case is Float.Type:
                field = (value as Float) as FieldType
            case is Array<CollectionType>.Type:
                field = value as FieldType
            case is Dictionary<String, CollectionType>.Type:
                field = value as FieldType
            default:
                return
            }
        }
    }
    
    func baseType<FieldType>(inout field: FieldType, object: FieldType?) {
        if let value: FieldType = object {
            field = value
        }
    }
    
    func optionalBaseType<FieldType>(inout field: FieldType?, object: AnyObject?) {
        if let value: AnyObject = object {
            switch FieldType.self {
            case is String.Type:
                field = value as? FieldType
            case is Bool.Type:
                field = value as? FieldType
            case is Int.Type:
                field = value as? FieldType
            case is Double.Type:
                field = value as? FieldType
            case is Float.Type:
                field = value as? FieldType
            case is Array<CollectionType>.Type:
                field = value as? FieldType
            case is Dictionary<String, CollectionType>.Type:
                field = value as? FieldType
            case is NSDate.Type:
                field = value as? FieldType
            default:
                field = nil
                return
            }
        }
    }
    
    func optionalBaseType<FieldType>(inout field: FieldType?, object: FieldType?) {
        if let value: FieldType = object {
            field = value
        }
    }
    
    func object<N: MapperProtocol>(inout field: N, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value, to: N.self)
        }
    }
    
    func object<N: MapperProtocol>(inout field: N?, object: AnyObject?) {
        if let value = object as? [String : AnyObject] {
            field = Mapper().map(value, to: N.self)
        }
    }
    
    func objectArray<N: MapperProtocol>(inout field: Array<N>, object: AnyObject?) {
        var parsedObjects: Array<N> = parseObjectArray(object)
        
        if parsedObjects.count > 0 {
            field = parsedObjects
        }
    }
    
    func optionalObjectArray<N: MapperProtocol>(inout field: Array<N>?, object: AnyObject?) {
        var parsedObjects: Array<N> = parseObjectArray(object)

        if parsedObjects.count > 0 {
            field = parsedObjects
        } else {
            field = nil
        }
    }
    
    // parses a JSON array into an array of objects of type <N: MapperProtocol>
    private func parseObjectArray<N: MapperProtocol>(object: AnyObject?) -> Array<N>{
        let mapper = Mapper()
        
        var parsedObjects = Array<N>()
        
        if let array = object as [AnyObject]? {
            for object in array {
                let objectJSON = object as [String : AnyObject]
                var parsedObj = mapper.map(objectJSON, to: N.self)
                parsedObjects.append(parsedObj)
            }
        }
        
        return parsedObjects
    }
}
