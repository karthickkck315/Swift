# Swift
From your ViewController.Swift



       //Check Empty String
       if GlobalClass.sharedInstance.isEmpty(your string! as String)
            {
            }
            
      // Show AlertView controller
      GlobalClass.sharedInstance.alertView("", message:enterEmail, action:AlertBtn, sender: self)
             
      // Show Activity
      GlobalClass.sharedInstance.activity(self.view)
      
      // remove activity
        GlobalClass.sharedInstance.removeActivity(self.view)
      
      //        check networkConnectivity
        if GlobalClass.sharedInstance.hasConnectivity()
        {
       }
       
       // For JSON Parsing
       GlobalClass.sharedInstance.getJsonData(postString, url:myUrl!, method:"POST", completionHandler:
                    {
                    (jsonData) -> () in
                    })
        
        
        
        // Set Font
        Your textField or textView or lable.font = GlobalClass.Font.RegularMedium
        
        // Set Color 
        
        Your View.backgroundColor = GlobalClass.color.textColor
        
