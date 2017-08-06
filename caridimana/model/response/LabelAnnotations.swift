import Foundation

public class LabelAnnotations {
	public var mid : String?
	public var score : Double?
	public var description : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let labelAnnotations_list = LabelAnnotations.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of LabelAnnotations Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [LabelAnnotations]
    {
        var models:[LabelAnnotations] = []
        for item in array
        {
            models.append(LabelAnnotations(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let labelAnnotations = LabelAnnotations(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: LabelAnnotations Instance.
*/
	required public init?(dictionary: NSDictionary) {

		mid = dictionary["mid"] as? String
		score = dictionary["score"] as? Double
		description = dictionary["description"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.mid, forKey: "mid")
		dictionary.setValue(self.score, forKey: "score")
		dictionary.setValue(self.description, forKey: "description")

		return dictionary
	}

}
