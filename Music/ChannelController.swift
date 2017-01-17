//
//  ChannelController.swift
//  Music
//
//  Created by MacBook Pro  on 2016/11/26.
//  Copyright © 2016年 yucong shen. All rights reserved.
//
protocol ChannelChange{
    func didChannelChange(channelID:String)
}
import UIKit

class ChannelController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var channelTableView: UITableView!
    var delegate : ChannelChange?
    
    var channelArray=Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("test")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return channelArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "channel", for: indexPath)
        let dict=channelArray[indexPath.row] as! Dictionary<String,Any>
        cell.textLabel?.text=dict["name"] as! String?
        cell.imageView?.image=UIImage(named:"channel.png")
        
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let dict=self.channelArray[indexPath.row] as! Dictionary<String,Any>
        let channel:AnyObject=dict["channel_id"] as AnyObject
        let channelID = "\(channel)"
        print(channelID + "........")
        self.delegate?.didChannelChange(channelID: channelID)
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
