import Foundation

public class Features {
	public var type : String?
	public var maxResults : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let features_list = Features.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Features Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Features]
    {
        var models:[Features] = []
        for item in array
        {
            models.append(Features(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let features = Features(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Features Instance.
*/
	required public init?(dictionary: NSDictionary) {

		type = dictionary["type"] as? String
		maxResults = dictionary["maxResults"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.maxResults, forKey: "maxResults")

		return dictionary
	}

}
