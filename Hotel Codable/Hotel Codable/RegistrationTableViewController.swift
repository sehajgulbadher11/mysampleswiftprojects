//
//  RegistrationTableViewController.swift
//  Hotel Codable
//
//  Created by Student on 27/08/25.
//

import UIKit

class RegistrationTableViewController: UITableViewController, RoomTypeViewControllerDelegate {
    func RoomTypeViewController(_ controller: RoomTypeViewController, didSelect roomtype: RoomType) {
        self.selectedRoomType = roomtype
        updateRoomType()
    }
    
    
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var secondName: UITextField!
    @IBOutlet var Email: UITextField!
    
    
    @IBOutlet var checkIn: UILabel!
    @IBOutlet var CheckInDatePicker: UIDatePicker!
    @IBOutlet var checkout: UILabel!
    @IBOutlet var CheckOutDatePicker: UIDatePicker!
    
    
    @IBOutlet var noOfAdults: UILabel!
    @IBOutlet var noOfChildren: UILabel!
    @IBOutlet var adultStepper: UIStepper!
    @IBOutlet var childStepper: UIStepper!
    
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    var selectedRoomType: RoomType?
    
    let checkInDateCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateCellIndexPath = IndexPath(row: 2, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerCellVisible: Bool = false {
        didSet {
            CheckInDatePicker.isHidden = !isCheckInDatePickerCellVisible
        }
    }
    var isCheckOutDatePickerCellVisible: Bool = false {
        didSet {
            CheckOutDatePicker.isHidden = !isCheckOutDatePickerCellVisible
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        CheckInDatePicker.minimumDate = midnightToday
        CheckInDatePicker.date = midnightToday
        
        CheckOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: CheckInDatePicker.date)
        
        updateDateViews()
        updateGuest()
        updateRoomType()
        
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        guard let registration = registration else {
                print("⚠️ Room type not selected. Cannot create registration.")
                return
            }
            
            // Manually pass data to FinalViewController
            if let finalVC = presentingViewController as? FinalViewController {
                finalVC.registrations.append(registration)
                print("✅ Registration added. Total count: \(finalVC.registrations.count)")
                finalVC.tableView.reloadData()
            }
            
            // Dismiss the modal
            dismiss(animated: true)
        

    }
    
    
    var registration: Registration? {
        guard let roomType = selectedRoomType else { return nil }
        
        let firstName = firstName.text ?? ""
        let lastName = secondName.text ?? ""
        let email = Email.text ?? ""
        
        let checkInDate = CheckInDatePicker.date
        let checkOutDate = CheckOutDatePicker.date
        
        let numberOfAdults = Int(adultStepper.value)
        let numberOfChildren = Int(childStepper.value)
        
        let hasWifi = wifiSwitch.isOn
        
        return Registration(
            firstName: firstName,
            lastName: lastName,
            emailAddress: email,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numOfadults: numberOfAdults,
            numOfChildren: numberOfChildren,
            wifi: hasWifi,
            roomType: roomType
        )
    }

    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        updateDateViews()
    }
    
    
    func updateDateViews(){
        checkIn.text = CheckInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        checkout.text = CheckOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerCellVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerCellVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
            
        }
        
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // If user taps Check-In label cell
        if indexPath == checkInDateCellIndexPath {
            isCheckInDatePickerCellVisible.toggle()
            
            if isCheckInDatePickerCellVisible {
                isCheckOutDatePickerCellVisible = false
            }
        }
        // If user taps Check-Out label cell
        else if indexPath == checkOutDateCellIndexPath {
            isCheckOutDatePickerCellVisible.toggle()
            
            if isCheckOutDatePickerCellVisible {
                isCheckInDatePickerCellVisible = false
            }
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    //   GUEST COUNT
    
    func updateGuest() {
        noOfAdults.text = "\(Int(adultStepper.value))"
        noOfChildren.text = "\(Int(childStepper.value))"
    }
    @IBAction func stepperValueChanged(_ sender: Any?) {
        updateGuest()
    }
    
    // WIFI
    @IBAction func wifiSwitchValueChanged(_ sender: Any?) {
        
    }
    
    // SELECT ROOM
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "SelectRoomType" {
    //            let destinationVC = segue.destination as! RoomTypeViewController
    //            destinationVC.selectedRoomType = registration.roomType
    //        }
    //    }
    
    func updateRoomType() {
        if let roomType = selectedRoomType {
            roomTypeLabel.text = roomType.name
        }
        else{
            roomTypeLabel.text = "Select Room Type"
        }
    }
    
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> RoomTypeViewController? {
        let vc = Hotel_Codable.RoomTypeViewController(coder: coder)
        vc?.delegate = self       // make RegistrationTableViewController the delegate
        vc?.selectedRoomType = selectedRoomType   // pass in currently chosen type (optional)
        return vc
    }

    
    
}
    
    
    

    
