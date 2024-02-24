//
//  AppError.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 24/02/2024.
//

import Foundation

enum AppError: String, Error {
    case invalidRequest = "Invalid request. Please try again"
    case invalidCompletion = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid server response. Please try again later."
    case invalidData = "Data received is invalid. Please try again."
}
