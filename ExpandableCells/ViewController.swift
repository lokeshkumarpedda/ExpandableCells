//
//  ViewController.swift
//  ExpandableCells
//
//  Created by Lokesh on 07/01/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let headerArray = ["First", "Second", "Third", "Fourth"]
    let childArray = [["1","10","20"],["2"],["4","5","6"],["7","8"]]
    
    var mAllCells = [CellDetails]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileName.text = "NEXT ERP"
        profilePicture.image = UIImage(named: "logo")
        profilePicture.layer.cornerRadius = 50
        profilePicture.clipsToBounds = true
        
        // creating allcells array with given data
        for i in headerArray{
            let tempObj = CellDetails(value: i, id: 1, expanded: false, isExpandable: true)
            self.mAllCells.append(tempObj)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.mAllCells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            
            cell.textLabel?.text = self.mAllCells[indexPath.row].mValue
            return cell
        }
        
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // For recognizing headers
        if self.mAllCells[indexPath.row].mIsExpandable!{
            if self.mAllCells[indexPath.row].mExpanded!{
                // when clicked twice deleting cells
                deletetingRows(indexPath : indexPath as NSIndexPath)
            }
            else{
                // Expanding the clicked cell
                if let index = headerArray.index(of: self.mAllCells[indexPath.row].mValue!){
                    mAllCells[indexPath.row].mExpanded = true
                    let k = mAllCells[indexPath.row]
                    tableView.beginUpdates()
                    for i in 1 ... childArray[index].count {
                        let tempChild = CellDetails(value: childArray[index][i-1], id: 2, expanded: false, isExpandable: false)
                        self.mAllCells.insert(tempChild, at: indexPath.row+i)
                        tableView.insertRows(at: [NSIndexPath.init(row: indexPath.row+i, section: 0) as IndexPath], with: .top)
                    }
                    tableView.endUpdates()
                    collapse(celldetail: k)
                }
            }
        }
        else{
            
        }
    }
    
    // deleteing rows based on the sub array count
    func deletetingRows(indexPath : NSIndexPath) {
        tableView.beginUpdates()
        if let index = headerArray.index(of: self.mAllCells[indexPath.row].mValue!){
            self.mAllCells[indexPath.row].mExpanded = false
            for i in 1 ... childArray[index].count {
                self.mAllCells.remove(at: indexPath.row+1)
                tableView.deleteRows(at: [NSIndexPath.init(row: indexPath.row+i, section: 0) as IndexPath], with: .fade)
            }
            tableView.endUpdates()
        }
    }
    
    func collapse(celldetail : CellDetails) {
        for i in 0 ..< self.mAllCells.count{
            // checking for already expanded cell for collapsing
            if mAllCells[i].mExpanded! && mAllCells[i].mValue! != (celldetail.mValue!){
                print(mAllCells[i].mValue!)
                print(celldetail.mValue!)
                mAllCells[i].mExpanded = false
                let indexPath = NSIndexPath.init(row: i, section: 0)
                deletetingRows(indexPath : indexPath)
                // only one cell is expanded at a time so after collapsing one cell we are stop searching
                break
            }
        }
    }
}
