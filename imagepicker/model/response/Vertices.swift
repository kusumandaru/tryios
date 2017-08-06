import Foundation

public class Vertices {
	public var x : Int?
	public var y : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let vertices_list = Vertices.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Vertices Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Vertices]
    {
        var models:[Vertices] = []
        for item in array
        {
            models.append(Vertices(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let vertices = Vertices(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Vertices Instance.
*/
	required public init?(dictionary: NSDictionary) {

		x = dictionary["x"] as? Int
		y = dictionary["y"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.x, forKey: "x")
		dictionary.setValue(self.y, forKey: "y")

		return dictionary
	}

}
