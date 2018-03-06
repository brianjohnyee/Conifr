//
//  MyTripsCollectionVC.swift
//  Conifr
//
//  Created by Sid Verma on 2/6/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit
import MapKit
import Floaty

private let reuseIdentifier = "TripsCell"

class MyTripsCollectionVC: UICollectionViewController {
    
    var numberItems = [1,2,3,4,5,6,7,8,9]
    var gang = ["My", "God", "Crdfnsdlnk", "sdfsd", "dsfsdf", "DSdsfsdfsdfsdfsd", "fdsfsdf", "dfsfsdfsfsdf", "dsfsdf"]
    @IBOutlet var ourView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TripsCell")
 
        self.collectionView!.register(UINib(nibName: "TripsCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        
        let floaty = Floaty()
        floaty.addItem("Track my trip", icon: #imageLiteral(resourceName: "location"), handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Add a trip", icon: #imageLiteral(resourceName: "plus"), handler: { item in
            let addTripVC = self.storyboard?.instantiateViewController(withIdentifier: "addTripCollectionVC") as! AdddTripCollectionVC
            
            self.navigationController?.pushViewController(addTripVC, animated: true)
            
            floaty.close()
        })
        floaty.addItem("Debug", icon: #imageLiteral(resourceName: "gear"), handler: { item in
            let debugVC = self.storyboard?.instantiateViewController(withIdentifier: "debug") as! TestingActivityVC
            
            self.navigationController?.pushViewController(debugVC, animated: true)
            
            floaty.close()
        })
        
        
        floaty.paddingY = 60
        self.view.addSubview(floaty)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "My Trips"
        let profileIcon = UIBarButtonItem(image: #imageLiteral(resourceName: "Profile Icon"), style: .plain, target: self, action: #selector(pushProfile(sender:)))
        profileIcon.largeContentSizeImage = #imageLiteral(resourceName: "Profile Icon")
        profileIcon.largeContentSizeImageInsets.top = 2
        profileIcon.tintColor = UIColor(red:86/255.0, green:86/255.0, blue:86/255.0,  alpha:1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = profileIcon
    }

    @objc func pushProfile(sender: UIBarButtonItem){
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
        
        navigationController?.pushViewController(profileVC, animated: true)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TripsCell
        // Configure the cell

        cell.dateTime.text = "Jumbo"
        cell.dist.text = "ok"
        cell.mode.text = gang[indexPath.row]
        return cell
    }


}
