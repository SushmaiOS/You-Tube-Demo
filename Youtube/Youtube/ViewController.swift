//
//  ViewController.swift
//  Youtube
//
//  Created by Mehboob on 10/4/18.
//  Copyright © 2018 360Nautica. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  self.allVidioesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AllVidioesCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllVidioesCell
        
        cell.videoTitle.text =  ((self.allVidioesArray.object(at: indexPath.row)as! NSDictionary).value(forKey: "snippet") as! NSDictionary).value(forKey: "title") as? String
        cell.videoDescription.text =  ((self.allVidioesArray.object(at: indexPath.row)as! NSDictionary).value(forKey: "snippet") as! NSDictionary).value(forKey: "description") as? String
        
        
        let urlString  = ((((self.allVidioesArray.object(at: indexPath.row)as! NSDictionary).value(forKey: "snippet") as! NSDictionary).value(forKey: "thumbnails") as! NSDictionary).value(forKey: "default") as! NSDictionary).value(forKey: "url") as! String
        
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.videoImage.image = UIImage(data: data!)
        
        return cell
        
    }
    

    var allVidioesArray : NSArray = NSArray()
    var selectedArrayIndex  : Int = 0
    
    @IBOutlet weak var videosTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=id,snippet&maxResults=20&channelId=UCCq1xDJMBRF61kiOgU90_kw&key=AIzaSyBRLPDbLkFnmUv13B-Hq9rmf0y7q8HOaVs")
        
        self.getRequestWithUrl(url: url!)
        
    }

   
    
    func getRequestWithUrl(url : URL) {
        
       
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    let dict : NSDictionary = json as NSDictionary
                    
                    self.allVidioesArray = dict.value(forKey: "items") as! NSArray
                    print(self.allVidioesArray)
                    OperationQueue.main.addOperation({
                        self.videosTable.reloadData()
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedArrayIndex = indexPath.row
        self.performSegue(withIdentifier: "VideoPlayerVC", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! VideoPlayerVC
        
        vc.getInfoWithDict(dict: self.allVidioesArray.object(at: selectedArrayIndex) as! NSDictionary)
        
    }
}
