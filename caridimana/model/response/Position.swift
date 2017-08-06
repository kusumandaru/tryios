import Foundation
 
public class Position {
	public var x : Double?
	public var y : Double?
	public var z : Double?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let position_list = Position.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Position Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Position]
    {
        var models:[Position] = []
        for item in array
        {
            models.append(Position(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let position = Position(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Position Instance.
*/
	required public init?(dictionary: NSDictionary) {

		x = dictionary["x"] as? Double
		y = dictionary["y"] as? Double
		z = dictionary["z"] as? Double
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.x, forKey: "x")
		dictionary.setValue(self.y, forKey: "y")
		dictionary.setValue(self.z, forKey: "z")

		return dictionary
	}

}
