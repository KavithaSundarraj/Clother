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

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Table view outlet
    @IBOutlet weak var tableView: UITableView!
    //our table view
    @IBOutlet weak var MenuTableView: UITableView!
    
    //Perform segue to go about page
    @IBAction func showAboutPage(_ sender: Any) {
        performSegue(withIdentifier: "showAboutPageSegue", sender: self)
    }
    
    //the Web API URL
    let URL_GET_DATA = "file:///Users/dsv/Desktop/Clother/data.json"
  //let URL_GET_DATA = "https://clother.azurewebsites.net/api/collections"
    //a list to store collections
    var collectionlists = [Collections]()
   
    //To perform segue for loading ItemViewController
    let itemSegueIdentifier = "ShowItemSegue"
    let textCellIdentifier = "TextCell"
    
    // MARK: - Navigation  -  to pass collections to CollectionsViewController
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == itemSegueIdentifier,
            let destination = segue.destination as? CollectionsViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.collectionsId = collectionlists [blogIndex].id!
            destination.itemsurl = collectionlists [blogIndex].itemurl!
            print(collectionlists[blogIndex].id!)
            print("items")
          print(collectionlists [blogIndex].itemurl!)
        }
    }
    
    // MARK: - UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = collectionlists  [row].id
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(collectionlists[row].id!)
    }
    
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
                    //adding values to the collection list
                    self.collectionlists.append(Collections(
                       id: (collectionArray[i] as AnyObject).value(forKey: "id") as? String,
                       name: (collectionArray[i] as AnyObject).value(forKey: "name") as? String,
                       imageUrl: (collectionArray[i] as AnyObject).value(forKey: "imageurl") as? String,
                       itemurl: (collectionArray[i] as AnyObject).value(forKey: "itemurl") as? String
                    ))
                }
                //displaying data in tableview
                self.MenuTableView.reloadData()
            }
        }
        self.MenuTableView.reloadData()
        
        //to perform segue to load ItemViewController
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // to go back Account page
    @IBAction func goToAccountPage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAccount", sender: self)
    }
}
