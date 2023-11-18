//
//  APIClientError.swift
//  Gourmet_Search_App
//
//  Created by Nakano Haru on 2023/11/18.
//

import Foundation

enum APIClientError: Error {
    ///URLが無効
    case invalidURL
    /// パースに失敗
    case parseError
    /// ステータスコードエラー
    case apiResponseError(APIResponseError)
    /// URLSessionでのエラー
    case urlSessionError(URLSessionError)
}

enum APIResponseError: Error {
    ///サーバ障害エラー
    case serverError
    ///APIキーまたはIPアドレスの認証エラー
    case APICertificationError
    ///パラメータ不正エラー
    case InValidParameterError
    ///それ以外のエラー
    case undefined(statusCode: Int?)
}

enum URLSessionError: Error {
    /// ネットワークエラー
    case networkError
    /// 型不明のエラー
    case unknown(Error)
}
