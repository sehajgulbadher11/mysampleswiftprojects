//
//  RoomTypeViewController.swift
//  Hotel Codable
//
//  Created by Student on 28/08/25.
//

import UIKit
protocol RoomTypeViewControllerDelegate: AnyObject {
    func RoomTypeViewController (_ controller: RoomTypeViewController, didSelect roomtype: RoomType)
}

class RoomTypeViewController: UITableViewController {
    let roomTypes = RoomType.all       // all available rooms
        var selectedRoomType: RoomType?    // currently selected one
    weak var delegate: RoomTypeViewControllerDelegate?

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return roomTypes.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
            let roomType = roomTypes[indexPath.row]

            var content = cell.defaultContentConfiguration()
            content.text = roomType.name
            content.secondaryText = "$\(roomType.price)"
            cell.contentConfiguration = content

            // ✅ checkmark only if this is the selected one
            cell.accessoryType = (roomType == selectedRoomType) ? .checkmark : .none

            return cell
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = roomTypes[indexPath.row]   // update selected
        
        if let selectedRoomType = selectedRoomType {
            delegate?.RoomTypeViewController(self, didSelect: selectedRoomType)
        }
        
        tableView.reloadData()
    }

    
    
    
    
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
