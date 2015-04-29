//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

internal final class FromJSON {
	
	/// Basic type
	class func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Implicitly unwrapped optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Raw representable
	class func rawRepresentable<N: RawRepresentable>(inout field: N, object: N.RawValue?) {
		if let value = object {
			field = N(rawValue: value)!
		}
	}

	/// Optional raw representable
	class func rawRepresentable<N: RawRepresentable>(inout field: N?, object: N.RawValue?) {
		if let value = object {
			field = N(rawValue: value)
		}
	}

	/// Implicitly unwrapped optional basic type
	class func rawRepresentable<N: RawRepresentable>(inout field: N!, object: N.RawValue?) {
		if let value = object {
			field = N(rawValue: value)
		}
	}

	/// Array of Raw representable
	class func rawRepresentableArray<N: RawRepresentable>(inout field: [N], object: [N.RawValue]?) {
		if let values = object {
			field = values.map { (v: N.RawValue) in	N(rawValue: v)!	}
		}
	}

	/// Array of Raw representable
	class func rawRepresentableArray<N: RawRepresentable>(inout field: [N]?, object: [N.RawValue]?) {
		if let values = object {
			field = values.map { (v: N.RawValue) in	N(rawValue: v)!	}
		}
	}

	/// Array of Raw representable
	class func rawRepresentableArray<N: RawRepresentable>(inout field: [N]!, object: [N.RawValue]?) {
		if let values = object {
			field = values.map { (v: N.RawValue) in	N(rawValue: v)!	}
		}
	}

	/// Dictionary of Raw representable
	class func rawRepresentableDict<N: RawRepresentable>(inout field: [String: N], object: [String: N.RawValue]?) {
		if let values = object {
			field = map(values) { (k: String, v: N.RawValue) in	(k, N(rawValue: v)!) }
				.reduce([:]) { (var d, e) in
					let (k, v) = e
					d[k] = v
					return d
			}
		}
	}

	/// Dictionary of Raw representable
	class func rawRepresentableDict<N: RawRepresentable>(inout field: [String: N]?, object: [String: N.RawValue]?) {
		if let values = object {
			field = map(values) { (k: String, v: N.RawValue) in	(k, N(rawValue: v)!) }
				.reduce([:]) { (var d, e) in
					var (k, v) = e
					d?[k] = v
					return d
			}
		}
	}

	/// Dictionary of Raw representable
	class func rawRepresentableDict<N: RawRepresentable>(inout field: [String: N]!, object: [String: N.RawValue]?) {
		if let values = object {
			field = map(values) { (k: String, v: N.RawValue) in	(k, N(rawValue: v)!) }
				.reduce([:]) { (var d, e) in
					let (k, v) = e
					d[k] = v
					return d
			}
		}
	}

	/// Mappable object
	class func object<N: Mappable>(inout field: N, object: AnyObject?) {
		if let value: N = Mapper().map(object) {
			field = value
		}
	}

	/// Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N?, object: AnyObject?) {
		field = Mapper().map(object)
	}

	/// Implicitly unwrapped Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N!, object: AnyObject?) {
		field = Mapper().map(object)
	}

	/// mappable object array
	class func objectArray<N: Mappable>(inout field: Array<N>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapArray(object)

		if let objects = parsedObjects {
			field = objects
		}
	}

	/// optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>?, object: AnyObject?) {
		field = Mapper().mapArray(object)
	}

	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>!, object: AnyObject?) {
		field = Mapper().mapArray(object)
	}
	
	/// Dctionary containing Mappable objects
	class func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, object: AnyObject?) {
		let parsedObjects = Mapper<N>().mapDictionary(object)

		if let objects = parsedObjects {
			field = objects
		}
	}

	/// Optional dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, object: AnyObject?) {
		field = Mapper().mapDictionary(object)
	}

	/// Implicitly unwrapped Dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, object: AnyObject?) {
		field = Mapper().mapDictionary(object)
	}
}
