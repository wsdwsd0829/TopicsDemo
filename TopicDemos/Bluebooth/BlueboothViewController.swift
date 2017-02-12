//
//  BlueboothViewController.swift
//  TopicDemos
//
//  Created by Sida Wang on 2/10/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import UIKit
import CoreBluetooth
import QuartzCore

class BlueboothViewController: UIViewController {

    struct Constants {
        static let serviceUUID = "serviceUUID"
    }
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    var cbManager: CBCentralManager!
    var cbPeripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let cbUUID = CBUUID(string: Constants.serviceUUID)
        cbManager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startClicked(_ sender: UIButton) {
        cbManager.scanForPeripherals(withServices: nil, options: nil)
    }

}
extension BlueboothViewController: CBCentralManagerDelegate {
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name) \(peripheral.identifier)")
        //identifier: is changing
        
        if peripheral.name == "MiniBeacon_01322" { // can be mack book pro also
            cbPeripheral = peripheral
            cbPeripheral.delegate = self
            cbManager.connect(peripheral, options: nil)
            cbManager.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        cbPeripheral = peripheral
        print(peripheral.state == .connected ? "connected" : "not connected")
        peripheral.discoverServices(nil)
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
}
extension BlueboothViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(error ?? "nothing error")
        peripheral.services?.forEach() {
            print("service: \($0.uuid) ")
            $0.characteristics?.forEach({
                print("characteristic \($0.uuid)")
            })
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("service: \(service.uuid)")
        print("service: \(peripheral.services)")
        service.characteristics?.forEach({
            print("characteristic \($0.uuid)")
        })
    }
}






