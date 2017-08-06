import Foundation

public class FdBoundingPoly {
	public var vertices : Array<Vertices>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let fdBoundingPoly_list = FdBoundingPoly.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of FdBoundingPoly Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [FdBoundingPoly]
    {
        var models:[FdBoundingPoly] = []
        for item in array
        {
            models.append(FdBoundingPoly(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let fdBoundingPoly = FdBoundingPoly(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: FdBoundingPoly Instance.
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
