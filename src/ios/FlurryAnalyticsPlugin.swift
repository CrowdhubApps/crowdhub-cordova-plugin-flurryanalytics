import Foundation
import Flurry_iOS_SDK

@objc(FlurryAnalytics)
class FlurryAnalytics : CDVPlugin {

    // Initialize: https://developer.yahoo.com/flurry/docs/integrateflurry/ios/#swift
    @objc(initialize:) func initialize(command : CDVInvokedUrlCommand) {

        guard let apiKey = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a Flurry API Key"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let logLevelArg = command.arguments[1] as? String

        var logLevel = FlurryLogLevel.none

        switch logLevelArg?.lowercased() {
        case "verbose":
            logLevel = FlurryLogLevel.all
        case "debug":
            logLevel = FlurryLogLevel.debug
        case "info":
            logLevel = FlurryLogLevel.debug
        case "warn":
            logLevel = FlurryLogLevel.criticalOnly
        case "error":
            logLevel = FlurryLogLevel.criticalOnly
        case .none:
            logLevel = FlurryLogLevel.none
        case .some:
            logLevel = FlurryLogLevel.none
        }
        
        let crashReportingEnabled = command.arguments[2] as? Bool ?? true
        let appVersion = command.arguments[3] as? String ?? "1.0"
        let iapReportingEnabled = command.arguments[4] as? Bool ?? true

        let sb = FlurrySessionBuilder()
            .build(logLevel: logLevel)
            .build(crashReportingEnabled: crashReportingEnabled)
            .build(appVersion: appVersion)
            .build(iapReportingEnabled: iapReportingEnabled)
        DispatchQueue.main.async {
            Flurry.startSession(apiKey: apiKey, sessionBuilder: sb)
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAs:"Flurry session started"
                ),
                callbackId: command.callbackId)
        }
    }

    // StandardEvents: https://developer.yahoo.com/flurry/docs/analytics/standard_events/iOS/
    @objc(logContentRated:) func logContentRated(command : CDVInvokedUrlCommand) {
        // required
        guard let contentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a content ID"
                ),
                callbackId: command.callbackId)
            return
        }
        
        guard let contentRating = command.arguments[1] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a content rating"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(stringVal: contentId, param: FlurryParamBuilder.contentId())
            .set(stringVal: contentRating, param: FlurryParamBuilder.rating())
        // recommended
        if let contentName = command.arguments[2] as? String {param.set(stringVal: contentName, param: FlurryParamBuilder.contentName())}
        if let contentType = command.arguments[3] as? String {param.set(stringVal: contentType, param: FlurryParamBuilder.contentType())}
        Flurry.log(standardEvent: FlurryEvent.contentRated, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged content rated"
            ),
            callbackId: command.callbackId)
    }

    @objc(logContentViewed:) func logContentViewed(command : CDVInvokedUrlCommand) {
        // required
        guard let contentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a content ID"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(stringVal: contentId, param: FlurryParamBuilder.contentId())
        // recommended
        if let contentName = command.arguments[1] as? String {param.set(stringVal: contentName, param: FlurryParamBuilder.contentName())}
        if let contentType = command.arguments[2] as? String {param.set(stringVal: contentType, param: FlurryParamBuilder.contentType())}

        Flurry.log(standardEvent: FlurryEvent.contentViewed, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged content viewed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logContentSaved:) func logContentSaved(command : CDVInvokedUrlCommand) {
        // required
        guard let contentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a content ID"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(stringVal: contentId, param: FlurryParamBuilder.contentId())
        // recommended
        if let contentName = command.arguments[1] as? String {param.set(stringVal: contentName, param: FlurryParamBuilder.contentName())}
        if let contentType = command.arguments[2] as? String {param.set(stringVal: contentType, param: FlurryParamBuilder.contentType())}

        Flurry.log(standardEvent: FlurryEvent.contentSaved, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged content saved"
            ),
            callbackId: command.callbackId)
    }

    @objc(logProductCustomized:) func logProductCustomized(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
            .set(stringVal: "Product customized", param: FlurryStringParam())
        Flurry.log(standardEvent: FlurryEvent.productCustomized, param: param)
    }

    @objc(logSubscriptionStarted:) func logSubscriptionStarted(command : CDVInvokedUrlCommand) {
        // required
        guard let price = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        guard let isAnnualSubscription = command.arguments[1] as? Bool else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must define whether the subscription is annual or not"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(doubleVal: price, param: FlurryParamBuilder.price())
            .set(booleanVal: isAnnualSubscription, param: FlurryParamBuilder.isAnnualSubscription())
        
        // recommended
        if let trialDays = command.arguments[2] as? Int {param.set(integerVal: Int32(trialDays), param: FlurryParamBuilder.trialDays())}
        if let predictedLTV = command.arguments[3] as? String {param.set(stringVal: predictedLTV, param: FlurryParamBuilder.predictedLTV())}
        if let currencyType = command.arguments[4] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}
        if let subscriptionCountry = command.arguments[5] as? String {param.set(stringVal: subscriptionCountry, param: FlurryParamBuilder.subscriptionCountry())}

        Flurry.log(standardEvent: FlurryEvent.subscriptionStarted, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged subscription started"
            ),
            callbackId: command.callbackId)
    }

    @objc(logSubscriptionEnded:) func logSubscriptionEnded(command : CDVInvokedUrlCommand) {
        // required
        guard let isAnnualSubscription = command.arguments[0] as? Bool else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must define whether the subscription is annual or not"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(booleanVal: isAnnualSubscription, param: FlurryParamBuilder.isAnnualSubscription())
        // recommended
        if let currencyType = command.arguments[1] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}
        if let subscriptionCountry = command.arguments[2] as? String {param.set(stringVal: subscriptionCountry, param: FlurryParamBuilder.subscriptionCountry())}

        Flurry.log(standardEvent: FlurryEvent.subscriptionEnded, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged subscription ended"
            ),
            callbackId: command.callbackId)
    }

    @objc(logGroupJoined:) func logGroupJoined(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let groupName = command.arguments[0] as? String {param.set(stringVal: groupName, param: FlurryParamBuilder.groupName())}

        Flurry.log(standardEvent: FlurryEvent.groupJoined, param: param)
    }

    @objc(logGroupLeft:) func logGroupLeft(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let groupName = command.arguments[0] as? String {param.set(stringVal: groupName, param: FlurryParamBuilder.groupName())}

        Flurry.log(standardEvent: FlurryEvent.groupLeft, param: param)
    }

    @objc(logLogin:) func logLogin(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let userId = command.arguments[0] as? String {param.set(stringVal: userId, param: FlurryParamBuilder.userId())}
        if let method = command.arguments[1] as? String {param.set(stringVal: method, param: FlurryParamBuilder.method())}

        Flurry.log(standardEvent: FlurryEvent.login, param: param)
    }
    @objc(logLogout:) func logLogout(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let userId = command.arguments[0] as? String {param.set(stringVal: userId, param: FlurryParamBuilder.userId())}
        if let method = command.arguments[1] as? String {param.set(stringVal: method, param: FlurryParamBuilder.method())}
        
        Flurry.log(standardEvent: FlurryEvent.logout, param: param)
    }
    @objc(logUserRegistered:) func logUserRegistered(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let userId = command.arguments[0] as? String {param.set(stringVal: userId, param: FlurryParamBuilder.userId())}
        if let method = command.arguments[1] as? String {param.set(stringVal: method, param: FlurryParamBuilder.method())}
        
        Flurry.log(standardEvent: FlurryEvent.userRegistered, param: param)
    }

    @objc(logSearchResultViewed:) func logSearchResultViewed(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let query = command.arguments[0] as? String {param.set(stringVal: query, param: FlurryParamBuilder.query())}
        if let searchType = command.arguments[1] as? String {param.set(stringVal: searchType, param: FlurryParamBuilder.searchType())}

        Flurry.log(standardEvent: FlurryEvent.searchResultViewed, param: param)
    }

    @objc(logKeywordSearched:) func logKeywordSearched(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let query = command.arguments[0] as? String {param.set(stringVal: query, param: FlurryParamBuilder.query())}
        if let searchType = command.arguments[1] as? String {param.set(stringVal: searchType, param: FlurryParamBuilder.searchType())}

        Flurry.log(standardEvent: FlurryEvent.keywordSearched, param: param)
    }

    @objc(logLocationSearched:) func logLocationSearched(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let query = command.arguments[0] as? String {param.set(stringVal: query, param: FlurryParamBuilder.query())}

        Flurry.log(standardEvent: FlurryEvent.locationSearched, param: param)
    }

    @objc(logInvite:) func logInvite(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let userId = command.arguments[0] as? String {param.set(stringVal: userId, param: FlurryParamBuilder.userId())}
        if let method = command.arguments[1] as? String {param.set(stringVal: method, param: FlurryParamBuilder.method())}
        
        Flurry.log(standardEvent: FlurryEvent.invite, param: param)
    }

    @objc(logShare:) func logShare(command : CDVInvokedUrlCommand) {
        guard let socialContentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a social content ID"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(stringVal: socialContentId, param: FlurryParamBuilder.socialContentId())

        if let socialContentName = command.arguments[1] as? String {param.set(stringVal: socialContentName, param: FlurryParamBuilder.socialContentName())}
        if let method = command.arguments[2] as? String {param.set(stringVal: method, param: FlurryParamBuilder.method())}

        Flurry.log(standardEvent: FlurryEvent.share, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged share"
            ),
            callbackId: command.callbackId)
    }
    
    @objc(logLike:) func logLike(command : CDVInvokedUrlCommand) {
        guard let socialContentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a social content ID"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(stringVal: socialContentId, param: FlurryParamBuilder.socialContentId())

        if let socialContentName = command.arguments[1] as? String {param.set(stringVal: socialContentName, param: FlurryParamBuilder.socialContentName())}
        if let likeType = command.arguments[2] as? String {param.set(stringVal: likeType, param: FlurryParamBuilder.likeType())}

        Flurry.log(standardEvent: FlurryEvent.like, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged like"
            ),
            callbackId: command.callbackId)
    }
    
    @objc(logComment:) func logComment(command : CDVInvokedUrlCommand) {
        guard let socialContentId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a social content ID"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(stringVal: socialContentId, param: FlurryParamBuilder.socialContentId())

        if let socialContentName = command.arguments[1] as? String {param.set(stringVal: socialContentName, param: FlurryParamBuilder.socialContentName())}

        Flurry.log(standardEvent: FlurryEvent.comment, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged comment"
            ),
            callbackId: command.callbackId)
    }

    @objc(logMediaCaptured:) func logMediaCaptured(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let mediaId = command.arguments[0] as? String {param.set(stringVal: mediaId, param: FlurryParamBuilder.mediaId())}
        if let mediaName = command.arguments[1] as? String {param.set(stringVal: mediaName, param: FlurryParamBuilder.mediaName())}
        if let mediaType = command.arguments[2] as? String {param.set(stringVal: mediaType, param: FlurryParamBuilder.mediaType())}

        Flurry.log(standardEvent: FlurryEvent.mediaCaptured, param: param)
    }

    @objc(logMediaStarted:) func logMediaStarted(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let mediaId = command.arguments[0] as? String {param.set(stringVal: mediaId, param: FlurryParamBuilder.mediaId())}
        if let mediaName = command.arguments[1] as? String {param.set(stringVal: mediaName, param: FlurryParamBuilder.mediaName())}
        if let mediaType = command.arguments[2] as? String {param.set(stringVal: mediaType, param: FlurryParamBuilder.mediaType())}

        Flurry.log(standardEvent: FlurryEvent.mediaStarted, param: param)
    }

    @objc(logMediaStopped:) func logMediaStopped(command : CDVInvokedUrlCommand) {
        guard let duration = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a duration"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder().set(integerVal: Int32(duration), param: FlurryParamBuilder.duration())
        if let mediaId = command.arguments[1] as? String {param.set(stringVal: mediaId, param: FlurryParamBuilder.mediaId())}
        if let mediaName = command.arguments[2] as? String {param.set(stringVal: mediaName, param: FlurryParamBuilder.mediaName())}
        if let mediaType = command.arguments[3] as? String {param.set(stringVal: mediaType, param: FlurryParamBuilder.mediaType())}

        Flurry.log(standardEvent: FlurryEvent.mediaStopped, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged media stopped"
            ),
            callbackId: command.callbackId)
    }

    @objc(logMediaPaused:) func logMediaPaused(command : CDVInvokedUrlCommand) {
        guard let duration = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a duration"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder().set(integerVal: Int32(duration), param: FlurryParamBuilder.duration())
        if let mediaId = command.arguments[1] as? String {param.set(stringVal: mediaId, param: FlurryParamBuilder.mediaId())}
        if let mediaName = command.arguments[2] as? String {param.set(stringVal: mediaName, param: FlurryParamBuilder.mediaName())}
        if let mediaType = command.arguments[3] as? String {param.set(stringVal: mediaType, param: FlurryParamBuilder.mediaType())}

        Flurry.log(standardEvent: FlurryEvent.mediaPaused, param: param)

        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged media paused"
            ),
            callbackId: command.callbackId)
    }

    // Custom Events: https://developer.yahoo.com/flurry/docs/analytics/gettingstarted/events/ios/
    @objc(logCustomEvent:) func logCustomEvent(command : CDVInvokedUrlCommand) {
        guard let eventName = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an event name"
                ),
                callbackId: command.callbackId)
            return
        }
        let eventParams = command.arguments[1] as? [AnyHashable:Any] ?? [:]
        let eventTimed = command.arguments[2] as? Bool ?? false
        Flurry.log(eventName: eventName, parameters: eventParams, timed: eventTimed)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged custom event"
            ),
            callbackId: command.callbackId)
    }

    @objc(endTimedEvent:) func endTimedEvent(command : CDVInvokedUrlCommand) {
        guard let eventName = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an event name"
                ),
                callbackId: command.callbackId)
            return
        }

        Flurry.endTimedEvent(eventName: eventName, parameters: nil)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged custom event"
            ),
            callbackId: command.callbackId)
    }

    // Advanced Features: https://developer.yahoo.com/flurry/docs/analytics/gettingstarted/technicalquickstart/ios/
    @objc(setUserId:) func setUserId(command : CDVInvokedUrlCommand) {
        guard let userId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a user ID"
                ),
                callbackId: command.callbackId)
            return
        }

        Flurry.set(userId: userId)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged set user ID"
            ),
            callbackId: command.callbackId)
    }

    @objc(setAge:) func setAge(command : CDVInvokedUrlCommand) {
        guard let userAge = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a user age"
                ),
                callbackId: command.callbackId)
            return
        }

        Flurry.set(age: Int32(userAge))
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged set age"
            ),
            callbackId: command.callbackId)
    }

    @objc(setGender:) func setGender(command : CDVInvokedUrlCommand) {
        guard let userGender = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a user gender"
                ),
                callbackId: command.callbackId)
            return
        }

        Flurry.set(gender: userGender)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged set gender"
            ),
            callbackId: command.callbackId)
    }

    @objc(logError:) func logError(command : CDVInvokedUrlCommand) {
        let errorId = command.arguments[0] as? String ?? "0"
        let errorMessage = command.arguments[1] as? String ?? "An error occurred"
        Flurry.log(errorId: errorId, message: errorMessage, error: "Oh no!" as? any Error)
    }

    @objc(logAdClick:) func logAdClick(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()

        if let adType = command.arguments[0] as? String {
            param.set(stringVal: adType, param: FlurryParamBuilder.adType())
        }

        Flurry.log(standardEvent: FlurryEvent.adClick, param: param)
    }

    @objc(logAdImpression:) func logAdImpression(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()

        if let adType = command.arguments[0] as? String {
            param.set(stringVal: adType, param: FlurryParamBuilder.adType())
        }

        Flurry.log(standardEvent: FlurryEvent.adImpression, param: param)
    }

    @objc(logAdRewarded:) func logAdRewarded(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()

        if let adType = command.arguments[0] as? String {
            param.set(stringVal: adType, param: FlurryParamBuilder.adType())
        }

        Flurry.log(standardEvent: FlurryEvent.adRewarded, param: param)
    }

    @objc(logAdSkipped:) func logAdSkipped(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()

        if let adType = command.arguments[0] as? String {
            param.set(stringVal: adType, param: FlurryParamBuilder.adType())
        }

        Flurry.log(standardEvent: FlurryEvent.adSkipped, param: param)
    }

    @objc(logCreditsSpent:) func logCreditsSpent(command : CDVInvokedUrlCommand) {
        guard let totalAmount = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())

        if let levelNumber = command.arguments[1] as? Int {
            param.set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        }
        if let isCurrencySoft = command.arguments[2] as? Bool {
            param.set(booleanVal: isCurrencySoft, param: FlurryParamBuilder.isCurrencySoft())
        }
        if let creditType = command.arguments[3] as? String {
            param.set(stringVal: creditType, param: FlurryParamBuilder.creditType())
        }
        if let creditId = command.arguments[4] as? String {
            param.set(stringVal: creditId, param: FlurryParamBuilder.creditId())
        }
        if let creditName = command.arguments[5] as? String {
            param.set(stringVal: creditName, param: FlurryParamBuilder.creditName())
        }
        if let currencyType = command.arguments[6] as? String {
            param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())
        }

        Flurry.log(standardEvent: FlurryEvent.creditsSpent, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged credits spent"
            ),
            callbackId: command.callbackId)
    }

    @objc(logCreditsPurchased:) func logCreditsPurchased(command : CDVInvokedUrlCommand) {

        guard let totalAmount = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())

        if let levelNumber = command.arguments[1] as? Int {
            param.set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        }
        if let isCurrencySoft = command.arguments[2] as? Bool {
            param.set(booleanVal: isCurrencySoft, param: FlurryParamBuilder.isCurrencySoft())
        }
        if let creditType = command.arguments[3] as? String {
            param.set(stringVal: creditType, param: FlurryParamBuilder.creditType())
        }
        if let creditId = command.arguments[4] as? String {
            param.set(stringVal: creditId, param: FlurryParamBuilder.creditId())
        }
        if let creditName = command.arguments[5] as? String {
            param.set(stringVal: creditName, param: FlurryParamBuilder.creditName())
        }
        if let currencyType = command.arguments[6] as? String {
            param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())
        }

        Flurry.log(standardEvent: FlurryEvent.creditsPurchased, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged credits purchased"
            ),
            callbackId: command.callbackId)
    }

    @objc(logCreditsEarned:) func logCreditsEarned(command : CDVInvokedUrlCommand) {
        guard let totalAmount = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())

        if let levelNumber = command.arguments[1] as? Int {
            param.set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        }
        if let isCurrencySoft = command.arguments[2] as? Bool {
            param.set(booleanVal: isCurrencySoft, param: FlurryParamBuilder.isCurrencySoft())
        }
        if let creditType = command.arguments[3] as? String {
            param.set(stringVal: creditType, param: FlurryParamBuilder.creditType())
        }
        if let creditId = command.arguments[4] as? String {
            param.set(stringVal: creditId, param: FlurryParamBuilder.creditId())
        }
        if let creditName = command.arguments[5] as? String {
            param.set(stringVal: creditName, param: FlurryParamBuilder.creditName())
        }
        if let currencyType = command.arguments[6] as? String {
            param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())
        }

        Flurry.log(standardEvent: FlurryEvent.creditsEarned, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged credits earned"
            ),
            callbackId: command.callbackId)
    }

    @objc(logAchievementUnlocked:) func logAchievementUnlocked(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()

        if let achievementId = command.arguments[0] as? String {param.set(stringVal: achievementId, param: FlurryParamBuilder.achievementId())}

        Flurry.log(standardEvent: FlurryEvent.achievementUnlocked, param: param)
    }

    @objc(logLevelCompleted:) func logLevelCompleted(command : CDVInvokedUrlCommand) {
        guard let levelNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a level number"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        if let levelName = command.arguments[1] as? String {
            param.set(stringVal: levelName, param: FlurryParamBuilder.levelName())
        }

        Flurry.log(standardEvent: FlurryEvent.levelCompleted, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged level completed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logLevelFailed:) func logLevelFailed(command : CDVInvokedUrlCommand) {
        guard let levelNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a level number"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        if let levelName = command.arguments[1] as? String {
            param.set(stringVal: levelName, param: FlurryParamBuilder.levelName())
        }

        Flurry.log(standardEvent: FlurryEvent.levelFailed, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged level failed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logLevelUp:) func logLevelUp(command : CDVInvokedUrlCommand) {
        guard let levelNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a level number"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        if let levelName = command.arguments[1] as? String {
            param.set(stringVal: levelName, param: FlurryParamBuilder.levelName())
        }

        Flurry.log(standardEvent: FlurryEvent.levelUp, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged level up"
            ),
            callbackId: command.callbackId)
    }

    @objc(logLevelStarted:) func logLevelStarted(command : CDVInvokedUrlCommand) {
        guard let levelNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a level number"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        if let levelName = command.arguments[1] as? String {
            param.set(stringVal: levelName, param: FlurryParamBuilder.levelName())
        }

        Flurry.log(standardEvent: FlurryEvent.levelStarted, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged level started"
            ),
            callbackId: command.callbackId)
    }

    @objc(logLevelSkip:) func logLevelSkip(command : CDVInvokedUrlCommand) {
        guard let levelNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a level number"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())
        if let levelName = command.arguments[1] as? String {
            param.set(stringVal: levelName, param: FlurryParamBuilder.levelName())
        }

        Flurry.log(standardEvent: FlurryEvent.levelSkip, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged level skipped"
            ),
            callbackId: command.callbackId)
    }

    @objc(logScorePosted:) func logScorePosted(command : CDVInvokedUrlCommand) {
        guard let score = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a score"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(integerVal: Int32(score), param: FlurryParamBuilder.score())
        if let levelNumber = command.arguments[1] as? Int {param.set(integerVal: Int32(levelNumber), param: FlurryParamBuilder.levelNumber())}

        Flurry.log(standardEvent: FlurryEvent.scorePosted, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged score posted"
            ),
            callbackId: command.callbackId)
    }

    @objc(logAppActivated:) func logAppActivated(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.appActivated, param: nil)
    }

    @objc(logApplicationSubmitted:) func logApplicationSubmitted(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.applicationSubmitted, param: nil)
    }

    @objc(logAddItemToCart:) func logAddItemToCart(command : CDVInvokedUrlCommand) {
        guard let itemCount = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item count"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let price = command.arguments[1] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(itemCount), param: FlurryParamBuilder.itemCount())
            .set(doubleVal: price, param: FlurryParamBuilder.price())
        if let itemId = command.arguments[2] as? String {param.set(stringVal: itemId, param: FlurryParamBuilder.itemId())}
        if let itemName = command.arguments[3] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemType = command.arguments[4] as? String {param.set(stringVal: itemType, param: FlurryParamBuilder.itemType())}

        Flurry.log(standardEvent: FlurryEvent.addItemToCart, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged add item to cart"
            ),
            callbackId: command.callbackId)
    }

    @objc(logAddItemToWishList:) func logAddItemToWishList(command : CDVInvokedUrlCommand) {
        guard let itemCount = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item count"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let price = command.arguments[1] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(itemCount), param: FlurryParamBuilder.itemCount())
            .set(doubleVal: price, param: FlurryParamBuilder.price())
        if let itemId = command.arguments[2] as? String {param.set(stringVal: itemId, param: FlurryParamBuilder.itemId())}
        if let itemName = command.arguments[3] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemType = command.arguments[4] as? String {param.set(stringVal: itemType, param: FlurryParamBuilder.itemType())}

        Flurry.log(standardEvent: FlurryEvent.addItemToWishList, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged add item to wish list"
            ),
            callbackId: command.callbackId)
    }

    @objc(logCompletedCheckout:) func logCompletedCheckout(command : CDVInvokedUrlCommand) {
        guard let itemCount = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item count"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let totalAmount = command.arguments[1] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(itemCount), param: FlurryParamBuilder.itemCount())
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())
        if let currencyType = command.arguments[2] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}
        if let transactionId = command.arguments[3] as? String {param.set(stringVal: transactionId, param: FlurryParamBuilder.transactionId())}

        Flurry.log(standardEvent: FlurryEvent.completedCheckout, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged completed checkout"
            ),
            callbackId: command.callbackId)
    }

    @objc(logPaymentInfoAdded:) func logPaymentInfoAdded(command : CDVInvokedUrlCommand) {
        guard let success = command.arguments[0] as? Bool else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a success flag"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let paymentType = command.arguments[1] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a payment type"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(booleanVal: success, param: FlurryParamBuilder.success())
            .set(stringVal: paymentType, param: FlurryParamBuilder.paymentType())

        Flurry.log(standardEvent: FlurryEvent.paymentInfoAdded, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged payment info added"
            ),
            callbackId: command.callbackId)
    }

    @objc(logItemViewed:) func logItemViewed(command : CDVInvokedUrlCommand) {
        guard let itemId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item ID"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(stringVal: itemId, param: FlurryParamBuilder.itemId())
        if let price = command.arguments[1] as? Double {param.set(doubleVal: price, param: FlurryParamBuilder.price())}
        if let itemName = command.arguments[2] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemType = command.arguments[3] as? String {param.set(stringVal: itemType, param: FlurryParamBuilder.itemType())}

        Flurry.log(standardEvent: FlurryEvent.itemViewed, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged item viewed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logItemListViewed:) func logItemListViewed(command : CDVInvokedUrlCommand) {
        guard let itemListType = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item list type"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(stringVal: itemListType, param: FlurryParamBuilder.itemListType())

        Flurry.log(standardEvent: FlurryEvent.itemListViewed, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged item list viewed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logPurchased:) func logPurchased(command : CDVInvokedUrlCommand) {
        guard let totalAmount = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let success = command.arguments[1] as? Bool else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a success flag"
                ),
                callbackId: command.callbackId)
            return
        }

        let param = FlurryParamBuilder()
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())
            .set(booleanVal: success, param: FlurryParamBuilder.success())
        if let itemCount = command.arguments[2] as? Int {param.set(integerVal: Int32(itemCount), param: FlurryParamBuilder.itemCount())}
        if let itemId = command.arguments[3] as? String {param.set(stringVal: itemId, param: FlurryParamBuilder.itemId())}
        if let itemName = command.arguments[4] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemType = command.arguments[5] as? String {param.set(stringVal: itemType, param: FlurryParamBuilder.itemType())}
        if let currencyType = command.arguments[6] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}
        if let transactionId = command.arguments[7] as? String {param.set(stringVal: transactionId, param: FlurryParamBuilder.transactionId())}

        Flurry.log(standardEvent: FlurryEvent.purchased, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged purchase"
            ),
            callbackId: command.callbackId)
    }

    @objc(logPurchaseRefunded:) func logPurchaseRefunded(command : CDVInvokedUrlCommand) {
        guard let price = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(doubleVal: price, param: FlurryParamBuilder.price())
        if let currencyType = command.arguments[1] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}

        Flurry.log(standardEvent: FlurryEvent.purchaseRefunded, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged purchase refunded"
            ),
            callbackId: command.callbackId)
    }

    @objc(logRemoveItemFromCart:) func logRemoveItemFromCart(command : CDVInvokedUrlCommand) {
        guard let itemId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item ID"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(stringVal: itemId, param: FlurryParamBuilder.itemId())
        if let price = command.arguments[1] as? Double {param.set(doubleVal: price, param: FlurryParamBuilder.price())}
        if let itemName = command.arguments[2] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemType = command.arguments[3] as? String {param.set(stringVal: itemType, param: FlurryParamBuilder.itemType())}

        Flurry.log(standardEvent: FlurryEvent.removeItemFromCart, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged remove item from cart"
            ),
            callbackId: command.callbackId)
    }

    @objc(logCheckoutInitiated:) func logCheckoutInitiated(command : CDVInvokedUrlCommand) {
        guard let totalAmount = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a total amount"
                ),
                callbackId: command.callbackId)
            return
        }
        
        guard let itemCount = command.arguments[1] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item count"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(doubleVal: totalAmount, param: FlurryParamBuilder.totalAmount())
            .set(integerVal: Int32(itemCount), param: FlurryParamBuilder.itemCount())
        
        Flurry.log(standardEvent: FlurryEvent.checkoutInitiated, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged checkout initiated"
            ),
            callbackId: command.callbackId)
    }

    @objc(logFundsDonated:) func logFundsDonated(command : CDVInvokedUrlCommand) {
        guard let price = command.arguments[0] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        let param = FlurryParamBuilder()
            .set(doubleVal: price, param: FlurryParamBuilder.price())
        if let currencyType = command.arguments[1] as? String {param.set(stringVal: currencyType, param: FlurryParamBuilder.currencyType())}

        Flurry.log(standardEvent: FlurryEvent.fundsDonated, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged funds donated"
            ),
            callbackId: command.callbackId)
    }

    @objc(logUserScheduled:) func logUserScheduled(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.userScheduled, param: nil)
    }

    @objc(logOfferPresented:) func logOfferPresented(command : CDVInvokedUrlCommand) {
        guard let itemId = command.arguments[0] as? String else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide an item ID"
                ),
                callbackId: command.callbackId)
            return
        }

        guard let price = command.arguments[1] as? Double else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a price"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(stringVal: itemId, param: FlurryParamBuilder.itemId())
            .set(doubleVal: price, param: FlurryParamBuilder.price())
        if let itemName = command.arguments[2] as? String {param.set(stringVal: itemName, param: FlurryParamBuilder.itemName())}
        if let itemCategory = command.arguments[3] as? String {param.set(stringVal: itemCategory, param: FlurryParamBuilder.itemCategory())}

        Flurry.log(standardEvent: FlurryEvent.offerPresented, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged offer presented"
            ),
            callbackId: command.callbackId)
    }

    @objc(logTutorialStarted:) func logTutorialStarted(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let tutorialName = command.arguments[0] as? String {param.set(stringVal: tutorialName, param: FlurryParamBuilder.tutorialName())}

        Flurry.log(standardEvent: FlurryEvent.tutorialStarted, param: param)
    }

    @objc(logTutorialCompleted:) func logTutorialCompleted(command : CDVInvokedUrlCommand) {
        let param = FlurryParamBuilder()
        if let tutorialName = command.arguments[0] as? String {param.set(stringVal: tutorialName, param: FlurryParamBuilder.tutorialName())}

        Flurry.log(standardEvent: FlurryEvent.tutorialCompleted, param: param)
    }

    @objc(logTutorialStepCompleted:) func logTutorialStepCompleted(command : CDVInvokedUrlCommand) {
        guard let stepNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a step number"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(stepNumber), param: FlurryParamBuilder.stepNumber())

        if let tutorialName = command.arguments[1] as? String {param.set(stringVal: tutorialName, param: FlurryParamBuilder.tutorialName())}

        Flurry.log(standardEvent: FlurryEvent.tutorialStepCompleted, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged tutorial step completed"
            ),
            callbackId: command.callbackId)
    }

    @objc(logTutorialSkipped:) func logTutorialSkipped(command : CDVInvokedUrlCommand) {
        guard let stepNumber = command.arguments[0] as? Int else {
            self.commandDelegate.send(
                CDVPluginResult(
                    status: CDVCommandStatus_INVALID_ACTION,
                    messageAs:"Must provide a step number"
                ),
                callbackId: command.callbackId)
            return
        }
        
        let param = FlurryParamBuilder()
            .set(integerVal: Int32(stepNumber), param: FlurryParamBuilder.stepNumber())

        if let tutorialName = command.arguments[1] as? String {param.set(stringVal: tutorialName, param: FlurryParamBuilder.tutorialName())}

        Flurry.log(standardEvent: FlurryEvent.tutorialSkipped, param: param)
        self.commandDelegate.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs:"Logged tutorial skipped"
            ),
            callbackId: command.callbackId)
    }

    @objc(logPrivacyPromptDisplayed:) func logPrivacyPromptDisplayed(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.privacyPromptDisplayed, param: nil)
    }

    @objc(logPrivacyOptIn:) func logPrivacyOptIn(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.privacyOptIn, param: nil)
    }

    @objc(logPrivacyOptOut:) func logPrivacyOptOut(command : CDVInvokedUrlCommand) {
        Flurry.log(standardEvent: FlurryEvent.privacyOptOut, param: nil)
    }
}
