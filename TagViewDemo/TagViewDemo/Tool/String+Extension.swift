//
//  String+Extension.swift
//
//  Created by 刘志康 on 2018/2/22.
//  Copyright © 2018年 刘志康 All rights reserved.
//

import UIKit

extension String {
    //使用正则表达式替换
    func stringReplace(_ pattern: String,_ placeholder: String) -> String {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return self
        }
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: placeholder)
    }
    
    func stringReplace(range: NSRange, target: String) -> String {
        let origin = NSString.init(string: self)
        return origin.replacingCharacters(in: range, with: target)
    }
    
    /// 获取手机号码
    func getPhone() -> String {
        
        var phoneStr: String = replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        
        if !phoneStr.isNumber() {
            
            let firstStr: String = phoneStr.substringTo(index: 1)
            
            if !firstStr.isNumber() {
                phoneStr = phoneStr.replacingOccurrences(of: firstStr, with: "")
            }
            
            let endStr: String = phoneStr.substringFrom(index: phoneStr.count-1)
            
            if !endStr.isNumber() {
                phoneStr = phoneStr.replacingOccurrences(of: endStr, with: "")
            }
        }
        return phoneStr
    }
   
    
    /// 获取字符串中指定一段字符所在位置
    func range(subStr: String) -> NSRange {
        return NSString(string: self).range(of: subStr)
    }
    
    /// 精确double值   假如传入0.00则精确到小数点后两位
    func doubleAccurate(_ decimal: Int = 2) -> String{
        return String(format:"%.\(decimal)f", self.doubleValue())
    }
    
    /// 分割字符
    func split(s: String) -> [String] {
        if self == "" {
            return []
        }
        let str:NSMutableString = NSMutableString(string: self)

        if str.hasPrefix(s) { str.replaceCharacters(in: NSMakeRange(0, 1), with: "") }
        
        if str.hasSuffix(s) { str.replaceCharacters(in: NSMakeRange(str.length-1, 1), with: "") }
        
        return str.components(separatedBy: s)
    }
    
    /// 去掉左右空格
    func trim() -> String {
        return trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    /// 往后截取字符串
    func substringFrom(index: Int) -> String {
        if count < 1 {
            return ""
        }
        return String(suffix(index))
    }
    
    /// 往前截取字符串
    func substringTo(index: Int) -> String {
        if count < 1 {
            return ""
        }
        return String(prefix(index))
    }
    
    /// 千位分隔符
    func stringWithThousandsSeparator() -> String {
        
        let tempArr:[String] = self.split(s: ".")
        if tempArr.count == 0 || tempArr[0].count < 4 {
            return self
        }
        
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.formatterBehavior   = .behavior10_4
        numberFormatter.numberStyle         = .decimal
        
        let str_1:String = "\(numberFormatter.string(from: NSNumber(value: tempArr[0].doubleValue()))!)"
        
        if tempArr.count == 1 {
            return str_1
        }
        return "\(str_1).\(tempArr[1])"
    }
    
 
    /// 过滤器 将.2f格式化的字符串，去除末尾0
    ///
    /// - Parameter numberString: .2f格式化后的字符串
    /// - Returns: 去除末尾0之后的
    func removeSuffixZero() -> String {
        
        if self.count > 1 {
            let strs = self.components(separatedBy: ".")
            let last = strs.last!
            if strs.count == 2 {
                if last == "00" {
                    
                    let indexEndOfText = self.index(self.endIndex, offsetBy:-3)
                    return String(self[..<indexEndOfText])
                    
                }else{
                    
                    let indexStartOfText    = self.index(self.endIndex, offsetBy:-1)
                    let str                 = self[indexStartOfText...]
                    let indexEndOfText      = self.index(self.endIndex, offsetBy:-1)
                    if str == "0" {
                        return String(self[..<indexEndOfText])
                    }
                }
            }
            return self
        }else{
            return ""
        }
    }
    
   
    
    func stringFromBytes(bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", bytes[i])
        }
        bytes.deallocate()
        
        return String(format: hash as String)
    }
    
    /// 字体宽度计算 maxWidth 存在最大宽度,计算高度 maxHeight 存在最大高度计算最大宽度 
    func textSizeWithFont(font: UIFont, maxWidth:CGFloat = 0, maxHeight:CGFloat = 0)->CGSize {
        
        
        
        
//        let size = font.pointSize
//        let nFont =  font.withSize(size+1) //可以创建一个大一号字体来纠正字体计算不准确问题
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.usesDeviceMetrics.rawValue

        let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        var strWidth:CGFloat = maxWidth
        var strHeight:CGFloat = maxHeight
        
        if strWidth == 0 {
            strWidth = CGFloat(MAXFLOAT)
//             return CGSize.init(width: getTextWidth(text: self, font: font,height:strHeight), height: maxHeight)
        }
        if strHeight == 0 {
            strWidth -= 1
            strHeight = CGFloat(MAXFLOAT)
//            return  CGSize.init(width: maxWidth, height: getTextHeight(text: self, strWidth, font))
        }
        let stringRect = self.boundingRect(with: CGSize(width: strWidth,height: strHeight), options: NSStringDrawingOptions(rawValue: option), attributes: attributes as? [NSAttributedString.Key : Any] , context: nil)
        return stringRect.size
    }
}
//MARK: 转换为其他类型
extension String{
    /// 字符串转换
    func intValue() -> Int {
        return NSString(string: self).integerValue
    }
    func boolValue() -> Bool {
        return NSString(string: self).boolValue
    }
    func doubleValue() -> Double{
        return NSString(string: self).doubleValue
    }
    func floatValue() -> Float{
        return NSString(string: self).floatValue
    }
    ///转换URL 已对特殊字符做编码
    func urlValue() ->URL?{
        let urlStr = self.encodingUrlStr()
        let url = URL.init(string: urlStr)
        return url
    }
    //编码urlStr 对特殊字符串和汉字做编码 lose 不做编码的字符串
    func encodingUrlStr(_ lose:String? = "") ->String{
        let charSet = NSMutableCharacterSet()
        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
        if lose != nil && lose!.count != 0{
            charSet.addCharacters(in: lose!)
        }
        let urlStr = self.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)
        return urlStr ?? ""
    }
}
//MARK: 判断
extension String{
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    /// 是否是身份证
    func isIdentityCard()->Bool {
        
        let matchStr:String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pre:NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        
        return pre.evaluate(with: self)
    }
    /// 判断内容是否全部为空格
    func isEmpty() -> Bool {
        if isEmpty {
            return true
            
        } else {
            let set: CharacterSet     = CharacterSet.whitespacesAndNewlines
            let trimedString: String = trimmingCharacters(in: set)
            
            if trimedString.count == 0 {
                return true
            } else {
                return false
            }
        }
    }
    ///是否是邮箱
    func validateEmail(candidate: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    /// 是否是数字
    func isNumber() -> Bool {
        let matchStr:
            String = "^[0-9]{\(count)}$"
        let pre:
            NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        
        return pre.evaluate(with: self)
    }
    
    /// 是否是中文
    func isMatchChinese() -> Bool{
        let matchStr: String = "^[一-龥]+$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        
        return pre.evaluate(with: self)
    }
    /// 是否是手机号码
    func isPhoneNum()->Bool{
        let matchStr: String = "^1[3456789][0-9]{9}$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        
        return pre.evaluate(with: self)
    }
}
//MARK: 时间
extension String {
    /// 时间戳转换
    func dateIntervalToString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        let df        = DateFormatter()
        df.dateFormat = dateFormat
        let date      = Date(timeIntervalSince1970: self.doubleValue()/1000)
        
        return df.string(from: date)
    }
    
    func changeTimeFormat(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        let date = self.dateFromString()
        let formatter: DateFormatter  = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    
    /// 将字符串时间转成Date格式
    func dateFromString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        if self == "" { return Date() }
        
        let formatter: DateFormatter  = DateFormatter()
        formatter.dateFormat = dateFormat
        
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        return date
    }
    
    /// 上一天
    func dateLastDay() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat         = "yyyy-MM-dd"
        
        let lastDate: Date = Date(timeInterval: -24*60*60, since: dateFormatter.date(from: self)!)
        
        return dateFormatter.string(from: lastDate)
    }
    
    /// 下一天
    func dateNextDay() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat         = "yyyy-MM-dd"
        
        let lastDate: Date = Date(timeInterval: 24*60*60, since: dateFormatter.date(from: self)!)
        
        return dateFormatter.string(from: lastDate)
    }
    
    /// 时间加几天或减几天
    func dateAfterDay(_ day: Int) -> Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat         = "yyyy-MM-dd HH:mm:ss.SSS"
        
        let lastDate: Date = Date(timeInterval: TimeInterval(day*24*60*60), since: dateFormatter.date(from: self)!)
        
        return lastDate
    }
    
    /// 判断时间是否是今天
    func isToDay() -> Bool {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat         = "yyyy-MM-dd"
        
        let nowDateStr: String = dateFormatter.string(from: Date())
        if self == nowDateStr {
            return true
        }
        return false
    }
    
    /// 开始时间和结束时间对比 返回相差分数
    func dateTimeDifference(_ endTime: String) -> String {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat         = "yyyy-MM-dd HH:mm:ss.SSS"
        
        let startDate: Date? = formatter.date(from: self)
        let endDate: Date?   = formatter.date(from: endTime)
        
        //时间差
        let timeDifference: TimeInterval = endDate!.timeIntervalSince1970 - startDate!.timeIntervalSince1970
        //秒
        let second: Int = Int(timeDifference)
        //分
        let minute: Int = Int(timeDifference/60)
        
        if minute == 0 {
            return "\(second)秒"
        }
        return "\(minute)分钟"
    }
    
    /// 字符串时间和当前时间进行对比  字符串时间在当前时间之前，则返回true
    func dateCompareCurrent() -> Bool {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date: Date? = dateFormatter.date(from: self)
        
        if date?.compare(Date()) == ComparisonResult.orderedAscending {
            return true
        }
        return false
    }
    
    /// 转换成星期
    ///
    /// - Returns: 转换完成的星期
    func weekdayString() -> String {
        let date = self.dateFromString()
        let componets = Calendar.autoupdatingCurrent.component(.weekday, from: date)
        let weekArr = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        return weekArr[componets-1]
    }
    
}
