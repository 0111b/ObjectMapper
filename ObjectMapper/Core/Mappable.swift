//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
	init?(_ map: Map)
	mutating func mapping(map: Map)
}

public extension Mappable {
	
	/// Initializes object from a JSON String
	public init?(JSONString: String?) {
		if let obj: Self = Mapper().map(JSONString) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Initializes object from a JSON Dictionary
	public init?(JSON: [String : AnyObject]?) {
		if let obj: Self = Mapper().map(JSON) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Returns the JSON Dictionary for the object
	public func toJSON() -> [String: AnyObject]? {
		return Mapper().toJSON(self)
	}
	
}

public extension Array where Element : Mappable {
	
	/// Initialize Array from a JSON String
	public init?(JSONString: String?) {
		if let obj: [Element] = Mapper().mapArray(JSONString) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Initialize Array from a JSON Array
	public init?(JSONArray: [[String : AnyObject]]?) {
		if let obj: [Element] = Mapper().mapArray(JSONArray) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Returns the JSON Array
	public func toJSON() -> [[String : AnyObject]]? {
		return Mapper().toJSONArray(self)
	}
	
}

public extension Set where Element : protocol<Mappable, Hashable> {
	
	/// Initializes a set from a JSON String
	public init?(JSONString: String) {
		if let obj: Set<Element> = Mapper().mapSet(JSONString) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Initializes a set from JSON
	public init?(JSONArray: [[String : AnyObject]]?) {
		if let obj: Set<Element> = Mapper().mapSet(JSONArray) {
			self = obj
		}
		else {
			return nil
		}
	}
	
	/// Returns the JSON Set
	public func toJSON() -> [[String : AnyObject]]? {
		return Mapper().toJSONSet(self)
	}
	
}