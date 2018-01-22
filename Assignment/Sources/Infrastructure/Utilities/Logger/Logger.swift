//
// Logger.swift
//
// Created by Igor Tarasenko
// Copyright (c) 2017 Igor Tarasenko. All rights reserved.
//

import Foundation

public struct Logger {
    struct Info {
        let level: Level
        let file: String
        let line: Int
        let column: Int
        let function: String
        let isMainThread: Bool
    }

    public static var isEnabled: Bool = true
    public static var isColored: Bool = true
    public static var minLevel: Level = .trace
    public static var destinations: [OutputType] = [.console, .file(path: "/tmp/swift_logger.log")]
    public static var style: Style = .default
    public static var excludedFiles: [String] = []
    private static var fileStream: OutputStream?
    private static var lastFileStreamPath: String = ""

    /**
     Constructs message using current style
     */
    static func constructMessage(for element: () -> Any?, using info: Info) {
        guard let fileName: String = info.file.fileURL?.lastPathComponent,
              isEnabled,
              info.level.isSameOrHigher(than: minLevel),
              !excludedFiles.contains(fileName)
        else { return }

        var message: String = style.formatOptions
                .simplified(using: info)
                .reduce("") { (result: String, option: FormatOption) -> String in
                    var tmpResult: String = ""
                    switch option {
                        case let .date(format):
                            let df = DateFormatter()
                            df.dateFormat = format
                            tmpResult += df.string(from: Date())
                        case .message:
                            getString(from: element()) { str in
                                tmpResult += str
                            }
                        case .colorStart:
                            tmpResult += isColored ?
                                    info.level.color : ""
                        case .colorEnd:
                            tmpResult += isColored ?
                                    Logger.Level.colorBreak : ""
                        case let .string(str):
                            tmpResult += str
                        default:
                            ()
                    }
                    return result + tmpResult
                }
        if style.formatOptions.contains(where: { $0 == .wholeTextColorize }) {
            message = info.level.color + message + Logger.Level.colorBreak
        }
        send(message, withLevel: info.level)
    }

    /**
     Converts input to string
     */
    private static func getString(
            from element: Any?,
            _ handler: (String) -> Void
    ) {
        element.ifSome {
            switch $0 {
                case let some as [Any]:
                    handler(some.map {
                        String(describing: $0)
                    }.joined(separator: " "))
                case let some as String:
                    handler(some)
                default:
                    handler(String(describing: $0))
            }
        }.ifNone {
            handler("nil")
        }
    }

    /**
     Sends constructed message to correct streams
     */
    private static func send(_ message: String, withLevel level: Level) {
        guard isEnabled && level.rawValue >= minLevel.rawValue
        else { return }
        for dest in destinations {
            switch dest {
                case let .custom(closure):
                    closure(message)
                case .console:
                    Swift.print(message)
                case let .file(path):
#if (arch(i386) || arch(x86_64)) && os(iOS)
                    guard let fStream = fileStream
                    else { break }
                    if lastFileStreamPath != path {
                        lastFileStreamPath = path
                        fileStream?.close()
                        fileStream = OutputStream(
                                toFileAtPath: path,
                                append: true
                        )
                        fileStream?.open()
                    }
                    _ = fStream.writeString(message + "\n")
#endif
            }
        }
    }

    /**
     Call to print debug message
     */
    public static func debug(
            _ element: @autoclosure @escaping () -> Any?,
            _ file: String = #file,
            _ line: Int = #line,
            _ column: Int = #column,
            _ function: String = #function,
            _ isMainThread: Bool = Thread.current.isMainThread
    ) {
        constructMessage(
                for: element,
                using: Info(
                        level: .debug,
                        file: file,
                        line: line,
                        column: column,
                        function: function,
                        isMainThread: isMainThread
                )
        )
    }

    /**
     Call to print info message
     */
    public static func info(
            _ element: @autoclosure @escaping () -> Any?,
            _ file: String = #file,
            _ line: Int = #line,
            _ column: Int = #column,
            _ function: String = #function,
            _ isMainThread: Bool = Thread.current.isMainThread
    ) {
        constructMessage(
                for: element,
                using: Info(
                        level: .info,
                        file: file,
                        line: line,
                        column: column,
                        function: function,
                        isMainThread: isMainThread
                )
        )
    }

    /**
     Call to print warning message
     */
    public static func warning(
            _ element: @autoclosure @escaping () -> Any?,
            _ file: String = #file,
            _ line: Int = #line,
            _ column: Int = #column,
            _ function: String = #function,
            _ isMainThread: Bool = Thread.current.isMainThread
    ) {
        constructMessage(
                for: element,
                using: Info(
                        level: .warning,
                        file: file,
                        line: line,
                        column: column,
                        function: function,
                        isMainThread: isMainThread
                )
        )
    }

    /**
     Call to print error message
     */
    public static func error(
            _ element: @autoclosure @escaping () -> Any?,
            _ file: String = #file,
            _ line: Int = #line,
            _ column: Int = #column,
            _ function: String = #function,
            _ isMainThread: Bool = Thread.current.isMainThread
    ) {
        constructMessage(
                for: element,
                using: Info(
                        level: .error,
                        file: file,
                        line: line,
                        column: column,
                        function: function,
                        isMainThread: isMainThread
                )
        )
    }

    /**
     Call to print call stack for current line
     */
    public static func trace() {
        let message = Thread.callStackSymbols.reduce("") {
            "\($0)\n\($1)"
        }
        send(message, withLevel: .trace)
    }
}

/**
 Shadowing of Swift.print function
 */
public func print(
        _ items: Any?...,
        separator _: String = " ",
        terminator _: String = "\n"
) {
    Logger.constructMessage(
            for: { items },
            using: Logger.Info(
                    level: .info,
                    file: "",
                    line: 0,
                    column: 0,
                    function: "",
                    isMainThread: true
            )
    )
}

/**
 Shadowing of Swift.debugPrint function
 */
public func debugPrint(
        _ items: Any?...,
        separator _: String = " ",
        terminator _: String = "\n"
) {
    Logger.constructMessage(
            for: { items },
            using: Logger.Info(
                    level: .info,
                    file: "",
                    line: 0,
                    column: 0,
                    function: "",
                    isMainThread: true
            )
    )
}
