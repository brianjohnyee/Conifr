//
//  ViewController.swift
//  Conifr
//
//  Created by Chantelle Mak on 2/8/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
        var list = ["Name", "Email", "College", "Clear Data", "About", "Contact Us", "Legal"]
        var listDesc = ["Name", "user@ucsc.edu", "Rachel Carson College", "Clear Data", "About Conifr", "Conact us @", "Legal"]
        var myIndex = 0
    
    
    public func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }

    
    public func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        self.tableView.contentInset = UIEdgeInsetsMake(105, 0, 0, 0)
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        tableView.rowHeight = 60

        
        
//        self.view.backgroundColor = UIColor.red;

    
        // Do any additional setup after loading the view.
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
