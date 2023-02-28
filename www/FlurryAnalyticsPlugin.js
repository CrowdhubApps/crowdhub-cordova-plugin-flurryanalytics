class FlurryAnalyticsPlugin {
	constructor(config) {
		if (config) {
			cordova.exec(null, null, "FlurryAnalyticsPlugin", "initialize", [config.appKey, config]);
		}
	}
	init = function (appKey /* [options], successCallback, failureCallback */) {
		var successCallback, failureCallback, options;

		if (arguments.length === 4) {
			options = arguments[1];
			successCallback = arguments[2];
			failureCallback = arguments[3];
		} else if (arguments.length === 3) {
			successCallback = arguments[1];
			failureCallback = arguments[2];
		} else if (arguments.length === 2) {
			options = arguments[1];
		}

		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "initialize", [appKey, options]);
	};

	setUserId = function (userId, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "setUserId", [userId]);
	};

	setAge = function (age, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "setAge", [age]);
	};

	setGender = function (gender, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "setGender", [gender]);
	};

	// the params parameter is optional
	logEvent = function (event /* [params], successCallback, failureCallback */) {
		var successCallback, failureCallback, params;

		if (arguments.length === 4) {
			params = arguments[1];
			successCallback = arguments[2];
			failureCallback = arguments[3];
		} else if (arguments.length === 3) {
			successCallback = arguments[1];
			failureCallback = arguments[2];
		} else if (arguments.length === 2) {
			params = arguments[1];
		}

		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "logEvent", [event, false, params]);
	};

	// the params parameter is optional
	startTimedEvent = function (event /* [params], successCallback, failureCallback */) {
		var successCallback, failureCallback, params;

		if (arguments.length === 4) {
			params = arguments[1];
			successCallback = arguments[2];
			failureCallback = arguments[3];
		} else if (arguments.length === 3) {
			successCallback = arguments[1];
			failureCallback = arguments[2];
		} else if (arguments.length === 2) {
			params = arguments[1];
		}

		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "logEvent", [event, true, params]);
	};

	// the params parameter is optional
	endTimedEvent = function (event /* [params], successCallback, failureCallback */) {
		var successCallback, failureCallback, params;

		if (arguments.length === 4) {
			params = arguments[1];
			successCallback = arguments[2];
			failureCallback = arguments[3];
		} else if (arguments.length === 3) {
			successCallback = arguments[1];
			failureCallback = arguments[2];
		} else if (arguments.length === 2) {
			params = arguments[1];
		}
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "endTimedEvent", [event, params]);
	};

	logPageView = function (successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "logPageView", []);
	};

	logError = function (code, message, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "logError", [code, message]);
	};

	setLocation = function (location, message, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "setLocation", [
			location.latitude,
			location.longitude,
			location.verticalAccuracy,
			location.horizontalAccuracy
		]);
	};

	// only needed for older versions of Android
	startSession = function (successCallback, failureCallback) {
		if (cordova.platformId !== "android")
			return;
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "startSession", []);
	};

	// only needed for older versions of Android
	endSession = function (successCallback, failureCallback) {
		if (cordova.platformId !== "android")
			return;
		cordova.exec(successCallback, failureCallback, "FlurryAnalyticsPlugin", "endSession", []);
	};
}

export default FlurryAnalyticsPlugin;
