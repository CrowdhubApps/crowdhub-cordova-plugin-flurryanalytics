package com.crowdhubapps.cordova.plugins

import android.util.Log
import com.flurry.android.*
import org.apache.cordova.CallbackContext
import org.apache.cordova.CordovaArgs
import org.apache.cordova.CordovaPlugin
import org.json.JSONException


class FlurryAnalytics : CordovaPlugin(), FlurryAgentListener {

    @Throws(JSONException::class)
    override fun execute(action: String, data: CordovaArgs, callbackContext: CallbackContext): Boolean {
        when(action) {
            "initialize" -> initialize(data, callbackContext)
            "logContentRated" -> logContentRated(data, callbackContext)
            "logContentViewed" -> logContentViewed(data, callbackContext)
            "logContentSaved" -> logContentSaved(data, callbackContext)
            "logProductCustomized" -> logProductCustomized(data, callbackContext)
            "logSubscriptionStarted" -> logSubscriptionStarted(data, callbackContext)
            "logSubscriptionEnded" -> logSubscriptionEnded(data, callbackContext)
            "logGroupJoined" -> logGroupJoined(data, callbackContext)
            "logGroupLeft" -> logGroupLeft(data, callbackContext)
            "logLogin" -> logLogin(data, callbackContext)
            "logLogout" -> logLogout(data, callbackContext)
            "logUserRegistered" -> logUserRegistered(data, callbackContext)
            "logSearchResultViewed" -> logSearchResultViewed(data, callbackContext)
            "logKeywordSearched" -> logKeywordSearched(data, callbackContext)
            "logLocationSearched" -> logLocationSearched(data, callbackContext)
            "logInvite" -> logInvite(data, callbackContext)
            "logShare" -> logShare(data, callbackContext)
            "logLike" -> logLike(data, callbackContext)
            "logComment" -> logComment(data, callbackContext)
            "logMediaCaptured" -> logMediaCaptured(data, callbackContext)
            "logMediaStarted" -> logMediaStarted(data, callbackContext)
            "logMediaStopped" -> logMediaStopped(data, callbackContext)
            "logMediaPaused" -> logMediaPaused(data, callbackContext)
            "logCustomEvent" -> logCustomEvent(data, callbackContext)
            "endTimedEvent" -> endTimedEvent(data, callbackContext)
            "setUserId" -> setUserId(data, callbackContext)
            "setAge" -> setAge(data, callbackContext)
            "setGender" -> setGender(data, callbackContext)
            "logError" -> logError(data, callbackContext)
            "logAdClick" -> logAdClick(data, callbackContext)
            "logAdImpression" -> logAdImpression(data, callbackContext)
            "logAdRewarded" -> logAdRewarded(data, callbackContext)
            "logAdSkipped" -> logAdSkipped(data, callbackContext)
            "logCreditsSpent" -> logCreditsSpent(data, callbackContext)
            "logCreditsPurchased" -> logCreditsPurchased(data, callbackContext)
            "logCreditsEarned" -> logCreditsEarned(data, callbackContext)
            "logAchievementUnlocked" -> logAchievementUnlocked(data, callbackContext)
            "logLevelCompleted" -> logLevelCompleted(data, callbackContext)
            "logLevelFailed" -> logLevelFailed(data, callbackContext)
            "logLevelUp" -> logLevelUp(data, callbackContext)
            "logLevelStarted" -> logLevelStarted(data, callbackContext)
            "logLevelSkip" -> logLevelSkip(data, callbackContext)
            "logScorePosted" -> logScorePosted(data, callbackContext)
            "logAppActivated" -> logAppActivated(data,callbackContext)
            "logApplicationSubmitted" -> logApplicationSubmitted(data,callbackContext)
            "logAddItemToCart" -> logAddItemToCart(data, callbackContext)
            "logAddItemToWishList" -> logAddItemToWishList(data, callbackContext)
            "logCompletedCheckout" -> logCompletedCheckout(data, callbackContext)
            "logPaymentInfoAdded" -> logPaymentInfoAdded(data, callbackContext)
            "logItemViewed" -> logItemViewed(data, callbackContext)
            "logItemListViewed" -> logItemListViewed(data, callbackContext)
            "logPurchased" -> logPurchased(data, callbackContext)
            "logPurchaseRefunded" -> logPurchaseRefunded(data, callbackContext)
            "logRemoveItemFromCart" -> logRemoveItemFromCart(data, callbackContext)
            "logCheckoutInitiated" -> logCheckoutInitiated(data, callbackContext)
            "logFundsDonated" -> logFundsDonated(data, callbackContext)
            "logUserScheduled" -> logUserScheduled(data, callbackContext)
            "logOfferPresented" -> logOfferPresented(data, callbackContext)
            "logTutorialStarted" -> logTutorialStarted(data, callbackContext)
            "logTutorialCompleted" -> logTutorialCompleted(data, callbackContext)
            "logTutorialStepCompleted" -> logTutorialStepCompleted(data, callbackContext)
            "logTutorialSkipped" -> logTutorialSkipped(data, callbackContext)
            "logPrivacyPromptDisplayed" -> logPrivacyPromptDisplayed(data, callbackContext)
            "logPrivacyOptIn" -> logPrivacyOptIn(data, callbackContext)
            "logPrivacyOptOut" -> logPrivacyOptOut(data, callbackContext)
            else -> {
                println("$action not found")
                return false
            }
        }
        return true
    }

    fun initialize(args: CordovaArgs, callbackContext: CallbackContext) {
        val logLevel: Int
        val logEnabled: Boolean
        when (args.optString(1)?.lowercase()) {
            "verbose" -> {
                logLevel = Log.VERBOSE
                logEnabled = true
            }
            "debug" -> {
                logLevel = Log.DEBUG
                logEnabled = true
            }
            "info" -> {
                logLevel = Log.INFO
                logEnabled = true
            }
            "warn" -> {
                logLevel = Log.WARN
                logEnabled = true
            }
            "error" -> {
                logLevel = Log.ERROR
                logEnabled = true
            }
            else -> {
                logLevel = Log.ERROR
                logEnabled = false
            }
        }

        args.getString(0)?.let {
            FlurryAgent.Builder()
                .withLogLevel(logLevel)
                .withLogEnabled(logEnabled)
                .withReportLocation(true)
                .withPerformanceMetrics(FlurryPerformance.ALL)
                .withDataSaleOptOut(true)
                .withIncludeBackgroundSessionsInMetrics(true)
                .build(cordova.activity, it)
            callbackContext.success()
        } ?: callbackContext.error("Must provide a Flurry API key")
    }

    // StandardEvents: https://developer.yahoo.com/flurry/docs/analytics/standard_events/iOS/
    private fun logContentRated(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a content ID")

        args.getString(1)?.let {
            params.putString(FlurryEvent.Param.RATING, it)
        } ?: callbackContext.error("Must provide a content rating")

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.CONTENT_NAME, it)
        }

        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.CONTENT_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CONTENT_RATED, params)
        callbackContext.success()
    }

    private fun logContentViewed(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a content ID")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.CONTENT_NAME, it)
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.CONTENT_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CONTENT_VIEWED, params)
        callbackContext.success()
    }

    private fun logContentSaved(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a content ID")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.CONTENT_NAME, it)
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.CONTENT_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CONTENT_SAVED, params)
        callbackContext.success()
    }

    private fun logProductCustomized(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        FlurryAgent.logEvent(FlurryEvent.PRODUCT_CUSTOMIZED, params)
        callbackContext.success()
    }

    private fun logSubscriptionStarted(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: callbackContext.error("Must provide a price")

        args.getBoolean(1).let {
            params.putBoolean(FlurryEvent.Param.IS_ANNUAL_SUBSCRIPTION, it)
        } ?: callbackContext.error("Must define whether the subscription is annual or not")

        args.optInt(2).let {
            params.putInteger(FlurryEvent.Param.TRIAL_DAYS, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.PREDICTED_LTV, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }
        args.optString(5)?.let {
            params.putString(FlurryEvent.Param.SUBSCRIPTION_COUNTRY, it)
        }

        FlurryAgent.logEvent(FlurryEvent.SUBSCRIPTION_STARTED, params)
        callbackContext.success()
    }

    private fun logSubscriptionEnded(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getBoolean(0).let {
            params.putBoolean(FlurryEvent.Param.IS_ANNUAL_SUBSCRIPTION, it)
        } ?: callbackContext.error("Must define whether the subscription is annual or not")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.SUBSCRIPTION_COUNTRY, it)
        }

        FlurryAgent.logEvent(FlurryEvent.SUBSCRIPTION_ENDED, params)
        callbackContext.success()
    }

    private fun logGroupJoined(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.GROUP_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.GROUP_JOINED, params)
        callbackContext.success()
    }

    private fun logGroupLeft(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.GROUP_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.GROUP_LEFT, params)
        callbackContext.success()
    }

    private fun logLogin(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.USER_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.METHOD, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LOGIN, params)
        callbackContext.success()
    }

    private fun logLogout(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.USER_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.METHOD, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LOGOUT, params)
        callbackContext.success()
    }

    private fun logUserRegistered(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.USER_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.METHOD, it)
        }

        FlurryAgent.logEvent(FlurryEvent.USER_REGISTERED, params)
        callbackContext.success()
    }

    private fun logSearchResultViewed(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.QUERY, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.SEARCH_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.SEARCH_RESULT_VIEWED, params)
        callbackContext.success()
    }

    private fun logKeywordSearched(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.QUERY, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.SEARCH_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.KEYWORD_SEARCHED, params)
        callbackContext.success()
    }

    private fun logLocationSearched(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.QUERY, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LOCATION_SEARCHED, params)
        callbackContext.success()
    }

    private fun logInvite(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.USER_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.METHOD, it)
        }

        FlurryAgent.logEvent(FlurryEvent.INVITE, params)
        callbackContext.success()
    }

    private fun logShare(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a social content ID")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_NAME, it)
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.METHOD, it)
        }

        FlurryAgent.logEvent(FlurryEvent.SHARE, params)
        callbackContext.success()
    }

    private fun logLike(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a social content ID")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_NAME, it)
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.LIKE_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LIKE, params)
        callbackContext.success()
    }

    private fun logComment(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_ID, it)
        } ?: callbackContext.error("Must provide a social content ID")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.SOCIAL_CONTENT_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.COMMENT, params)
        callbackContext.success()
    }

    private fun logMediaCaptured(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.MEDIA_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.MEDIA_NAME, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.MEDIA_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.MEDIA_CAPTURED, params)
        callbackContext.success()
    }

    private fun logMediaStarted(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.MEDIA_ID, it)
        }
        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.MEDIA_NAME, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.MEDIA_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.MEDIA_STARTED, params)
        callbackContext.success()
    }

    private fun logMediaStopped(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.DURATION, it)
        } ?: callbackContext.error("Must provide a duration")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.MEDIA_ID, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.MEDIA_NAME, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.MEDIA_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.MEDIA_STOPPED, params)
        callbackContext.success()
    }

    private fun logMediaPaused(args: CordovaArgs, callbackContext: CallbackContext) {
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.DURATION, it)
        } ?: callbackContext.error("Must provide a duration")

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.MEDIA_ID, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.MEDIA_NAME, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.MEDIA_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.MEDIA_PAUSED, params)
        callbackContext.success()
    }

    // Custom Events: https://developer.yahoo.com/flurry/docs/analytics/gettingstarted/events/ios/
    private fun logCustomEvent(args: CordovaArgs, callbackContext: CallbackContext) {

        var eventName = ""
        args.getString(0)?.let {
            eventName = it
        } ?: run {
            callbackContext.error("Must provide a custom event name")
            return
        }

        val isTimed: Boolean = args.getBoolean(2)

        val eventMap: MutableMap<String, String> = mutableMapOf()
        args.optJSONObject(1)?.let {
            val keys = it.names()
            if (keys != null) {
                for (i in 0 until keys.length()) {
                    it.getString(keys.getString(i))
                        .let { it1 -> eventMap.put(keys.getString(i), it1) }
                }
            }
        }

        FlurryAgent.logEvent(eventName, eventMap, isTimed)
        callbackContext.success()
    }

    private fun endTimedEvent(args: CordovaArgs, callbackContext: CallbackContext) {
        args.getString(0)?.let {
            FlurryAgent.endTimedEvent(it)
            callbackContext.success()
        } ?: callbackContext.error("Must provide a custom event name")
    }

    // Advanced Features: https://developer.yahoo.com/flurry/docs/analytics/gettingstarted/technicalquickstart/ios/
    fun setUserId(args: CordovaArgs, callbackContext: CallbackContext) {
        args.getString(0)?.let {
            FlurryAgent.setUserId(it)
            callbackContext.success()
        } ?: callbackContext.error("Must provide a user ID")
    }

    private fun setAge(args: CordovaArgs, callbackContext: CallbackContext) {
        args.getInt(0).let {
            if (it !in 1..109) {
                callbackContext.error("Must provide an age between 1 and 109")
                return
            }
            FlurryAgent.setAge(it)
            callbackContext.success()
        }
    }

    private fun setGender(args: CordovaArgs, callbackContext: CallbackContext) {
        args.getString(0)?.let {
            val userGender: Byte = when (it) {
                "m" -> Constants.MALE
                "f" -> Constants.FEMALE
                else -> {
                    callbackContext.error("Must provide a user gender of either m or f")
                    return
                }
            }
            FlurryAgent.setGender(userGender)
            callbackContext.success()
        } ?: callbackContext.error("Must provide a user gender")
    }

    private fun logError(args: CordovaArgs, callbackContext: CallbackContext) {
        FlurryAgent.onError("", "An error has occurred", "")
        callbackContext.success()
    }

    private fun logAdClick(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.AD_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.AD_CLICK, params)
        callbackContext.success()
    }

    private fun logAdImpression(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.AD_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.AD_IMPRESSION, params)
        callbackContext.success()
    }

    private fun logAdRewarded(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.AD_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.AD_REWARDED, params)
        callbackContext.success()
    }

    private fun logAdSkipped(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.AD_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.AD_SKIPPED, params)
        callbackContext.success()
    }

    private fun logCreditsSpent(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.optInt(1).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        }
        args.optBoolean(2).let {
            params.putBoolean(FlurryEvent.Param.IS_CURRENCY_SOFT, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.CREDIT_TYPE, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.CREDIT_ID, it)
        }
        args.optString(5)?.let {
            params.putString(FlurryEvent.Param.CREDIT_NAME, it)
        }
        args.optString(6)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CREDITS_SPENT, params)
        callbackContext.success()
    }


    private fun logCreditsPurchased(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.optInt(1).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        }
        args.optBoolean(2).let {
            params.putBoolean(FlurryEvent.Param.IS_CURRENCY_SOFT, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.CREDIT_TYPE, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.CREDIT_ID, it)
        }
        args.optString(5)?.let {
            params.putString(FlurryEvent.Param.CREDIT_NAME, it)
        }
        args.optString(6)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CREDITS_PURCHASED, params)
        callbackContext.success()
    }

    private fun logCreditsEarned(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.optInt(1).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        }
        args.optBoolean(2).let {
            params.putBoolean(FlurryEvent.Param.IS_CURRENCY_SOFT, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.CREDIT_TYPE, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.CREDIT_ID, it)
        }
        args.optString(5)?.let {
            params.putString(FlurryEvent.Param.CREDIT_NAME, it)
        }
        args.optString(6)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CREDITS_EARNED, params)
        callbackContext.success()
    }

    private fun logAchievementUnlocked(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.ACHIEVEMENT_ID, it)
        }

        FlurryAgent.logEvent(FlurryEvent.ACHIEVEMENT_UNLOCKED,params)
        callbackContext.success()
    }

    private fun logLevelCompleted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a level number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.LEVEL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LEVEL_COMPLETED, params)
        callbackContext.success()
    }

    private fun logLevelFailed(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a level number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.LEVEL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LEVEL_FAILED, params)
        callbackContext.success()
    }

    private fun logLevelUp(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a level number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.LEVEL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LEVEL_UP, params)
        callbackContext.success()
    }

    private fun logLevelStarted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a level number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.LEVEL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LEVEL_STARTED, params)
        callbackContext.success()
    }

    private fun logLevelSkip(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a level number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.LEVEL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.LEVEL_SKIP, params)
        callbackContext.success()
    }

    private fun logScorePosted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()
        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.SCORE, it)
        } ?: run {
            callbackContext.error("Must provide a score")
            return
        }

        args.optInt(1).let {
            params.putInteger(FlurryEvent.Param.LEVEL_NUMBER, it)
        }

        FlurryAgent.logEvent(FlurryEvent.SCORE_POSTED, params)
        callbackContext.success()
    }

    private fun logAppActivated(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.APP_ACTIVATED, null)
        callbackContext.success()
    }

    private fun logApplicationSubmitted(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.APPLICATION_SUBMITTED, null)
        callbackContext.success()
    }

    private fun logAddItemToCart(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.ITEM_COUNT, it)
        } ?: run {
            callbackContext.error("Must provide an item count")
            return
        }

        args.getDouble(1).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: run {
            callbackContext.error("Must provide a price")
            return
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.ADD_ITEM_TO_CART, params)
        callbackContext.success()
    }

    private fun logAddItemToWishList(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.ITEM_COUNT, it)
        } ?: run {
            callbackContext.error("Must provide an item count")
            return
        }

        args.getDouble(1).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: run {
            callbackContext.error("Must provide a price")
            return
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.ADD_ITEM_TO_WISH_LIST, params)
        callbackContext.success()
    }

    private fun logCompletedCheckout(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let {
            params.putInteger(FlurryEvent.Param.ITEM_COUNT, it)
        } ?: run {
            callbackContext.error("Must provide an item count")
            return
        }

        args.getDouble(1).let {
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.TRANSACTION_ID, it)
        }

        FlurryAgent.logEvent(FlurryEvent.COMPLETED_CHECKOUT, params)
        callbackContext.success()
    }

    private fun logPaymentInfoAdded(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getBoolean(0).let{
            params.putBoolean(FlurryEvent.Param.SUCCESS, it)
        } ?: run {
            callbackContext.error("Must provide a success flag")
            return
        }

        args.getString(1).let {
            params.putString(FlurryEvent.Param.PAYMENT_TYPE, it)
        } ?: run {
            callbackContext.error("Must provide a payment type")
            return
        }

        FlurryAgent.logEvent(FlurryEvent.PAYMENT_INFO_ADDED, params)
        callbackContext.success()
    }

    private fun logItemViewed(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        } ?: run {
            callbackContext.error("Must provide an item ID")
            return
        }

        args.optDouble(1).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.ITEM_VIEWED, params)
        callbackContext.success()
    }

    private fun logItemListViewed(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.ITEM_LIST_TYPE, it)
        } ?: run {
            callbackContext.error("Must provide an item list type")
            return
        }

        FlurryAgent.logEvent(FlurryEvent.ITEM_LIST_VIEWED, params)
        callbackContext.success()
    }

    private fun logPurchased(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let{
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.getBoolean(1).let{
            params.putBoolean(FlurryEvent.Param.SUCCESS, it)
        } ?: run {
            callbackContext.error("Must provide a success flag")
            return
        }

        args.optInt(2).let {
            params.putInteger(FlurryEvent.Param.ITEM_COUNT, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        }
        args.optString(4)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(5)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }
        args.optString(6)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }
        args.optString(7)?.let {
            params.putString(FlurryEvent.Param.TRANSACTION_ID, it)
        }

        FlurryAgent.logEvent(FlurryEvent.PURCHASED, params)
        callbackContext.success()
    }

    private fun logPurchaseRefunded(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: run {
            callbackContext.error("Must provide a price")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.PURCHASE_REFUNDED, params)
        callbackContext.success()
    }

    private fun logRemoveItemFromCart(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        } ?: run {
            callbackContext.error("Must provide an item ID")
            return
        }

        args.optDouble(1).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        }
        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.REMOVE_ITEM_FROM_CART, params)
        callbackContext.success()
    }

    private fun logCheckoutInitiated(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let{
            params.putDouble(FlurryEvent.Param.TOTAL_AMOUNT, it)
        } ?: run {
            callbackContext.error("Must provide a total amount")
            return
        }

        args.optInt(1).let {
            params.putInteger(FlurryEvent.Param.ITEM_COUNT, it)
        }

        FlurryAgent.logEvent(FlurryEvent.CHECKOUT_INITIATED, params)
        callbackContext.success()
    }

    private fun logFundsDonated(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getDouble(0).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: run {
            callbackContext.error("Must provide a price")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.CURRENCY_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.FUNDS_DONATED, params)
        callbackContext.success()
    }

    private fun logUserScheduled(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.USER_SCHEDULED, null)
        callbackContext.success()
    }

    private fun logOfferPresented(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getString(0)?.let {
            params.putString(FlurryEvent.Param.ITEM_ID, it)
        } ?: run {
            callbackContext.error("Must provide an item ID")
            return
        }

        args.getDouble(1).let {
            params.putDouble(FlurryEvent.Param.PRICE, it)
        } ?: run {
            callbackContext.error("Must provide a price")
            return
        }

        args.optString(2)?.let {
            params.putString(FlurryEvent.Param.ITEM_NAME, it)
        }
        args.optString(3)?.let {
            params.putString(FlurryEvent.Param.ITEM_TYPE, it)
        }

        FlurryAgent.logEvent(FlurryEvent.OFFER_PRESENTED, params)
        callbackContext.success()
    }

    private fun logTutorialStarted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()
        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.TUTORIAL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.TUTORIAL_STARTED, params)
        callbackContext.success()
    }

    private fun logTutorialCompleted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()
        args.optString(0)?.let {
            params.putString(FlurryEvent.Param.TUTORIAL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.TUTORIAL_COMPLETED, params)
        callbackContext.success()
    }

    private fun logTutorialStepCompleted(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let{
            params.putInteger(FlurryEvent.Param.STEP_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a step number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.TUTORIAL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.TUTORIAL_STEP_COMPLETED, params)
        callbackContext.success()
    }

    private fun logTutorialSkipped(args: CordovaArgs, callbackContext: CallbackContext){
        val params = FlurryEvent.Params()

        args.getInt(0).let{
            params.putInteger(FlurryEvent.Param.STEP_NUMBER, it)
        } ?: run {
            callbackContext.error("Must provide a step number")
            return
        }

        args.optString(1)?.let {
            params.putString(FlurryEvent.Param.TUTORIAL_NAME, it)
        }

        FlurryAgent.logEvent(FlurryEvent.TUTORIAL_SKIPPED, params)
        callbackContext.success()
    }

    private fun logPrivacyPromptDisplayed(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.PRIVACY_PROMPT_DISPLAYED, null)
        callbackContext.success()
    }

    private fun logPrivacyOptIn(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.PRIVACY_OPT_IN, null)
        callbackContext.success()
    }

    private fun logPrivacyOptOut(args: CordovaArgs, callbackContext: CallbackContext){
        FlurryAgent.logEvent(FlurryEvent.PRIVACY_OPT_OUT, null)
        callbackContext.success()
    }

    override fun onSessionStarted() {
        TODO("Not yet implemented")
    }
}