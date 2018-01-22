//
// String.swift
//
// Created by Igor Tarasenko
//

import Foundation

// TODO: Check https://github.com/noremac/Textile/tree/master/Textile/Source
/**
 Sugar for working with path like strings
 */
extension String {
    public var url: URL? {
        return URL(string: self)
    }

    public var fileURL: URL? {
        return URL(fileURLWithPath: self)
    }

    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }

    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

/**
 * Transform string to NSMutableAttributedString
 */
extension String {
    public var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}
