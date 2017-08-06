import Foundation
 

public class Landmarks {
	public var type : String?
	public var position : Position?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let landmarks_list = Landmarks.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Landmarks Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Landmarks]
    {
        var models:[Landmarks] = []
        for item in array
        {
            models.append(Landmarks(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let landmarks = Landmarks(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Landmarks Instance.
*/
	required public init?(dictionary: NSDictionary) {

		type = dictionary["type"] as? String
		if (dictionary["position"] != nil) { position = Position(dictionary: dictionary["position"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.position?.dictionaryRepresentation(), forKey: "position")

		return dictionary
	}

}
