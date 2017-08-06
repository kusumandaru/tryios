import Foundation
 
public class FaceAnnotations {
	public var headwearLikelihood : String?
	public var surpriseLikelihood : String?
	public var rollAngle : Double?
	public var angerLikelihood : String?
	public var landmarks : Array<Landmarks>?
	public var landmarkingConfidence : Double?
	public var boundingPoly : BoundingPoly?
	public var fdBoundingPoly : FdBoundingPoly?
	public var detectionConfidence : Double?
	public var joyLikelihood : String?
	public var panAngle : Double?
	public var sorrowLikelihood : String?
	public var tiltAngle : Double?
	public var underExposedLikelihood : String?
	public var blurredLikelihood : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let faceAnnotations_list = FaceAnnotations.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of FaceAnnotations Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [FaceAnnotations]
    {
        var models:[FaceAnnotations] = []
        for item in array
        {
            models.append(FaceAnnotations(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let faceAnnotations = FaceAnnotations(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: FaceAnnotations Instance.
*/
	required public init?(dictionary: NSDictionary) {

		headwearLikelihood = dictionary["headwearLikelihood"] as? String
		surpriseLikelihood = dictionary["surpriseLikelihood"] as? String
		rollAngle = dictionary["rollAngle"] as? Double
		angerLikelihood = dictionary["angerLikelihood"] as? String
		if (dictionary["landmarks"] != nil) { landmarks = Landmarks.modelsFromDictionaryArray(array: dictionary["landmarks"] as! NSArray) }
		landmarkingConfidence = dictionary["landmarkingConfidence"] as? Double
		if (dictionary["boundingPoly"] != nil) { boundingPoly = BoundingPoly(dictionary: dictionary["boundingPoly"] as! NSDictionary) }
		if (dictionary["fdBoundingPoly"] != nil) { fdBoundingPoly = FdBoundingPoly(dictionary: dictionary["fdBoundingPoly"] as! NSDictionary) }
		detectionConfidence = dictionary["detectionConfidence"] as? Double
		joyLikelihood = dictionary["joyLikelihood"] as? String
		panAngle = dictionary["panAngle"] as? Double
		sorrowLikelihood = dictionary["sorrowLikelihood"] as? String
		tiltAngle = dictionary["tiltAngle"] as? Double
		underExposedLikelihood = dictionary["underExposedLikelihood"] as? String
		blurredLikelihood = dictionary["blurredLikelihood"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.headwearLikelihood, forKey: "headwearLikelihood")
		dictionary.setValue(self.surpriseLikelihood, forKey: "surpriseLikelihood")
		dictionary.setValue(self.rollAngle, forKey: "rollAngle")
		dictionary.setValue(self.angerLikelihood, forKey: "angerLikelihood")
		dictionary.setValue(self.landmarkingConfidence, forKey: "landmarkingConfidence")
		dictionary.setValue(self.boundingPoly?.dictionaryRepresentation(), forKey: "boundingPoly")
		dictionary.setValue(self.fdBoundingPoly?.dictionaryRepresentation(), forKey: "fdBoundingPoly")
		dictionary.setValue(self.detectionConfidence, forKey: "detectionConfidence")
		dictionary.setValue(self.joyLikelihood, forKey: "joyLikelihood")
		dictionary.setValue(self.panAngle, forKey: "panAngle")
		dictionary.setValue(self.sorrowLikelihood, forKey: "sorrowLikelihood")
		dictionary.setValue(self.tiltAngle, forKey: "tiltAngle")
		dictionary.setValue(self.underExposedLikelihood, forKey: "underExposedLikelihood")
		dictionary.setValue(self.blurredLikelihood, forKey: "blurredLikelihood")

		return dictionary
	}

}
