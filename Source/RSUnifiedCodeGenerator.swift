//
//  RSUnifiedCodeGenerator.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class RSUnifiedCodeGenerator: RSCodeGenerator {
    
    public var isBuiltInCode128GeneratorSelected = false
    public var fillColor: UIColor = UIColor.whiteColor()
    public var strokeColor: UIColor = UIColor.blackColor()
    
    public class var shared: RSUnifiedCodeGenerator {
        return UnifiedCodeGeneratorSharedInstance
    }
    
    // MARK: RSCodeGenerator
    
    public func generateCode(contents: String, machineReadableCodeObjectType: String) -> UIImage? {
        
        switch machineReadableCodeObjectType {
        case AVMetadataObjectTypeQRCode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeAztecCode:
            return RSAbstractCodeGenerator.generateCode(contents, filterName: RSAbstractCodeGenerator.filterName(machineReadableCodeObjectType))
        default:
            break
        }
        
        if let codeGenerator = codeGeneratorForMachineReadableCodeObjectType(machineReadableCodeObjectType) {
            codeGenerator.fillColor = fillColor
            codeGenerator.strokeColor = strokeColor
            return codeGenerator.generateCode(contents, machineReadableCodeObjectType: machineReadableCodeObjectType)
        } else {
            return nil
        }
    }
    
    public func generateCode(machineReadableCodeObject: AVMetadataMachineReadableCodeObject) -> UIImage? {
        return self.generateCode(machineReadableCodeObject.stringValue, machineReadableCodeObjectType: machineReadableCodeObject.type)
    }
    
    public func canGenerateCode(contents: String, machineReadableCodeObjectType: String) -> Bool {
        switch machineReadableCodeObjectType {
        case AVMetadataObjectTypeQRCode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeAztecCode:
            return true
        default:
            guard let generator = codeGeneratorForMachineReadableCodeObjectType(machineReadableCodeObjectType) else {
                return false
            }
            return generator.isValid(contents)
        }
    }
    
    private func codeGeneratorForMachineReadableCodeObjectType(machineReadableCodeObjectType: String) -> RSAbstractCodeGenerator? {
        switch machineReadableCodeObjectType {
        case AVMetadataObjectTypeCode39Code:
            return RSCode39Generator()
        case AVMetadataObjectTypeCode39Mod43Code:
            return RSCode39Mod43Generator()
        case AVMetadataObjectTypeEAN8Code:
            return RSEAN8Generator()
        case AVMetadataObjectTypeEAN13Code:
            return RSEAN13Generator()
        case AVMetadataObjectTypeInterleaved2of5Code:
            return RSITFGenerator()
        case AVMetadataObjectTypeITF14Code:
            return RSITF14Generator()
        case AVMetadataObjectTypeUPCECode:
            return RSUPCEGenerator()
        case AVMetadataObjectTypeCode93Code:
            return RSCode93Generator()
        case AVMetadataObjectTypeCode128Code:
            return RSCode128Generator()
        case RSBarcodesTypeISBN13Code:
            return RSISBN13Generator()
        case RSBarcodesTypeISSN13Code:
            return RSISSN13Generator()
        case RSBarcodesTypeExtendedCode39Code:
            return RSExtendedCode39Generator()
        default:
            return nil
        }
    }
}

let UnifiedCodeGeneratorSharedInstance = RSUnifiedCodeGenerator()
