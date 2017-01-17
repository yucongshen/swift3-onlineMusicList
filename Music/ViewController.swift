//
//  ViewController.swift
//  Music
//
//  Created by MacBook Pro  on 2016/11/25.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol,ChannelChange{


    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var baiduTableView: UITableView!
    
    
    var httpController:HttpController=HttpController()
    var baiduArray=Array<Any>()
    var channelArray=Array<Any>()
    var imageCache=Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lakdsjfa")
        let baiduURL="http://127.0.0.1:8080/music/song.html"
        //let baiduURL="http://douban.fm/j/mine/playlist?channel=0"
        //let baiduURL="http://192.168.43.12:8080/music/song.html"
        let channelURL="http://www.douban.com/j/app/radio/channels"
        httpController.delegate=self
        httpController.onSearch(url: baiduURL)
        httpController.onSearch(url: channelURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.baiduArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "songListCell", for: indexPath) as!
        SongListCell
//        let dict=self.channelArray[indexPath.row] as! Dictionary<String,Any>
//        cell.imageView?.image = UIImage(named: "Ameir Al-Zoubi")
//        cell.textLabel?.text = dict["name"] as! String?
//        cell.detailTextLabel?.text = dict["name_en"] as?String
//        print("执行完一次了。。")
        let dict=self.baiduArray[indexPath.row] as! Dictionary<String,Any>
        //cell.imageView?.image = UIImage(named: "Ameir Al-Zoubi")
        cell.songNameLabel?.text=dict["title"] as! String?
        cell.singerNameLabel? .text = dict["artist"] as! String?
        let url=dict["picture"] as! String
        print("6666666")
        let urlPath=URL(string:url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlPath!) {
            (data, respond, error) in
            if let data = data {
                print("dadadadadaa")
                let img=UIImage(data:data)
                cell.songImageView?.image=img
            }else {
                    //self.imageCache[url]=img
                print("errorssss")
            }
        }
        dataTask.resume()
        return cell
    }
    func didReResults(resultData:Dictionary<String,Any>){
        if (resultData["song"] != nil) {
            self.baiduArray=resultData["song"] as! Array<Any>
            self.baiduTableView.reloadData()
//            let dict=self.baiduArray[0] as! Dictionary<String,Any>
//            let url=dict["url"] as! String
        }
        if (resultData["channels"] != nil){
            self.channelArray=resultData["channels"] as! Array<Any>
            //self.baiduTableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("showchannels.......")
        if segue.identifier == "showChannels",
            let channelController = segue.destination as? ChannelController {
            channelController.channelArray=self.channelArray
            channelController.delegate = self
            print("showchannels.......")
        }
    }
    func didChannelChange(channelID:String){
        //print(channelID)
        let baiduURL="http://127.0.0.1:8080/music/song\(channelID).html"
        print(baiduURL)
        httpController.onSearch(url: baiduURL)
    }
}

