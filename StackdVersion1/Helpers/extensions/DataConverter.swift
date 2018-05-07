//
//  DataConverter.swift
//  StackedV1
//
//  Created by Sky Xu on 3/25/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    /**
     Get the MD5 hash of this String
     
     - returns: MD5 hash of this String
     */
    func md5() -> String! {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//
//        for i in 0..<digestLength {
//            hash.appendFormat("%02x", result[i])
//        }
//
//        result.deinitialize()
////        print(hash)
//        return String(format: hash as String)
        
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        let md5Hex =  digestData.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8)
        return text!
    }
    
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        if let message = String(data: data!, encoding: .nonLossyASCII){
            return message
        }
        return ""
    }
}

