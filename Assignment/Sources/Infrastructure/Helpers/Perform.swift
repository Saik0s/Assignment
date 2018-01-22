/**
 *  Perform a throwing expression, and throw a custom error in case the expression threw
 *
 *  - parameter expression: The expression to execute
 *  - parameter error: The custom error to throw instead of the expression's error
 *  - throws: The given error
 *  - returns: The return value of the given expression
 */
public func perform<T>(
        _ expression: @autoclosure () throws -> T,
        orThrow error: Error
) throws -> T {
    do {
        return try expression()
    }
    catch {
        throw error
    }
}
