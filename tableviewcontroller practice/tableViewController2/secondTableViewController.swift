//
//  secondTableViewController.swift
//  tableViewController2
//
//  Created by Student on 21/08/25.
//

import UIKit

class secondTableViewController: UITableViewController {

   
    @IBOutlet weak var symboltextField: UITextField!
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var descriptiontextField: UITextField!
    @IBOutlet weak var usageTextFiled: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled=false
        if let emoji=emoji{
            updateUI(emoji:emoji)}
        updateTheButtonState()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    var emoji:Emoji!
    init?(coder:NSCoder,emoji:Emoji?=nil){
        self.emoji=emoji
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateUI(emoji:Emoji){
        symboltextField.text=emoji.symbol
        nametextField.text=emoji.name
        descriptiontextField.text=emoji.description
        usageTextFiled.text=emoji.usage
    }
    
    
    @IBAction func symbolAction(_ sender: Any) {
       updateTheButtonState()
    }
    
    func updateTheButtonState(){
        guard symboltextField.text != "" && nametextField.text != "" && descriptiontextField.text != "" && usageTextFiled.text != "" else{
            saveButton.isEnabled=false
             return
         }
        saveButton.isEnabled=true
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let emoji=Emoji(symbol: symboltextField.text ?? " ", name: nametextField.text ?? " ", description: descriptiontextField.text ?? " ", usage: usageTextFiled.text ?? " ")
        self.emoji=emoji
        performSegue(withIdentifier: "savebuttontapped", sender: nil)
        
    }
    
    // MARK: - Table view data source

   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
