//
//  UIDateFormatter + Extension.swift
//  NV_ORG
//
//  Created by Netventure on 13/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
extension DateFormatter {
    /**
     Formats a date as the time since that date (e.g., “Last week, yesterday, etc.”).
     
     - Parameter from: The date to process.
     - Parameter numericDates: Determines if we should return a numeric variant, e.g. "1 month ago" vs. "Last month".
     
     - Returns: A string with formatted `date`.
     */
    func timeSince(from: NSDate, numericDates: Bool = false ,format : String) -> String {
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        if components.year! >= 1 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = format
            //            dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC+5:30")
                        let earliestDate = dateFormatter.string(from: earliest)
                        result = earliestDate
//            result = self.string(from: earliest as Date)
            //            result = "\(components.year!) years ago"
            //        } else if components.year! >= 1 {
            //            if numericDates {
            //                result = "1 year ago"
            //            } else {
            //                result = "Last year"
            //            }
            //        } else if components.month! >= 2 {
            //            result = "\(components.month!) months ago"
            //        } else if components.month! >= 1 {
            //            if numericDates {
            //                result = "1 month ago"
            //            } else {
            //                result = "Last month"
            //            }
            //        } else if components.weekOfYear! >= 2 {
            //            result = "\(components.weekOfYear!) weeks ago"
            //        } else if components.weekOfYear! >= 1 {
            //            if numericDates {
            //                result = "1 week ago"
            //            } else {
            //                result = "Last week"
            //            }
        }else if components.month! >= 1 {
                    //            if components.day! == 1{
                    //                result = "yesterday"
                    //            }else{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = format// hh:mm a"
        //            dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC+5:30")
                    let earliestDate = dateFormatter.string(from: earliest)
                    result = earliestDate//self.string(from: earliest as Date)
                    //            }
                    
                    //        } else if components.day! == 0 {
                    ////            if components.day! == 1{
                    ////                result = "today"
                    ////            }
                    //            if numericDates {
                    //                result = "today"
                    ////                result = self.string(from: earliest as Date)
                    //            } else {
                    ////                result = "today"
                    //                result = "today"
                    //            }
                } else if components.day! >= 1 {
            //            if components.day! == 1{
            //                result = "yesterday"
            //            }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
//            dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC+5:30")
            let earliestDate = dateFormatter.string(from: earliest)
            result = earliestDate//self.string(from: earliest as Date)
            //            }
            
            //        } else if components.day! == 0 {
            ////            if components.day! == 1{
            ////                result = "today"
            ////            }
            //            if numericDates {
            //                result = "today"
            ////                result = self.string(from: earliest as Date)
            //            } else {
            ////                result = "today"
            //                result = "today"
            //            }
        } else if components.hour! <= 12{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
//            dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC+5:30")
            let earliestDate = dateFormatter.string(from: earliest)
            result = earliestDate
        }else if components.hour! <= 24{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = format//hh:mm a"
        //            dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC+5:30")
                    let earliestDate = dateFormatter.string(from: earliest)
                    result = earliestDate
                }
        
        //            if components.hour! > 12{
        //                result = "today"
        //            }else{
        //                result = "\(components.hour!) hrs ago"
        //            }
        //            ////"\(components.minute!) hrs ago"//self.string(from: earliest as Date)
        //        } else if components.hour! == 1 {
        //            if numericDates {
        //                result = "1 hr ago"
        //            } else {
        //                result = "1 hr ago"
        //            }
        //        } else if components.minute! >= 2 {
        //            result = "\(components.minute!) mins ago"
        //        } else if components.minute! >= 1 {
        //            if numericDates {
        //                result = "1 min ago"
        //            } else {
        //                result = "1 min ago"
        //            }
        //        } else if components.second! >= 3 {
        //            result = "\(components.second!) secs ago"
        //        } else {
        //            result = "now"
        //        }
        
        return result
    }
    
}

extension String {
    func setTime(format :String) -> String{
        let timeResult = Double(self)
        let date = Date(timeIntervalSince1970: timeResult!)// / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone =  TimeZone.current
        let localDate = dateFormatter.timeSince(from: date as NSDate, numericDates: false, format: format)//string(from: date)
        return localDate
    }
}
