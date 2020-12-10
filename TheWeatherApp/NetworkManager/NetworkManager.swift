//
//  NetworkManager.swift
//  TheWeatherApp
//
//  Created by OSE on 12/10/20.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftMessages

public enum RequestCallback<T> {
    case success(T)
    case failed(AppError)
}

public struct RequestCompletionBlock<T : Mappable> {
    public typealias CompletionResponseArray = (_ result: RequestCallback<[T]>) -> Void
    public typealias CompletionResponse = (_ result: RequestCallback<T>) -> Void
}

public enum ServiceError: Error {
    case parsingError
}

public enum AppError: Error {
    case gernalErrorAndCode(code: StatusCode, message: String)
    case gernalError(message: String)
    case ignoreError(message: String)
    case permissionDenied(message: String)
    case genericError(obj: Any)
}
struct APIMessageType: OptionSet {

    let rawValue: Int

    static let none = APIMessageType(rawValue: 1)
    static let errorMessage = APIMessageType(rawValue: 2)
    static let successMessage = APIMessageType(rawValue: 4)
    static let allMessage: APIMessageType = [.errorMessage, .successMessage]

}
public enum StatusCode: Int {
    case success = 200
    case empty = 201
    case error = 203

    public var errorMessage: String {

        var string = ""
        switch self {
            case .success:
                string = "Success"
            case .empty:
                string = "Error"
            case .error:
                string = "Error"
        }
        return string
    }
}

struct AlamofireManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 2000
        let sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
        return sessionManager
    }()
}
