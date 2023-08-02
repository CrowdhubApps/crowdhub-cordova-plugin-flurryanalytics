declare module 'crowdhub-cordova-plugin-flurryanalytics/www/FlurryAnalyticsPlugin';

export enum LogLevel {
	VERBOSE = 'VERBOSE',
	DEBUG = 'DEBUG',
	INFO = 'INFO',
	WARN = 'WARN',
	ERROR = 'ERROR'
}

export interface FlurryAnalyticsPlugin {
	initialize(
		apiKey: string,
		logLevel?: LogLevel,
		crashReportingEnabled?: boolean,
		appVersion?: string,
		iapReportingEnabled?: boolean
	): void;
}