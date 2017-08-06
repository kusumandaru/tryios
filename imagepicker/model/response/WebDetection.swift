import Foundation
 
public class WebDetection {
	public var partialMatchingImages : Array<PartialMatchingImages>?
	public var webEntities : Array<WebEntities>?
	public var visuallySimilarImages : Array<VisuallySimilarImages>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let webDetection_list = WebDetection.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of WebDetection Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [WebDetection]
    {
        var models:[WebDetection] = []
        for item in array
        {
            models.append(WebDetection(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let webDetection = WebDetection(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: WebDetection Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["partialMatchingImages"] != nil) { partialMatchingImages = PartialMatchingImages.modelsFromDictionaryArray(array: dictionary["partialMatchingImages"] as! NSArray) }
		if (dictionary["webEntities"] != nil) { webEntities = WebEntities.modelsFromDictionaryArray(array: dictionary["webEntities"] as! NSArray) }
		if (dictionary["visuallySimilarImages"] != nil) { visuallySimilarImages = VisuallySimilarImages.modelsFromDictionaryArray(array: dictionary["visuallySimilarImages"] as! NSArray) }
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
