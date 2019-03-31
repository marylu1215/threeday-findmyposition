//
//  ViewController.swift
//  threeday-findmyposition
//
//  Created by MacBook Pro on 2019/3/25.
//  Copyright © 2019年 MacBookPro. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

//let latitude :CGFloat
//let longtitude :CGFloat

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var label = UILabel()
    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    
    let clGeoCoder = CLGeocoder()
    let geocoder = CLGeocoder()
    let locationLabel = UILabel()
   
   // var x :Double?
    //var lazy :Double!
    
    var latitude = 1.5
    var  longitude = 2.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label = UILabel();
        label.backgroundColor = UIColor.yellow
        label.text = "123456"
        label.textColor = UIColor.black
       self.view .addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.center)
           make.centerY.equalTo(self.view.center)
          make.width.equalTo(120)
            make.height.equalTo(45)
        }
        
 
        //设置定位服务管理器代理
        locationManager.delegate = self
         //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
         ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
        
      
        
        
    }
   
    //MARK:功能
    // 定位失败调用的代理方法
    // 定位更新地理信息调用的代理方法
    
    //定位改变执行，可以得到新位置、旧位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("先定位经纬度")
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        
        let locations: NSArray=locations as NSArray
        
      let currentLocation = locations.lastObject as! CLLocation
    
        label.text = "经度：\(currLocation.coordinate.longitude)"

        latitude = currentLocation.coordinate.latitude
        
        longitude = currentLocation.coordinate.longitude
        
        //获取纬度
        label.text = "纬度：\(currLocation.coordinate.latitude)"
        
        //获取海拔
        label.text = "海拔：\(currLocation.altitude)"
        //获取水平精度
        label.text = "水平精度：\(currLocation.horizontalAccuracy)"
        //获取垂直精度
        label.text = "垂直精度：\(currLocation.verticalAccuracy)"
        //获取方向
        label.text = "方向：\(currLocation.course)"
        //获取速度
        label.text = "速度：\(currLocation.speed)"
        
        locationManager.stopUpdatingLocation()
        self .reverseGeocode();
    }
    
    //出现错误

    
    
    //地理信息反编码
    func reverseGeocode(){
        
        let geocoder = CLGeocoder()
       // let currentLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
        let currentLocation = CLLocation(latitude: -122, longitude: -122)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                //print("错误：\(error.localizedDescription))")
                // self.textView.text = "错误：\(error!.localizedDescription))"
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                self.label.text = address
            // print("12345")
            } else {
                //print("No placemarks!")
            }
        })
        
        
    }


    

    

}

