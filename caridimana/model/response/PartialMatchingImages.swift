import Foundation
 
public class PartialMatchingImages {
	public var url : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let partialMatchingImages_list = PartialMatchingImages.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of PartialMatchingImages Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [PartialMatchingImages]
    {
        var models:[PartialMatchingImages] = []
        for item in array
        {
            models.append(PartialMatchingImages(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let partialMatchingImages = PartialMatchingImages(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: PartialMatchingImages Instance.
*/
	required public init?(dictionary: NSDictionary) {

		url = dictionary["url"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.url, forKey: "url")

		return dictionary
	}

}
