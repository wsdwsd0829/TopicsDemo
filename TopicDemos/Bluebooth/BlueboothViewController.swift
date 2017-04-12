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
extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}
protocol TextUpdatable {
    var text: String! { get set }
    mutating func appendContent(_ content: String, _ isAddReturn: Bool)
}
extension TextUpdatable {
    mutating func appendContent(_ content: String, _ isAddReturn: Bool = true) {
        if var res = self.text {
            let newLine = isAddReturn ? "\n" + content : content
            res += newLine
            self.text = res
        } else {
            self.text = content
        }
    }
}
extension UITextView: TextUpdatable {
}

class BlueboothViewController: UIViewController {
    var count = "hello"

    struct Constants {
        static let serviceUUID = "serviceUUID"
    }
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var statusLabel: UITextView!
    
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
    
    //MARK: discover callback
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //identifier: is changing
        
        if peripheral.name == "MiniBeacon_01322" { // can be mack book pro also
            print("advertisementData: \(advertisementData), RSSI: \(RSSI)")
            statusLabel.appendContent("advertisementData: \(advertisementData), RSSI: \(RSSI)")
            statusLabel.appendContent("Discovered \(peripheral.name) \(peripheral.identifier)")
            cbPeripheral = peripheral
            cbPeripheral.delegate = self
            cbManager.connect(peripheral, options: nil)
            cbManager.stopScan()
        }
    }
    
    //MARK: connect call back
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        cbPeripheral = peripheral
        statusLabel.appendContent(peripheral.state == .connected ? "connected" : "not connected")
        peripheral.discoverServices(nil)
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
}
extension BlueboothViewController: CBPeripheralDelegate {
    //MARK: discover services callback
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(error ?? "nothing error")
        peripheral.services?.forEach() {
            statusLabel.appendContent("DiscoveredService: \($0.uuid) ")
            peripheral.discoverCharacteristics(nil, for: $0)
            
        }
    }
    //MARK: discover peripheral callback
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        service.characteristics?.forEach({
            statusLabel.appendContent("DiscoveredCharacteristic: \($0.uuid) forService: \(service.uuid)")
            peripheral.readValue(for: $0)
        })
    }
    //MARK: read Value callback
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            //characteristic.uuid == "Battery Level"
            //characteristic.uuid.uuidString == "2A19"
            if characteristic.properties.contains(.notify) {
                print("found notify")  //Battery Level
                
            }
            if characteristic.properties.contains(.write) && characteristic.uuid.uuidString == "FFF6" {
                print("found writable")
               // Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
                    let data = count.data(using: .utf8)
                    //count += 1
                    peripheral.writeValue(data!, for: characteristic, type: .withResponse)
                if #available(iOS 10.0, *) {
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
                        self.cbManager.connect(peripheral, options: nil)
                    }
                } else {
                    // Fallback on earlier versions
                }

               // })
            }
            if characteristic.uuid.uuidString == "2A19" {
                statusLabel.appendContent("\(characteristic.uuid) \(data.to(type: Int.self))")
            } else if let str = String(data: data, encoding: .utf8) {
                statusLabel.appendContent("uuid:\(characteristic.uuid) uuidString: \(characteristic.uuid.uuidString) valueStr: \(str)")
                
            }
            //write something to that characteristic
            if characteristic.uuid.uuidString == "FFF6" {
                peripheral.setNotifyValue(true, for: characteristic)
                
            }

        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid.uuidString == "FFF6" {
            let str = String(data: characteristic.value!, encoding: .utf8)
            print("YEAH didUpdateNotificationStateFor: \(characteristic.uuid) \(str)")
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        //TODO rescan and repeat
        print("writeForCharacteristic: \(characteristic.uuid) didWrite: \(String(data: characteristic.value!, encoding: .utf8))")
    }
}






