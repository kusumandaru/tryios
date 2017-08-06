import Foundation
 

public class VisuallySimilarImages {
	public var url : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let visuallySimilarImages_list = VisuallySimilarImages.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of VisuallySimilarImages Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [VisuallySimilarImages]
    {
        var models:[VisuallySimilarImages] = []
        for item in array
        {
            models.append(VisuallySimilarImages(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let visuallySimilarImages = VisuallySimilarImages(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: VisuallySimilarImages Instance.
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
