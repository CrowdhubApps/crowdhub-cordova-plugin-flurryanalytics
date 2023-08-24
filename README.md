# crowdhub-cordova-plugin-flurryanalytics

Cordova plugin for Flurry Analytics based largely on the work of github.com/blakgeek, updated with the latest Flurry SDK and built in Swift/Kotlin.

## Installation

```bash
cordova plugin add crowdhub-cordova-plugin-flurryanalytics
```

## Usage

```javascript
// Initialize Flurry
FlurryAnalytics.initialize("YOUR_API_KEY", "VERBOSE", true, "version", true);
```

## Supported methods:

    initialize
    	apiKey,
    	logLevel,
    	crashReportingEnabled,
    	appVersion,
    	iapReportingEnabled,

    logAdClick
    	adType

    logAdImpression
    	adType

    logAdRewarded
    	adType

    logAdSkipped
    	adType

    logCreditsSpent
    	levelNumber,
    	totalAmount,
    	isCurrencySoft,
    	creditType,
    	creditId,
    	creditName,
    	currencyType,


    logCreditsPurchased
    	levelNumber,
    	totalAmount,
    	isCurrencySoft,
    	creditType,
    	creditId,
    	creditName,
    	currencyType,

    logCreditsEarned
    	levelNumber,
    	totalAmount,
    	isCurrencySoft,
    	creditType,
    	creditId,
    	creditName,
    	currencyType,


    logAchievementUnlocked
    	achievementId


    logLevelCompleted
    	levelNumber,
    	levelName,


    logLevelFailed
    	levelNumber,
    	levelName,

    logLevelUp
    	levelNumber,
    	levelName,

    logLevelStarted
    	levelNumber,
    	levelName,


    logLevelSkip
    	levelNumber,
    	levelName,


    logScorePosted
    	levelNumber,
    	score,


    logAppActivated

    logApplicationSubmitted

    logAddItemToCart
    	itemCount,
    	price,
    	itemId,
    	itemName,
    	itemType,


    logAddItemToWishList
    	itemCount,
    	price,
    	itemId,
    	itemName,
    	itemType,



    logCompletedCheckout
    	itemCount,
    	totalAmount,
    	currencyType,
    	transactionId,


    logPaymentInfoAdded
    	success,
    	paymentType,


    logItemViewed
    	price,
    	itemId,
    	itemName,
    	itemType,


    logItemListViewed
    	itemListType,


    logPurchased
    	itemCount,
    	totalAmount,
    	itemId,
    	success,
    	itemName,
    	itemType,
    	currencyType,
    	transactionId,


    logPurchaseRefunded
    	price,
    	currencyType,


    logRemoveItemFromCart
    	price,
    	itemId,
    	itemName,
    	itemType,


    logCheckoutInitiated

    	itemCount,
    	totalAmount,

    logFundsDonated
    	price,
    	currencyType,

    logUserScheduled

    logOfferPresented
    	price,
    	itemId,
    	itemName,
    	itemCategory,

    logTutorialStarted
    	tutorialName,

    logTutorialCompleted
    	tutorialName,

    logTutorialStepCompleted
    	stepNumber,
    	tutorialName,

    logTutorialSkipped
    	stepNumber,
    	tutorialName,

    logPrivacyPromptDisplayed

    logPrivacyOptIn

    logPrivacyOptOut

    endTimedEvent
    	eventName

    logContentRated
    	contentId,
    	contentRating,
    	contentName,
    	contentType


    logContentViewed
    	contentId,
    	contentName,
    	contentType,

    logContentSaved
    	contentId,
    	contentName,
    	contentType,

    logProductCustomized

    logSubscriptionStarted
    	price,
    	isAnnualSubscription,
    	trialDays,
    	predictedLTV,
    	currencyType,
    	subscriptionCountry,


    logSubscriptionEnded
    	isAnnualSubscription,
    	currencyType,
    	subscriptionCountry,


    logGroupJoined
    	groupName,


    logGroupLeft
    	groupName,


    logLogin
    	userId,
    	method,


    logLogout
    	userId,
    	method,


    logUserRegistered
    	userId,
    	method,

    logSearchResultViewed
    	query,
    	searchType,


    logKeywordSearched
    	query,
    	searchType,


    logLocationSearched
    	query,


    logInvite
    	userId,
    	method,


    logShare
    	socialContentId,
    	socialContentName,
    	method,


    logLike
    	socialContentId,
    	socialContentName,
    	likeType,


    logComment
    	socialContentId,
    	socialContentName,


    logMediaCaptured
    	mediaId,
    	mediaName,
    	mediaType,


    logMediaStarted
    	mediaId,
    	mediaName,
    	mediaType,


    logMediaStopped
    	duration,
    	mediaId,
    	mediaName,
    	mediaType,


    logMediaPaused
    	duration,
    	mediaId,
    	mediaName,
    	mediaType,


    logCustomEvent
    	eventName,
    	eventParams,
    	eventTimed,


    setUserId
    	userId

    setAge
    	userAge

    setGender
    	userGender

    logError

    	errorId,
    	errorMessage,
    	error,
