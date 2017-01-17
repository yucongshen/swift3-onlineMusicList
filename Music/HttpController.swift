//
//  HttpController.swift
//  Music
//
//  Created by MacBook Pro  on 2016/11/26.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import UIKit
class HttpController: NSObject {
    var delegate:HttpProtocol?
    func onSearch(url:String){
//        let urlPath=NSURL(string: url)
//        let request=NSURLRequest(url: urlPath as! URL)
//        NSURLConnection.sendAsynchronousRequest(request as URLRequest,queue:OperationQueue.main, completionHandler: {
//            (response,data,error)->Void in
//            print(data)
//        })
//    }
        let urlPath = URL(string: url)
    
        let session = URLSession.shared
        //发送get请求
        let dataTask = session.dataTask(with: urlPath!) { (data, respond, error) in
            if let data = data {
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    //print(result)
                    self.delegate?.didReResults(resultData: result as! Dictionary)
                }
            }else {
                print("errorssss")
            }
        }
        dataTask.resume()
    }
}
