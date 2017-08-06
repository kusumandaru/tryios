import Foundation
 
public class BoundingPoly {
	public var vertices : Array<Vertices>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let boundingPoly_list = BoundingPoly.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of BoundingPoly Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [BoundingPoly]
    {
        var models:[BoundingPoly] = []
        for item in array
        {
            models.append(BoundingPoly(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let boundingPoly = BoundingPoly(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: BoundingPoly Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["vertices"] != nil) { vertices = Vertices.modelsFromDictionaryArray(array: dictionary["vertices"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()


		return dictionary
	}

}
