//
//  GlobalClass.swift
//  sampleautolayout
//
//  Created by Karthick on 27/10/15.
//  Copyright © 2015 Technoduce. All rights reserved.
//

import UIKit

class GlobalClass: NSObject
{
    static let sharedInstance: GlobalClass = GlobalClass()
    
    var activityBackgroundView:UIView!
    var myActivityIndicator:UIActivityIndicatorView!
    var connected: Bool!
    var strLabel = UILabel()
    var msgFrame = UIView()
    
    
    // get data from url globbal function
    // MARK: getJsonData
    func  getJsonData(getvalue: String, url:NSURL, method:String, completionHandler: (jsonData: NSDictionary) -> ())
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                var myJSON: NSDictionary?
                let request = NSMutableURLRequest(URL:url)
                request.HTTPMethod = method
                request.HTTPBody = getvalue.dataUsingEncoding(NSUTF8StringEncoding)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
                    {
                        data, response, error in
                        if error != nil
                        {
                            return
                        }
                        do
                        {
                            myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                            //print(myJSON)
                            completionHandler(jsonData: myJSON!)
                        }
                        catch
                        {
                            return
                        }
                }
                task.resume()
        })
    }
    
    
    // global alert view function
    // MARK: alertView
    func alertView(title: String, message: String, action: String, sender: UIViewController)
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                    // set alertController for above ios 8 OS
                    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler:nil))
                    sender.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    //    global acvtivity in ios
    // MARK: activity
    func activity(view:UIView)
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                //  set fullview bacground
                self.activityBackgroundView = UIView(frame: CGRectMake(0, 0,UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
//                self.activityBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                self.activityBackgroundView.backgroundColor = UIColor.blackColor()
                self.activityBackgroundView.tag = 103
                
                // set center gray color bacground view
                self.msgFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 100, height: 100))
                self.msgFrame.center = self.activityBackgroundView.center
                self.msgFrame.layer.cornerRadius = 15
                self.msgFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
                
                //  set activity view controller in center gray view
                self.myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
                self.myActivityIndicator.frame = CGRect(x:(self.msgFrame.frame.width/2)-25 , y:(self.msgFrame.frame.height/2)-35, width: 50, height: 50)
                //                self.myActivityIndicator.center = self.msgFrame.center
                self.myActivityIndicator.startAnimating()
                
                //  set loading message label in activity
                self.strLabel = UILabel(frame: CGRect(x:0, y:self.myActivityIndicator.frame.height+5, width: self.msgFrame.frame.width, height:30))
                self.strLabel.text = "Please wait..."
                self.strLabel.textAlignment = NSTextAlignment.Center
                self.strLabel.font = Font.RegularMedium
                self.strLabel.textColor = UIColor.whiteColor()
                
                self.msgFrame.addSubview(self.myActivityIndicator)
                self.msgFrame.addSubview(self.strLabel)
                self.activityBackgroundView.addSubview(self.msgFrame)
                view.addSubview(self.activityBackgroundView)
        })
    }
    
    
    //    func removeActivity (view:UIView)
    // MARK: removeActivity
    func removeActivity(view:UIView)
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                self.activityBackgroundView.viewWithTag(103)?.removeFromSuperview()
        })
       
    }
    
    //  check Rechability
    // MARK: hasConnectivity
    func hasConnectivity() -> Bool
    {
        
        do
        {
            connected = try Reachability.reachabilityForInternetConnection().isReachable()
        }
        catch
        {
            return false
        }
        if connected == true
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
    //    check valid email address
    // MARK: isValidEmail
    func isValidEmail(textStr:String) -> Bool
    {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailText = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailText.evaluateWithObject(textStr)
    }
    
    
    //    is empty string
 // MARK: isEmpty
    func isEmpty(string: String? = String()) -> Bool
    {
        if string == nil || (string ?? "").isEmpty
        {
            return true
        }
        return false
    }
    
//    set font size globally for all class
// MARK: Set font
    struct Font
    {
        // regular font
        static let RegularSmall = UIFont(name: regularFont, size: 12)!
        static let RegularMedium = UIFont(name: regularFont, size: 14)!
        static let RegularMedium1 = UIFont(name: regularFont, size: 13)!
        static let RegularBig = UIFont(name: regularFont, size: 16)!
        
        //        Bold font
        static let BoldSmall = UIFont(name: boldFont, size: 12)!
        
        static let BoldMedium = UIFont(name: boldFont, size: 14)!
        
        static let BoldBig = UIFont(name: boldFont, size: 15)!
        
        
        //        light font
        static let LightSmall = UIFont(name: lightFont, size: 12)!
        
        static let LightMedium = UIFont(name: lightFont, size: 14)!
        
        static let LightBig = UIFont(name: lightFont, size: 16)!
        
        
        //        thin font
        static let ThinSmall = UIFont(name: thinFont, size: 12)!
        
        static let ThinMedium = UIFont(name: thinFont, size: 14)!
        
        static let ThinBig = UIFont(name: thinFont, size: 16)!
    }
    
    // MARK: Set global color
    struct color
    {
        static let backGroundColor = UIColor(red: 29.0/255.0, green: 29.0/255.0, blue: 37.0/255.0, alpha: 1.0)
        
        static let buttonBackgroundColor = UIColor(red: 36.0/255.0, green: 196.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        
        static let popupBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        
        static let textColor = UIColor.whiteColor()
        
        static let tintColor = UIColor.whiteColor()
        
        static let tableviewCellBackground = UIColor.clearColor()
        
        static let clearColor = UIColor.clearColor()
        
        static let textBorderColor = UIColor.lightGrayColor().CGColor
        
        static let descriptionTextColor = UIColor.lightGrayColor()
        
        static let progressBackGroundColor = UIColor.lightGrayColor()
        
        static let imageViewBackGroundColor = UIColor.whiteColor()
        
        static let tapButtonBackGroundColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        
        static let sectionSeperatorColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 54.0/255.0, alpha: 0.5)
        static let cellSeperatorColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 54.0/255.0, alpha: 0.8)
        
        static let progressCompleted = UIColor(red: 36.0/255.0, green: 196.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        
        static let  statusCompleted = UIColor.greenColor()
        static let  statusInCompleted = UIColor.redColor()
        
        
    }
    
}
