//
//  Environment.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//


import Foundation
import ObjectMapper
import Alamofire
import SwiftMessages


class CoreWebService: NSObject {

    static func sendRequest<T: Mappable>(
        requestURL: String, method: HTTPMethod = .post,
        paramters: [String: Any]? = nil,
        isRefreshToken:Bool = false,
        headers: HTTPHeaders? = nil,
        mapContext: MapContext? = nil,
        showMessageType: APIMessageType = .allMessage,
        callBack: RequestCompletionBlock<T>.CompletionResponse?) {

        //Checking if exist from local memory
        guard let completeUrl = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                Commons.hideActivityIndicator()
                return
        }
        //Checking if exist from local memory
        URLCache.shared.removeAllCachedResponses()
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }

        guard let url = URL(string: completeUrl) else {
            Commons.hideActivityIndicator()
            // incorporate error
            return
        }
        var encoding: ParameterEncoding = JSONEncoding.prettyPrinted
        if method == .get {
            encoding = URLEncoding.methodDependent
        }
        let requestModel = AlamofireManager.shared.request(url, method: method, parameters: paramters, encoding: encoding)


        requestModel.responseData { (responseData: DataResponse<Data>) in
            CoreWebService.parseResponse(data: responseData.data, error: responseData.error, mapContext: mapContext, showMessageType: showMessageType, callBack: callBack)
        }
    }

    static func parseResponse<T: Mappable>(
        data: Data?, error: Error? = nil,
        mapContext: MapContext? = nil,
        showMessageType: APIMessageType,
        callBack: RequestCompletionBlock<T>.CompletionResponse?) {

        guard let data = data else {
            return
        }

        if let dict = data.toDictionary() {
            let statusCode = dict["cod"] as? Int ?? StatusCode.success.rawValue
            let errorMessage = dict["message"] as? String ?? ""

            if let code = StatusCode(rawValue: statusCode),code == .success{

                let mapper = Mapper<T>()
                mapper.context = mapContext
                let mapperClass = mapper.map(JSON: dict)!

                if code == .success {
                    callBack?(.success(mapperClass))
                } else {
                    callBack?(RequestCallback.failed(AppError.gernalErrorAndCode(code: code, message: "error")))
                }
            } else { //case to handle when status code don't macth
                callBack?(.failed(AppError.gernalError(message: errorMessage)))
            }
        } else {
            if let error = error {
                callBack?(.failed(AppError.gernalError(message: error.localizedDescription)))
                return
            }
            callBack?(.failed(AppError.gernalError(message: "")))
        }
    }






}
