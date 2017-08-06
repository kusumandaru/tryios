import Foundation
 
public class BaseResponse {
	public var webDetection : WebDetection?
	public var labelAnnotations : Array<LabelAnnotations>?
	public var faceAnnotations : Array<FaceAnnotations>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = BaseResponse.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of BaseResponse Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [BaseResponse]
    {
        var models:[BaseResponse] = []
        for item in array
        {
            models.append(BaseResponse(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let baseResponse = BaseResponse(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: BaseResponse Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["webDetection"] != nil) { webDetection = WebDetection(dictionary: dictionary["webDetection"] as! NSDictionary) }
		if (dictionary["labelAnnotations"] != nil) { labelAnnotations = LabelAnnotations.modelsFromDictionaryArray(array: dictionary["labelAnnotations"] as! NSArray) }
		if (dictionary["faceAnnotations"] != nil) { faceAnnotations = FaceAnnotations.modelsFromDictionaryArray(array: dictionary["faceAnnotations"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.webDetection?.dictionaryRepresentation(), forKey: "webDetection")

		return dictionary
	}

}
