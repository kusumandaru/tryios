import Foundation
 
public class WebEntities {
	public var score : Double?
	public var description : String?
	public var entityId : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let webEntities_list = WebEntities.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of WebEntities Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [WebEntities]
    {
        var models:[WebEntities] = []
        for item in array
        {
            models.append(WebEntities(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let webEntities = WebEntities(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: WebEntities Instance.
*/
	required public init?(dictionary: NSDictionary) {

		score = dictionary["score"] as? Double
		description = dictionary["description"] as? String
		entityId = dictionary["entityId"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.score, forKey: "score")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.entityId, forKey: "entityId")

		return dictionary
	}

}
