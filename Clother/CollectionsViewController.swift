//
//  CollectionsViewController.swift
//  Clother
//
//  Created by DSV on 2018-05-16.
//  Copyright © 2018 DSV. All rights reserved.
//
let  MAX_BUFFER_SIZE = 3;
let  SEPERATOR_DISTANC = 8;
let  TOPYAXIS = 75;
import UIKit
import Alamofire

class CollectionsViewController:  UIViewController, UIApplicationDelegate {
   
    //Display
    @IBOutlet weak var viewTinderBackGround: UIView!
    // @IBOutlet weak var buttonUndo: UIButton!
    @IBOutlet weak var viewActions: UIView!
    @IBOutlet weak var viewActionHeightConstrain: NSLayoutConstraint!
    
    // variable to store collection id and collection items - passed from MenuViewController
    var collectionsId = String()
    var itemsurl = String()
    
    // variable to store items url
    var cItems = [items]()
    
    //variables for Cards
    var currentIndex = 0
    var currentLoadedCardsArray = [TinderCard]()
    var allCardsArray = [TinderCard]()
    
    //Button click - go to home page
    @IBAction func goToMenuHomePage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Button click - go to account page
    @IBAction func goToAccountPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAcountfromCollectionsPage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemsurl)
        print(collectionsId)
        //to fetch items from itemsurljson --------
        
        //fetching data from web api
        Alamofire.request(itemsurl).responseJSON { response in  
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let itemsArray : NSArray  = json as! NSArray
                
                print("itemarray count")
                print(itemsArray.count)
                //traversing through all elements of the array
                for i in 0..<itemsArray.count{
                    
                    //adding hero values to the hero list
                    self.cItems.append(items(
                        itemId: (itemsArray[i] as AnyObject).value(forKey: "itemId") as? String,
                        itemUrl: (itemsArray[i] as AnyObject).value(forKey: "itemUrl") as? String,
                        itemDetailImagesUrl: (itemsArray[i] as AnyObject).value(forKey: "itemDetailImagesUrl") as? [String]
                    ))
                }
                print("itemurl at index 0")
                print(self.cItems[0].itemUrl ?? "correct")
                print("cItems count")
                print(self.cItems.count)
                //displaying data
                self.view.layoutIfNeeded()
                self.loadCardValues()
            }
         }
    
        //--------
        print("cItems count and cItems")
        print(cItems.count)
        print(cItems)
      
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // Function to load card values -  key-value pair
    func loadCardValues() {
        if cItems.count>0 {
            let capCount = (cItems.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : cItems.count
            for (i,value) in cItems.enumerated() {
                let newCard = createTinderCard(at: i,value: value)
                allCardsArray.append(newCard)
                if i < capCount {
                    currentLoadedCardsArray.append(newCard)
                }
            }
            
            for (i,_) in currentLoadedCardsArray.enumerated() {
                if i > 0 {
                    viewTinderBackGround.insertSubview(currentLoadedCardsArray[i], belowSubview: currentLoadedCardsArray[i - 1])
                }else {
                    viewTinderBackGround.addSubview(currentLoadedCardsArray[i])
                }
            }
            animateCardAfterSwiping()
            perform(#selector(loadInitialDummyAnimation), with: nil, afterDelay: 1.0)
        }
    }
    
    @objc func loadInitialDummyAnimation() {
        
        let dummyCard = currentLoadedCardsArray.first;
        dummyCard?.shakeCard()
        UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveLinear, animations: {
            self.viewActions.alpha = 1.0
        }, completion: nil)
    }
    
    func createTinderCard(at index: Int , value :items) -> TinderCard {
        
        let card = TinderCard(frame: CGRect(x: 10, y: 0, width: viewTinderBackGround.frame.size.width - 20 , height: viewTinderBackGround.frame.size.height - 40) ,value : value)
        card.delegate = self
        return card
    }
    
    func removeObjectAndAddNewValues() {
        
        currentLoadedCardsArray.remove(at: 0)
        currentIndex = currentIndex + 1
        
        if (currentIndex + currentLoadedCardsArray.count) < allCardsArray.count {
            let card = allCardsArray[currentIndex + currentLoadedCardsArray.count]
            var frame = card.frame
            frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANC)
            card.frame = frame
            currentLoadedCardsArray.append(card)
            viewTinderBackGround.insertSubview(currentLoadedCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedCardsArray[MAX_BUFFER_SIZE - 2])
        }
        //once shown all items for survey - moves to Finish page
       if(currentIndex==cItems.count)
        {
            performSegue(withIdentifier: "showEndPage", sender: self)
        }
        
        print(currentIndex)
        animateCardAfterSwiping()
    }
    
    func animateCardAfterSwiping() {
        
        for (i,card) in currentLoadedCardsArray.enumerated() {
            UIView.animate(withDuration: 0.5, animations: {
                if i == 0 {
                    card.isUserInteractionEnabled = true
                }
                var frame = card.frame
                frame.origin.y = CGFloat(i * SEPERATOR_DISTANC)
                card.frame = frame
            })
        }
    }
    
    
    @IBAction func disLikeButtonAction(_ sender: Any) {
        
        let card = currentLoadedCardsArray.first
        card?.leftClickAction()
    }
    
    @IBAction func LikeButtonAction(_ sender: Any) {
        
        let card = currentLoadedCardsArray.first
        card?.rightClickAction()
    }
}

extension CollectionsViewController : TinderCardDelegate{
    
    // action called when the card goes to the left.
    func cardSwipedLeft(_ card: TinderCard) {
        removeObjectAndAddNewValues()
    }
    // action called when the card goes to the right.
    func cardSwipedRight(_ card: TinderCard) {
        removeObjectAndAddNewValues()
    }
    func updateCardView(_ card: TinderCard, withDistance distance: CGFloat) {
        //Log(@"%f",distance);
    }
}


