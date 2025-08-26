//
//  firstTableViewController.swift
//  tableViewController2
//
//  Created by Student on 21/08/25.
//

import UIKit

class firstTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emoji", for: indexPath)
        var content=cell.defaultContentConfiguration()
        content.text="\(emojis[indexPath.row].symbol)-\(emojis[indexPath.row].name)"
        content.secondaryText="\(emojis[indexPath.row].description)"
        cell.contentConfiguration=content
        // Configure the cell...
        cell.showsReorderControl=true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "editSegue", sender: indexPath)
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    
    @IBSegueAction func addEditedEmoji(_ coder: NSCoder, sender: Any?) -> secondTableViewController? {
        guard let indexPath=sender as? IndexPath else{
            return secondTableViewController(coder: coder,emoji:nil)
        }
        emojis[indexPath.row]
        return secondTableViewController(coder: coder,emoji:emojis[indexPath.row])
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let element=emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(element)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let ele=emojis.remove(at: fromIndexPath.row)
        emojis.insert(ele, at: to.row)

    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    @IBAction func unwindToFirstTableViewController(segue:UIStoryboardSegue){
        guard segue.identifier=="savebuttontapped" ,let secondTVC=segue.source as? secondTableViewController , let emojie=secondTVC.emoji else{
            return
        }
        guard let selectedIndexPath=tableView.indexPathForSelectedRow else{
            emojis.append(emojie)
           let indexpath=IndexPath(row: emojis.count-1, section: 0)
            tableView.insertRows(at: [indexpath], with: .fade)
            return
        }
        
        emojis[selectedIndexPath.row]=emojie
        tableView.reloadRows(at:[selectedIndexPath],with:.fade)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
