protocol Handler: AnyObject {
    var next: Handler? { get set }
    func handle(request: String) -> String?
}

extension Handler {
    func next(request: String) -> String? {
        return next?.handle(request: request)
    }
}

class AuthorizationHandler: Handler {
    var next: Handler?
    
    func handle(request: String) -> String? {
        if request == "Authorization" {
            print("Authorization is handled.")
            return "Authorization is successful."
        } else {
            print("Authorization not handled -> Next")
            return next(request: request)
        }
    }
}

class ValidationHandler: Handler {
    var next: Handler?
    
    func handle(request: String) -> String? {
        if request == "Validation" {
            print("Validation is handled.")
            return "Validation is successful."
        } else {
            print("Validation not handled -> Next")
            return next(request: request)
        }
    }
}

class LoggingHandler: Handler {
    var next: Handler?
    
    func handle(request: String) -> String? {
        print("Logging request: \(request)")
        return next(request: request) ?? "Request is finished in LoggingHandler."
    }
}

class Client {
    func setupChain() -> Handler {
        let authorization = AuthorizationHandler()
        let validation = ValidationHandler()
        let logging = LoggingHandler()
        
        authorization.next = validation
        validation.next = logging
        
        return authorization
    }
    
    func sendRequest(request: String) {
        let chain = setupChain()
        if let result = chain.handle(request: request) {
            print("Result: \(result)")
        } else {
            print("No handler could handle the request: \(request)")
        }
    }
}

let client = Client()
client.sendRequest(request: "Validation")
client.sendRequest(request: "Logging")
client.sendRequest(request: "Authorization")
