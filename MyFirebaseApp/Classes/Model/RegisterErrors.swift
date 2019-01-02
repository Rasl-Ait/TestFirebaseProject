//
//  CustomErrors.swift
//  VKApp
//
//  Created by rasl on 28.12.2018.
//  Copyright © 2018 rasl. All rights reserved.
//

import Foundation

/// better use own that alamofire one
enum RegisterResult<Value> {
	case success(Value)
	case failure(Error)
}

/// can be created ApiErrors and etc.
enum RegisterErrors {
	case invalidEmail
	case unknownError
	case serverError
}

extension RegisterErrors: LocalizedError {
	/// can be created extension for String
	/// errorDescription is used in Error.localizedDescription
	var errorDescription: String? {
		switch self {
		case .invalidEmail:
			return NSLocalizedString("email_is_not_valid", comment: "")
		case .unknownError:
			/// we will use server_error key to display user internal error
			return NSLocalizedString("server_error", comment: "")
		case .serverError:
			return NSLocalizedString("server_error", comment: "")
		}
	}
}
