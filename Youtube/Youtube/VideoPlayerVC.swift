//
//  VideoPlayerVC.swift
//  Youtube
//
//  Created by Meheboob MacBook on 10/5/18.
//  Copyright © 2018 360Nautica. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerVC: UIViewController {
    var videoInfo : NSDictionary = NSDictionary()
    
    
    func getInfoWithDict(dict : NSDictionary)  {
        
        self.videoInfo = dict
        
        print(self.videoInfo)
        
    }
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    //ytplayer is used bcz while using code of others they have mentioned
    @IBOutlet weak var videoPlayer: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.videoPlayer.load(withVideoId: (self.videoInfo.value(forKey: "id") as! NSDictionary).value(forKey: "videoId") as! String)
        
        self.descriptionLabel.text = (self.videoInfo.value(forKey: "snippet") as! NSDictionary).value(forKey: "description") as? String
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
