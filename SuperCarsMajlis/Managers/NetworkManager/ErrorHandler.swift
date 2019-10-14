
import UIKit
import Foundation
import Alamofire

func handleError(response: DataResponse<Any>?) -> (WebServiceResponseType, Int, String, DataResponse<Any>?)
{
    if response?.response == nil {
        return (.Failure, kSomethingWentWrongErrorCode, "SOMETHING WENT WRONG", response)
    }else{
        if response!.result.isSuccess{
            if let responseDict = response!.result.value as? NSDictionary{
                if let statusCode = responseDict.value(forKey: "error") as? Int{
                    let message = responseDict.value(forKey: "error_text") as! String
                    if statusCode == 0{
                        return (.Success, statusCode, message, response)
                    }else{
                        return (.Failure, statusCode, message, response)
                    }
                }else{
                    return (.Failure, kSomethingWentWrongErrorCode, "SOMETHING WENT WRONG", response)
                }
            }else{
                return (.Failure, kSomethingWentWrongErrorCode, "SOMETHING WENT WRONG", response)
            }
        }else if response!.result.isFailure{
            return (.Failure, kServerTimeOut, "SERVER TIME OUT", response)
        }else{
            return (.Failure, kSomethingWentWrongErrorCode, "SOMETHING WENT WRONG", response)
        }
    }
}
 
