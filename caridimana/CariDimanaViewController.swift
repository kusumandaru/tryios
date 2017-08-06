// Copyright 2016 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import SwiftyJSON_3_1_1


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let cariDimana = UIImagePickerController()
    let session = URLSession.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var labelResults: UITextView!
    @IBOutlet weak var faceResults: UITextView!
    @IBOutlet weak var logoResults: UITextView!
    @IBOutlet weak var webEntityResults: UITextView!
    @IBOutlet weak var webPageResults: UITextView!
    
    var googleAPIKey = "AIzaSyAqR1bxZJ4WuI62cbbJManpdyg74Fi5dCQ"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        cariDimana.allowsEditing = false
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.cariDimana.sourceType = .camera
            self.present(self.cariDimana, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            self.cariDimana.sourceType = .photoLibrary
            self.present(self.cariDimana, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        //cariDimana.sourceType = .camera
        
        present(cariDimana, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cariDimana.delegate = self
        labelResults.isHidden = true
        faceResults.isHidden = true
        logoResults.isHidden = true
        webEntityResults.isHidden = true
        webPageResults.isHidden = true
        spinner.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/// Image processing

extension ViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            
            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.spinner.stopAnimating()
            self.imageView.isHidden = true
            self.labelResults.isHidden = false
            self.faceResults.isHidden = false
            self.logoResults.isHidden = false
            self.webEntityResults.isHidden = false
            self.webPageResults.isHidden = false
            self.faceResults.text = ""
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
                
                
                
                // Get face annotations
                let faceAnnotations: JSON = responses["faceAnnotations"]
                if faceAnnotations != JSON.null {
                    let emotions: Array<String> = ["joy", "sorrow", "surprise", "anger"]
                    
                    let numPeopleDetected:Int = faceAnnotations.count
                    
                    self.faceResults.text = "People detected: \(numPeopleDetected)\n\nEmotions detected:\n"
                    
                    var emotionTotals: [String: Double] = ["sorrow": 0, "joy": 0, "surprise": 0, "anger": 0]
                    var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY":0.25, "VERY_UNLIKELY": 0.0]
                    
                    for index in 0..<numPeopleDetected {
                        let personData:JSON = faceAnnotations[index]
                        
                        // Sum all the detected emotions
                        for emotion in emotions {
                            let lookup = emotion + "Likelihood"
                            let result:String = personData[lookup].stringValue
                            emotionTotals[emotion]! += emotionLikelihoods[result]!
                        }
                    }
                    // Get emotion likelihood as a % and display in UI
                    for (emotion, total) in emotionTotals {
                        let likelihood:Double = total / Double(numPeopleDetected)
                        let percent: Int = Int(round(likelihood * 100))
                        self.faceResults.text! += "\(emotion): \(percent)%\n"
                    }
                } else {
                    self.faceResults.text = "No faces found"
                }
                
                // Get label annotations
                let labelAnnotations: JSON = responses["labelAnnotations"]
                let numLabels: Int = labelAnnotations.count
                var labels: Array<String> = []
                if numLabels > 0 {
                    var labelResultsText:String = "Labels found: "
                    for index in 0..<numLabels {
                        let label = labelAnnotations[index]["description"].stringValue
                        labels.append(label)
                    }
                    for label in labels {
                        // if it's not the last item add a comma
                        if labels[labels.count - 1] != label {
                            labelResultsText += "\(label), "
                        } else {
                            labelResultsText += "\(label)"
                        }
                    }
                    self.labelResults.text = labelResultsText
                } else {
                    self.labelResults.text = "No labels found"
                }
                
                // Get logo annotations
                let logoAnnotations: JSON = responses["logoAnnotations"]
                let numLogos: Int = logoAnnotations.count
                var logos: Array<String> = []
                if numLogos > 0 {
                    var logoResultsText:String = "Logos found: "
                    for index in 0..<numLogos {
                        let logo = logoAnnotations[index]["description"].stringValue
                        logos.append(logo)
                    }
                    for logo in logos {
                        // if it's not the last item add a comma
                        if logos[logos.count - 1] != logo {
                            logoResultsText += "\(logo), "
                        } else {
                            logoResultsText += "\(logo)"
                        }
                    }
                    self.logoResults.text = logoResultsText
                } else {
                    self.logoResults.text = "No logos found"
                }
                
                
                // Get webDetection annotations
                let webDetection: JSON = responses["webDetection"]
                
                let webEntityAnnotations: JSON = webDetection["webEntities"]
                let numWebEntities: Int = webEntityAnnotations.count
                var webEntities: Array<String> = []
                if numWebEntities > 0 {
                    var webEntityResultsText:String = "WebEntities found: "
                    for index in 0..<numWebEntities {
                        let webEntity = webEntityAnnotations[index]["description"].stringValue
                        webEntities.append(webEntity)
                    }
                    
                    for webEntity in webEntities {
                        // if it's not the last item add a comma
                        if webEntities[webEntities.count - 1] != webEntity {
                            webEntityResultsText += "\(webEntity), "
                        } else {
                            webEntityResultsText += "\(webEntity)"
                        }
                    }
                    self.webEntityResults.text = webEntityResultsText
                } else {
                    self.webEntityResults.text = "No web entity found"
                }
                
                let webPageAnnotations: JSON = webDetection["pagesWithMatchingImages"]
                let numWebPages: Int = webPageAnnotations.count
                var webPages: Array<String> = []
                if numWebPages > 0 {
                    var webPageResultsText:String = "WebPage found: "
                    for index in 0..<numWebPages {
                        let webPage = webPageAnnotations[index]["url"].stringValue
                        webPages.append(webPage)
                    }
                    
                    for webPage in webPages {
                        // if it's not the last item add a comma
                        if webPages[webPages.count - 1] != webPage {
                            webPageResultsText += "\(webPage), "
                        } else {
                            webPageResultsText += "\(webPage)"
                        }
                    }
                    self.webPageResults.text = webPageResultsText
                } else {
                    self.webPageResults.text = "No web page found"
                }
                
                let baseResponse = BaseResponse(dictionary: responses.dictionaryObject as! NSDictionary)
                
                let wD = baseResponse?.webDetection
                let pmi = wD?.partialMatchingImages
                var webPageResultsText:String = "WebPage nemu: "
                for pm in pmi!{
                    webPageResultsText += "pm:"+"\(pm)"
                }
                self.webPageResults.text = webPageResultsText
            }
        })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageView.isHidden = false // You could optionally display the image here by setting imageView.image = pickedImage
            spinner.startAnimating()
            faceResults.isHidden = true
            labelResults.isHidden = true
            logoResults.isHidden = true
            webEntityResults.isHidden = true
            webPageResults.isHidden = true
            
            // Base64 encode the image and create the request
            let binaryImageData = base64EncodeImage(pickedImage)
            createRequest(with: binaryImageData)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}


/// Networking

extension ViewController {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata?.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createRequest(with imageBase64: String) {
        // Create our request URL
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let features = [
            NSDictionary(dictionaryLiteral:("type","LABEL_DETECTION"), ("maxResults",10)),
            NSDictionary(dictionaryLiteral:("type","FACE_DETECTION"), ("maxResults",10)),
            NSDictionary(dictionaryLiteral:("type","LANDMARK_DETECTION"), ("maxResults",10)),
            NSDictionary(dictionaryLiteral:("type","LOGO_DETECTION"), ("maxResults",10)),
            NSDictionary(dictionaryLiteral:("type","WEB_DETECTION"), ("maxResults",10))]
        
        let image = NSDictionary(dictionaryLiteral:("content",imageBase64))
        
        let requestD = NSDictionary(
            dictionaryLiteral: ("image", image), ("features",features)
        )
        
        let requests:NSDictionary = ["requests" : requestD]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requests, options: .prettyPrinted)
        } catch let error {
            print("error occured \(error)")
        }
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        // run the request
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
}


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
