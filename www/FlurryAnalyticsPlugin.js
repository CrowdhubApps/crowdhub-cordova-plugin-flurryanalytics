/* eslint-disable @typescript-eslint/no-unused-vars */
var exec = require('cordova/exec');

function FlurryAnalytics() {
	this.initialize = function (
		apiKey,
		logLevel,
		crashReportingEnabled,
		appVersion,
		iapReportingEnabled,
	) {
		exec(null, null, 'FlurryAnalytics', 'initialize', [apiKey, logLevel, crashReportingEnabled, appVersion, iapReportingEnabled]);
	}

	this.logAdClick = function (adType) {
		exec(null, null, 'FlurryAnalytics', 'logAdClick', [adType]);
	};

	this.logAdImpression = function (adType) {
		exec(null, null, 'FlurryAnalytics', 'logAdImpression', [adType]);
	};

	this.logAdRewarded = function (adType) {
		exec(null, null, 'FlurryAnalytics', 'logAdRewarded', [adType]);
	};

	this.logAdSkipped = function (adType) {
		exec(null, null, 'FlurryAnalytics', 'logAdSkipped', [adType]);
	};

	this.logCreditsSpent = function (
		levelNumber,
		totalAmount,
		isCurrencySoft,
		creditType,
		creditId,
		creditName,
		currencyType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCreditsSpent', [
			levelNumber,
			totalAmount,
			isCurrencySoft,
			creditType,
			creditId,
			creditName,
			currencyType
		]);
	}

	this.logCreditsPurchased = function (
		levelNumber,
		totalAmount,
		isCurrencySoft,
		creditType,
		creditId,
		creditName,
		currencyType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCreditsPurchased', [
			levelNumber,
			totalAmount,
			isCurrencySoft,
			creditType,
			creditId,
			creditName,
			currencyType,
		]);
	}
	this.logCreditsEarned = function (
		levelNumber,
		totalAmount,
		isCurrencySoft,
		creditType,
		creditId,
		creditName,
		currencyType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCreditsEarned', [
			levelNumber,
			totalAmount,
			isCurrencySoft,
			creditType,
			creditId,
			creditName,
			currencyType,
		]);
	}

	this.logAchievementUnlocked = function (achievementId) {
		exec(null, null, 'FlurryAnalytics', 'logAchievementUnlocked', [achievementId]);
	}

	this.logLevelCompleted = function (
		levelNumber,
		levelName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLevelCompleted', [levelNumber, levelName]);
	}

	this.logLevelFailed = function (
		levelNumber,
		levelName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLevelFailed', [levelNumber, levelName]);
	}

	this.logLevelUp = function (
		levelNumber,
		levelName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLevelUp', [levelNumber, levelName]);
	}

	this.logLevelStarted = function (
		levelNumber,
		levelName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLevelStarted', [levelNumber, levelName]);
	}

	this.logLevelSkip = function (
		levelNumber,
		levelName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLevelSkip', [levelNumber, levelName]);
	}

	this.logScorePosted = function (
		levelNumber,
		score,
	) {
		exec(null, null, 'FlurryAnalytics', 'logScorePosted', [levelNumber, score]);
	}

	this.logAppActivated = function () {
		exec(null, null, 'FlurryAnalytics', 'logAppActivated', []);
	}

	this.logApplicationSubmitted = function () {
		exec(null, null, 'FlurryAnalytics', 'logApplicationSubmitted', []);
	}

	this.logAddItemToCart = function (
		itemCount,
		price,
		itemId,
		itemName,
		itemType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logAddItemToCart', [itemCount, price, itemId, itemName, itemType]);
	}

	this.logAddItemToWishList = function (
		itemCount,
		price,
		itemId,
		itemName,
		itemType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logAddItemToWishList', [itemCount, price, itemId, itemName, itemType]);
	}

	this.logCompletedCheckout = function (
		itemCount,
		totalAmount,
		currencyType,
		transactionId,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCompletedCheckout', [itemCount, totalAmount, currencyType, transactionId]);
	}

	this.logPaymentInfoAdded = function (
		success,
		paymentType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logPaymentInfoAdded', [success, paymentType]);
	}

	this.logItemViewed = function (
		price,
		itemId,
		itemName,
		itemType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logItemViewed', [price, itemId, itemName, itemType]);
	}

	this.logItemListViewed = function (
		itemListType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logItemListViewed', [itemListType]);
	}

	this.logPurchased = function (
		itemCount,
		totalAmount,
		itemId,
		success,
		itemName,
		itemType,
		currencyType,
		transactionId,
	) {
		exec(null, null, 'FlurryAnalytics', 'logPurchased', [itemCount, totalAmount, itemId, success, itemName, itemType, currencyType, transactionId]);
	}

	this.logPurchaseRefunded = function (
		price,
		currencyType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logPurchaseRefunded', [price, currencyType]);
	}

	this.logRemoveItemFromCart = function (
		price,
		itemId,
		itemName,
		itemType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logRemoveItemFromCart', [price, itemId, itemName, itemType]);
	}

	this.logCheckoutInitiated = function (
		itemCount,
		totalAmount,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCheckoutInitiated', [itemCount, totalAmount]);
	}

	this.logFundsDonated = function (
		price,
		currencyType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logFundsDonated', [price, currencyType]);
	}

	this.logUserScheduled = function () {
		exec(null, null, 'FlurryAnalytics', 'logUserScheduled', []);
	}

	this.logOfferPresented = function (
		price,
		itemId,
		itemName,
		itemCategory,
	) {
		exec(null, null, 'FlurryAnalytics', 'logOfferPresented', [price, itemId, itemName, itemCategory]);
	}

	this.logTutorialStarted = function (
		tutorialName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logTutorialStarted', [tutorialName]);
	}

	this.logTutorialCompleted = function (
		tutorialName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logTutorialCompleted', [tutorialName]);
	}

	this.logTutorialStepCompleted = function (
		stepNumber,
		tutorialName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logTutorialStepCompleted', [stepNumber, tutorialName]);
	}

	this.logTutorialSkipped = function (
		stepNumber,
		tutorialName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logTutorialSkipped', [stepNumber, tutorialName]);
	}

	this.logPrivacyPromptDisplayed = function () {
		exec(null, null, 'FlurryAnalytics', 'logPrivacyPromptDisplayed', []);
	}

	this.logPrivacyOptIn = function () {
		exec(null, null, 'FlurryAnalytics', 'logPrivacyOptIn', []);
	}

	this.logPrivacyOptOut = function () {
		exec(null, null, 'FlurryAnalytics', 'logPrivacyOptOut', []);
	}

	this.endTimedEvent = function (eventName) {
		exec(null, null, 'FlurryAnalytics', 'endTimedEvent', [eventName]);
	}

	this.logContentRated = function (
		contentId,
		contentRating,
		contentName,
		contentType
	) {
		exec(null, null, 'FlurryAnalytics', 'logContentRated', [contentId, contentRating, contentName, contentType]);
	}

	this.logContentViewed = function (
		contentId,
		contentName,
		contentType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logContentViewed', [contentId, contentName, contentType]);
	}

	this.logContentSaved = function (
		contentId,
		contentName,
		contentType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logContentSaved', [contentId, contentName, contentType]);
	}

	this.logProductCustomized = function () {
		exec(null, null, 'FlurryAnalytics', 'logProductCustomized', []);
	}

	this.logSubscriptionStarted = function (
		price,
		isAnnualSubscription,
		trialDays,
		predictedLTV,
		currencyType,
		subscriptionCountry,
	) {
		exec(null, null, 'FlurryAnalytics', 'logSubscriptionStarted', [
			price,
			isAnnualSubscription,
			trialDays,
			predictedLTV,
			currencyType,
			subscriptionCountry
		]);
	}

	this.logSubscriptionEnded = function (
		isAnnualSubscription,
		currencyType,
		subscriptionCountry,
	) {
		exec(null, null, 'FlurryAnalytics', 'logSubscriptionEnded', [isAnnualSubscription, currencyType, subscriptionCountry]);
	}

	this.logGroupJoined = function (
		groupName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logGroupJoined', [groupName]);
	}

	this.logGroupLeft = function (
		groupName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logGroupLeft', [groupName]);
	}

	this.logLogin = function (
		userId,
		method,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLogin', [userId, method]);
	}

	this.logLogout = function (
		userId,
		method,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLogout', [userId, method]);
	}

	this.logUserRegistered = function (
		userId,
		method,
	) {
		exec(null, null, 'FlurryAnalytics', 'logUserRegistered', [userId, method]);
	}

	this.logSearchResultViewed = function (
		query,
		searchType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logSeachResultViewed', [query, searchType]);
	}

	this.logKeywordSearched = function (
		query,
		searchType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logKeywordSearched', [query, searchType]);
	}

	this.logLocationSearched = function (
		query,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLocationSearched', [query]);
	}

	this.logInvite = function (
		userId,
		method,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLocationSearched', [userId, method]);
	}

	this.logShare = function (
		socialContentId,
		socialContentName,
		method,
	) {
		exec(null, null, 'FlurryAnalytics', 'logShare', [socialContentId, socialContentName, method]);
	}

	this.logLike = function (
		socialContentId,
		socialContentName,
		likeType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logLike', [socialContentId, socialContentName, likeType]);
	}

	this.logComment = function (
		socialContentId,
		socialContentName,
	) {
		exec(null, null, 'FlurryAnalytics', 'logComment', [socialContentId, socialContentName]);
	}

	this.logMediaCaptured = function (
		mediaId,
		mediaName,
		mediaType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logMediaCaptured', [mediaId, mediaName, mediaType]);
	}

	this.logMediaStarted = function (
		mediaId,
		mediaName,
		mediaType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logMediaStarted', [mediaId, mediaName, mediaType]);
	}

	this.logMediaStopped = function (
		duration,
		mediaId,
		mediaName,
		mediaType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logMediaStopped', [duration, mediaId, mediaName, mediaType]);
	}

	this.logMediaPaused = function (
		duration,
		mediaId,
		mediaName,
		mediaType,
	) {
		exec(null, null, 'FlurryAnalytics', 'logMediaPaused', [duration, mediaId, mediaName, mediaType]);
	}

	this.logCustomEvent = function (
		eventName,
		eventParams,
		eventTimed,
	) {
		exec(null, null, 'FlurryAnalytics', 'logCustomEvent', [eventName, eventParams, eventTimed]);
	}

	this.setUserId = function (userId) {
		exec(null, null, 'FlurryAnalytics', 'setUserId', [userId]);
	}

	this.setAge = function (userAge) {
		exec(null, null, 'FlurryAnalytics', 'setAge', [userAge]);
	}

	this.setGender = function (userGender) {
		exec(null, null, 'FlurryAnalytics', 'setGender', [userGender]);
	}

	this.logError = function (
		errorId,
		errorMessage,
		error,
	) {
		exec(null, null, 'FlurryAnalytics', 'logError', [errorId, errorMessage, error]);
	}
}

var FlurryAnalytics = new FlurryAnalytics();
module.exports = FlurryAnalytics;