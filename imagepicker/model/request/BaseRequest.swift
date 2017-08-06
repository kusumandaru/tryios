import Foundation
 
public class BaseRequest {
	public var requests : Requests?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = BaseRequest.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of BaseRequest Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [BaseRequest]
    {
        var models:[BaseRequest] = []
        for item in array
        {
            models.append(BaseRequest(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["requests"] != nil) { requests = Requests(dictionary: dictionary["requests"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.requests?.dictionaryRepresentation(), forKey: "requests")

		return dictionary
	}

}
