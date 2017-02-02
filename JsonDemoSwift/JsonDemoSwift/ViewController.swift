//
//  ViewController.swift
//  JsonDemoSwift
//
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    
   let urlString = "UR GET METHOD URL"
    var dictData : NSArray = []
    var aryFriends : NSArray = []
    @IBOutlet var tblView: UITableView!
    
    var FriendsArray = [Friends]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.delegate = nil
        self.tblView.dataSource = nil
        self.webserviceCall()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewTableViewCell
        
        let dict = dictData[indexPath.row] as! NSDictionary
        self.aryFriends = (dict["friends"] as AnyObject! as? NSArray)!
        print(self.aryFriends)
        if (self.aryFriends.count > 0)
        {
            let strid1 = NSString(format:"%d",(aryFriends[0] as! NSDictionary)["id"] as! NSInteger)
            cell.lblid1.text = strid1 as String
            cell.lblFName1.text = (aryFriends[0] as! NSDictionary)["name"] as? String
            let strid2 = NSString(format:"%d",(aryFriends[1] as! NSDictionary)["id"] as! NSInteger)
            cell.lblid2.text = strid2 as String
            cell.lblFName2.text = (aryFriends[1] as! NSDictionary)["name"] as? String
            let strid3 = NSString(format:"%d",(aryFriends[2] as! NSDictionary)["id"] as! NSInteger)
            cell.lblid3.text = strid3 as String
            cell.lblFName3.text = (aryFriends[2] as! NSDictionary)["name"] as? String
            cell.lblName.text = dict["name"] as? String
            let str = NSString(format:"%d ", dict["age"] as! NSInteger)
            cell.lblAge.text = str as String
            let url = URL(string: dict["picture"] as! String)
            DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data!)}
            }
        }
        return cell
    }
    func webserviceCall(){
            get(apiUrl: urlString ) { (success, responseData) in
                DispatchQueue.main.async {
                    if success{
                        print(responseData)
                        self.dictData = (responseData as AnyObject! as? NSArray)!
                        print(self.dictData)
                        self.tblView.delegate = self
                        self.tblView.dataSource = self
                        self.tblView.reloadData()
                    }
                    else{
                       
                    }
                }
            }
    }
    func get(apiUrl : String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        requestGetMethod(apiUrl: apiUrl, method: "GET", completion: completion)
    }
    func requestGetMethod(apiUrl : String, method: NSString, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        var request = URLRequest(url: URL(string: apiUrl)!)
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"//method as String
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    completion(true, convertedJsonIntoDict)
                }
                else{
                    completion(false, nil)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
}

