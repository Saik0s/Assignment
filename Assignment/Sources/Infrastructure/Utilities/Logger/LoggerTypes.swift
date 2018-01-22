//
// LoggerTypes.swift
//
// Created by Igor Tarasenko
//

import Foundation

extension Logger {
    private static let defaultOptions: [FormatOption] = [FormatOption](
            arrayLiteral: .date("yyyy-MM-dd HH:mm:ss.SSS"),
            .space,
            .file,
            .string(":"),
            .line,
            .space,
            .function,
            .space,
            .isMain,
            .space,
            .level,
            .string(": "),
            .message,
            .wholeTextColorize
    )

    private static let minimalOptions: [FormatOption] = [FormatOption](
            arrayLiteral: .date("HH:mm:ss.SSS"),
            .space,
            .file,
            .string(":"),
            .line,
            .space,
            .function,
            .string(": "),
            .message,
            .wholeTextColorize
    )

    public enum OutputType {
        case console
        case file(path: String)
        case custom(closure: (String) -> Void)
    }

    public enum Level: Int {
        case trace = 0
        case reflect = 1
        case debug = 2
        case info = 3
        case warning = 4
        case error = 5
    }

    public enum FormatOption {
        case date(String)
        case file
        case column
        case function
        case line
        case isMain
        case level
        case shortLevel
        case message
        case string(String)
        case space
        case wholeTextColorize
        case colorStart
        case colorEnd
    }

    public enum Style {
        case `default`
        case minimal
        case custom(options: [FormatOption])

        var formatOptions: [FormatOption] {
            switch self {
                case .default:
                    return defaultOptions
                case .minimal:
                    return minimalOptions
                case let .custom(options):
                    return options
            }
        }
    }
}

extension Logger.Level: CustomStringConvertible {
    public var description: String {
        switch self {
            case .trace:
                return "TRACE"
            case .reflect:
                return "REFLECT"
            case .debug:
                return "DEBUG"
            case .info:
                return "INFO"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
        }
    }

    public var color: String {
        switch self {
            case .trace:
                return "\u{001B}[38;5;35m"
            case .reflect:
                return "\u{001B}[38;5;36m"
            case .debug:
                return "\u{001B}[38;5;35m"
            case .info:
                return "\u{001B}[38;5;248m"
            case .warning:
                return "\u{001B}[38;5;220m"
            case .error:
                return "\u{001B}[38;5;196m"
        }
    }

    public static var colorBreak: String {
        return "\u{001B}[0m"
    }
}

extension Logger.Level: Equatable {
    public static func ==(lhs: Logger.Level, rhs: Logger.Level) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public func isSameOrHigher(than level: Logger.Level) -> Bool {
        return rawValue >= level.rawValue
    }
}

extension Sequence where Element == Logger.FormatOption {
    func simplified(using info: Logger.Info) -> [Logger.FormatOption] {
        return map {
            switch $0 {
                case .space: return .string(" ")
                case .level: return .string(info.level.description)
                case .shortLevel: return .string(
                        String(info.level.description.characters.first ?? Character(""))
                )
                case .file: return .string(info.file.fileURL?.lastPathComponent ?? "")
                case .column: return .string("\(info.column)")
                case .function: return .string(info.function)
                case .line: return .string("\(info.line)")
                case .isMain: return .string(info.isMainThread ? "Main" : "Not Main")
                default: return $0
            }
        }
    }
}

extension Logger.FormatOption: Equatable {
    public static func ==(
            lhs: Logger.FormatOption,
            rhs: Logger.FormatOption
    ) -> Bool {
        switch (lhs, rhs) {
            case let (.date(lhs), .date(rhs)):
                return lhs == rhs
            case (.file, .file):
                return true
            case (.column, .column):
                return true
            case (.function, .function):
                return true
            case (.line, .line):
                return true
            case (.isMain, .isMain):
                return true
            case (.level, .level):
                return true
            case (.shortLevel, .shortLevel):
                return true
            case (.message, .message):
                return true
            case let (.string(lhs), .string(rhs)):
                return lhs == rhs
            case (.space, .space):
                return true
            case (.wholeTextColorize, .wholeTextColorize):
                return true
            case (.colorStart, .colorStart):
                return true
            case (.colorEnd, .colorEnd):
                return true
            default: return false
        }
    }
}
