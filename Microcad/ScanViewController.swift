//
//  ScanViewController.swift
//  Microcad
//
//  Created by Pradeep Chandrasekaran on 11/07/19.
//  Copyright © 2019 Pradeep Chandrasekaran. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralManagerDelegate, UITableViewDelegate, UITableViewDataSource {
  
    
   
    
    var centralManager: CBCentralManager?
    var selectedPeripheral: CBPeripheral?
    var peripherals = Array<CBPeripheral>()
    
    
    @IBOutlet weak var deviceTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceTableView.delegate = self
        deviceTableView.dataSource = self
       centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)

    }
    
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
            
        case .unknown:
            print("Bluetooth status is UNKNOWN")
           
        case .resetting:
            print("Bluetooth status is RESETTING")
           
        case .unsupported:
            print("Bluetooth status is UNSUPPORTED")
           
        case .unauthorized:
            print("Bluetooth status is UNAUTHORIZED")
           
        case .poweredOff:
            print("Bluetooth status is POWERED OFF")
           
        case .poweredOn:
            print("Bluetooth status is POWERED ON")
            
            DispatchQueue.main.async { () -> Void in
//                self.bluetoothOffLabel.alpha = 0.0
//                self.connectingActivityIndicator.startAnimating()
            }
            
            // STEP 3.2: scan for peripherals that we're interested in
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
            
        } // END switch
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
      
        
    }
    
   
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        deviceTableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(peripheral)
        print("Connected")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let peripheral = peripherals[indexPath.row]
        if peripheral.name == nil {
            cell.textLabel?.text = "N/A"
        }
        else {
            cell.textLabel?.text = peripheral.name
        }
        
        return cell
    }
    
}
