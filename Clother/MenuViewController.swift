//
//  MenuViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-19.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

//adding class DataSource and Delegate for our TableView
class MenuViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var email: String? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let AccountViewController = segue.destination as? AccountViewController{
            AccountViewController.email = email
        }
    }
    
    @IBAction func goToAccountPage(_ sender: UIButton) {
      self.performSegue(withIdentifier: "goToAccount", sender: self)
    }
    
    //the Web API URL
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    //our table view
    @IBOutlet weak var MenuTableView: UITableView!
  
    
    
    
    //a list to store heroes
    var collectionlists = [Collections]()
     //the method returning size of the list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return collectionlists.count
    }
    //the method returning each cell of the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuViewControllerTableViewCell
        
        //getting the hero for the specified position
        let collection: Collections
        collection = collectionlists[indexPath.row]
        
        //displaying values
        cell.CollectionName.text = collection.name
       
        
        //displaying image
        Alamofire.request(collection.imageUrl!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.CollectionImage.image = image
            }
        }
        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fetching data from web api
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let collectionArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<collectionArray.count{
                    
                    //adding hero values to the hero list
                    self.collectionlists.append(Collections(
                        name: (collectionArray[i] as AnyObject).value(forKey: "name") as? String,
                        imageUrl: (collectionArray[i] as AnyObject).value(forKey: "imageurl") as? String
                    ))
                    
                }
                
                //displaying data in tableview
                self.MenuTableView.reloadData()
            }
            
        }
        self.MenuTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
