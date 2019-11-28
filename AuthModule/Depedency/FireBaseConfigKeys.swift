//
//  FireBaseKeys.swift
//  Goibibo
//
//  Created by AshokKumar on 08/06/17.
//  Copyright © 2017 ibibo Web Pvt Ltd. All rights reserved.
//

import Foundation

@objc public enum FirebaseDatabaseKey: Int {
    case goConfigDatabase
    case gohotelDatabase
    case goFlightDatabase
    case goBusDatabase
    case goCarDatabase
    case goTrainDatabase
    case goCoreDatabase
    case goUGCDatabase
    case goActivityDatabase
    case goFeatureDatabase
    case goAuthDatabase
    
    public func description() -> String {
        switch self {
        case .goConfigDatabase: return "default"
        case .gohotelDatabase: return "hotel"
        case .goFlightDatabase: return "flight"
        case .goBusDatabase: return "bus"
        case .goCarDatabase: return "car"
        case .goTrainDatabase: return "train"
        case .goCoreDatabase: return "core"
        case .goUGCDatabase: return "ugc"
        case .goActivityDatabase: return "activity"
        case .goFeatureDatabase: return "feature"
        case .goAuthDatabase: return "auth"
        }
    }
}

@objc public enum FirebaseConfigKey: Int {
    case callNumberError
    
    //Auth: - Sync Contacts Screen Titles
    case syncGoContactsNewUser
    case syncGoContactsPreviouslySynced
    case syncGoContactsneverSynced
    
    //Auth:- OTP Screen
    case wtsAppShowCount
    case otpHeader
    
    //Auth:- SignUp profile
    case showFb
    case signUpHeader
    case signUpHeaderNewUI
    case signUpNameTitle
    // Auth:- Refer & Earn Screen
    
    case reOffer
    case reDescription
    case showOffer
    case shareReferral
    
    //Ipl 2019
    
    case iplBurnConfig
    case isIplEnabled
    case enableIplSubTitle
    case enableIplTitle
    case enableIplLeftkey
    case enableIplRightKey
    case iplDownData
    case iplSettingsTitle
    case iplOnBoardingText
    case iplLockedData
    case iplSmallBallEnabled
    
    case isGIAClose
    case isGIAIPL
    
    //IPL
    case isIPLErrorState
    case hideLoginSkipButton
    case throttleTime
    
    //Core
    case appVersions
    case enableAppVersionHandling
    case appUpdatePopupSkipAppVersions
    case enableGoContactRewards
    case goContactTieringImageUrls
    case enableFreeSMS
    case freeSMSCtaText
    case disableNotificationAlert
    case goCashPlusUsageText
    case gaDispatchTime
    case forceUpdateText
    case forceUpdateForAppVersions //array of app version from 6.6.4 and above
    case forceUpdateForVerticalTags //vertical tag objects- contains tagid, message, app version list
    case newNotificationsUpdateTextData //In case a notification is not supported for old app versions then show this text inpopup----> {"gnr":"generic text applicable for all if not specified","915":"message for 915 tag"}
    case remoteConfigExpiryTime //Integer value(Time in minutes)
    case disableTrell
    case notificationBannerColor
    case KeychainLogInEnabled
    case enablePigeonAPICallOnForeGround
    case goEngageData
    case carReviewPopup
    case akmaiSDKEnable
    
    //Filo
    case earnScreenData
    case tierData
    case dynamicTierData
    case goCash_faq
    case goCash_howearn
    case goCash_filter
    case goCash_infoText
    case goCash_action
    case goCash_notLoggeIn
    case goCash_reward
    case signinRewardIntro
    case appUpdateRewardIntro
    case signupRewardIntro
    case upgradeRewardPopup
    case upgradeTierDays
    case xTimeToShowTutorial
    case showUpComingBookingCardOnHome
    case relaunchEarnScreenInDays
    case addMoneyTextData
    case enableGoogleMapAPIKeyInUrl
    case googleMapAPIKey
    case googlePlacesAPIKey
    case homeRecentSearchesLimit
    case homeStatesPositions
    
    //Collaborative
    case enablePlanAutoCreateOnSRP
    case collaborativeMessages
    case groupDealOfferTitle
    case groupDealOfferUrl
    //Ola
    case staticLoaderTimeForOla
    
    //Onboarding
    case onboarding
    case enableSecureAccountDisplay
    case clearCookieOnLogin
    case onboardingSyncScreenShown
    case onboardingSynchCTAs
    case onboardingGoCashInfoShow
    case onboardingWelcomeTutorial
    case onboardingInstallSourceTutorial
    
    //Social
    case social
    case socialContactListTitle
    case socialContactListSubTitle
    case socialgoCashInviteTitle
    case socialgoCashInviteSubTitle
    case isAskGoCashHidden
    case isGiftGoCashHidden
    case isTopUpGoCashHidden

    
    case isFlightsShowBusineessLayOver
    case socialSettingsDisableSyncMsg
    case goHomeAmenitiesMap
    case gstMetaData
    case getFlightBusinessDealData
    case contactSyncMessageOnTop
    case contactSyncMessageDetails
    
    case recommendedConactLimit
    
    //Flight
    case flightMsgPackStatus
    case isAutoRegisterFareAlerts
    case isMealsBaggageHeaderDisplay
    case isMealsBaggageenabled
    case isSMSVerificationTrue
    case defaultSortingOption     // 1 - Cheapest , 2 - Earliest, 3 - Fastest, 4 - Best
    case defaultSmartFilterOption // 0 - All flights , 1 - multiAirline, 2 - Non-multi
    case isToShowSmartFilters
    case isToShowGradientColor // true if we want to show gradient color else false
    case defaultDomDepartureDate
    case defaultIntDepartureDate
    case paymentBackButtonMsg
    case isToShowMulticityTab
    case ticketingDelayText
    case isHappyReviewFlow
    case isHappyReviewFlowOnly
    case smartEngageIndex
    case smartEngageSlots
    case isToShowSmartEngage
    case flightBundling
    case isToShowIPLEnrollmentButton
    case showFlightStatusCheck
    case isMSEFlow
    case setMSEFlowForAll
    case exclusiveFareText
    case addComboText
    case mseHeaderText
    case bundlingHeaderText
    case showNewIns


    //Trains
    case grPersuationTexts
    case grIntroPopUp
    case grOffers
    case grSharePNRMessage
    case grForgotPasswordURL
    case grIsNativeForgotPasswordEnabled
    case grIsNativeForgotUserNameEnabled
    case grForgotUserIdMessage
    case grBookingTimer
    case grIRCTCUserNameRegex
    case grIRCTCSecurityAnswerRegex
    case grIRCTCAddressRegex
    case grSignUpNameRegex
    case grTrainShareStausMessage
    case grTrainShareStausURL
    case grHideStatusShareBtn
    case grHideNotifyMeButton
    case grTrainStatusNotifyButtonText
    case grTrainStatusInfoButtonText
    case grTrainStatusDateChangePopUpTitle
    case grTrainStatusStationChangePopUpTitle
    case grTrainStatusStationChangePopUpSubTitle
    case grRetryBookingTitle
    case grRetryBookingURL
    case grRetryRailWebViewEnabled
    case grCleanMyCoachOptionDictionary
    case grCleanMyCoachTitle
    case grCleanMyCoachMessage
    case grTrainNumberCellText
    case grCalendarTitle
    case grClassChangeMessage
    case grClassChangeAlertTitle
    case grNumberOfMonthForCalendar
    case grIsClassSectionEnabled
    case grIsTrainNumberSectionEnabled
    case grTravellerScreenJourneyDetailMessage
    case grIRCTCSettingVCTitle
    case grIsIRCTCTrayEnabled
    case grCalendarHeaderInfoDictArray
    case grHomeTitleArray
    case grIsSrpFilterEnabled
    case grIsIrctcToolKitEnabled
    case grTrainWebViewShareMessage
    case grTrainStatusApiDelayTime
    case grIsCancellationProtectionEnabled
    case grCpDiffrenceCharges
    case grShowReviewPersuasion
    case grIsHappyReviewEnabled
    case grCpTutorialShownLimit
    case grShouldShowTravelCash
    case grIsPacEnabled
    case grIsPacV2Enabled
    case grIsDefaultGoCashOn
    case grIsPaymentHelpTYBtnEnabled
    case grIsPacNativePaymentFlowEnabled
    case grRecentPsngrCountLimit
    case grIsHappyTravellerEnabled
    case grHomeHeaderIconURL
    case grPacIssueUrl

    //Bus
    case busHomeRecentSearchLimit
    case busReviewGoCashDefaultEnabled
    case busSRPDefaultSorting
    case busSRPAmenities
    case busTrackDateOffset
    case busMaxAllowedBookingDays
    case busCategoryMessages
    case busSRPErrorCount
    case busDetailsTutorial
    case busSRPRatingColorCodes
    case busHire
    //CARS
    case showCarBookingTimeline
    case gcHomeLocateApiDelayInMs
    case gcPromoCodeAutoApply
    case gcPromoEnabled
    case gcHomeCardsRootFirebasePath
    case gcHomeLocationPopupEnabled
    case gcMinimumBookingTimeInMins
    case gcRegexForRealtime
    case gcHomeBanners
    case gcSrpHatchbackUrl
    case gcSrpSedanUrl
    case gcSrpSuvUrl
    case gcSrpBannerUrl
    case gcSrpRoundTripBannerUrl
    case gcSRPAmenitiesArray
    case gcSRPRoundTripAmenities
    case gcReviewChatEnabled
    case gcReviewChatParams
    case gcReviewTAndCSubTitle
    case gcAPIAuthString
    case gcPersuasionBanners
    case gcPersuasionBannersV2
    case gcPopularAirports
    case gcRecentSearchesLimit
    case gcFlightNumberPersuation
    case gcEnterFlightNumberTitle
    case gcEnterFlightPlaceholder
    case gcFlightRegex
    case gcCrossSellExpand
    case gcReviewCapFlightTitle
    case gcReviewCapFlightSubTitle
    
    
    //Business
    case gstRegex   // For GST Regex
    case businessnotverified   // For msg if user is not verified and not resend activate
    case businessnotverifiedResend // For msg if user is not verified and resend activate
    
    case businessemailnotValid // For msg if user email is not valid if enabled
    case businessemailnotValidEnabled // For display msg if user email is not valid

    case businessResendEnabled // For hide and show resend popup
    case buinessProfileInfo
    case showGOBizBanner
    case buinessProfileCreateAPPLaunch
    case isReactHotelsEnabledFromDB
    case isGOStaysBrandingEnabled
    case isExpencesManagerEnabled
    
    //QuickHelp
    case quickHelpUrl
    
    case eTicketDianaUrl
    case supportDianaUrl
    case eTicketQuickHelpUrl
    case supportQuickHelpUrl
    case isDianaSupportEnable
    case isDianaEticketEnable
    
    //MyBooking
    case ratingEnableStatus
    case ratingTimeDelay
    case validVerticals
    case isActivityTicketHidden
    case noNetworkText
    case apiFaliureText
    case paymnetFailedReasons
    case mybookingStatusMapping
    case crossSellEnabled
    
    //Home Screen
    case homeLob
    case homeLobData
    
    //UGC
    case writeReviewConcerns
    case shouldShowGoRooms
    case submitReviewMsg
    case csSubmitMessage
    case csSubmitActivityMessage
    case csNoQuestionErrorMessage
    case reviewGoCashPlus
    case locationSharedMessage
    case homeLocationTitle
    case homeLocationSubTitle
    case blockerTitle
    case videoGoCash
    case videoMaxTime
    case videoReviewEnabled
    case videoTags
    case reviewContexts
    case useNativeCamera
    case captivate
    case amenitiesList
    case goStaysBannerUrl
    case moneyBackNumber
    case callScreenText
    case notContactedText
    case mbMessageOne
    case mbMessageTwo
    case wrMessageOne
    case wrMessageTwo

    //
    case tezUPIType
    
    // Gocash
    case goCashTopUpOption
    case goCashThankYou
    case loadWalletDiscount
    case isLoadWalletEnable
    case upiIntents
    case upiIntentheading
    
    //Diana Profile
    case isDianaProfileEnable
    case dianaProfileText
    
    //MyBooking
    case myBookingSyncInterval
    case isMyBookingFirebaseEnable
    case isMyBookingAPIDateSelected
    case deeplinkParsingURLArray

    
    //Hotel
    case shouldBusinessDealBeDefaultForIH
    case panMessage
    case goStayBrandingImageUrl
    case shouldEnableHotelCancelReactFlow
    case goStaysAdVideo
    
    //Payment
    case supportedPaymentOptions
    case supportedPaymentOptionsV2
    case isPaymentV2Enable
    case paymentMethodValidation
    case saveCardHeaderTitle
    case paymentModeHeaderOption
    case savedPaymentHeaderText
    case goBackButtonMsg
    case shouldClearamazonBrowserCookies
    case shouldCallUPIDiscountAPI
    case isExpressEnable
    
    case enableTune
    case enableAppsFlyer
    case enableKeepSynch
    case enableNotificationKeepSynch
    
    //Local Notification
    case geoLocationsFirebasePath
    
    case enableLocalNotification
    case enableGeoLocalNotification
    
    
    //Whatapp
    case whatsapp_login_msg
    case whatsapp_msg
    case whatsapp_alert_title
    case whatsapp_alert_message
    case whatsapp_alert_continue
    case whatsapp_alert_cancel
    case whatsapp_optin_disable_flag
    case whatsapp_login_phone
    case whatsapp_login_abid
    case whatsapp_login_text
    case whatsapp_login_button_text
    case whatsappLoginEnabled
    case whatsappLoginTextReferral
    case whatsappAlreadyLoginAlertMsg
    case whatsappAlreadyLoginAlertCTA
    
    case enableDevFeatureForEmails
    case me_order
    case me_order_loggedin
    case rn_hotel_loader_text
    case rn_hotel_loader_delay
    case rn_hotel_loader_duration
    
    
//Go Config Keys
    
    case pricePersonalization
    case appsflyer_config_segment
    case fphHot
    case ccDigitsCount
    case intFlightCounter
    case intFph
    case isFlighReviewBlock
    case isAskText
    case showVariant2
    case showFareGraph
    case is_offer_upfront
    case rsv
    case domFlightCounter
    case verticalHint
    case maxApiRetry
    case maxApiRetryInterval
    case kUpcomingTripSkipItemList
    case callUsList
    case goOffers
    case inviteAll
    case srpOffersEnabled
    case busSessionTime
    case busSessionExpireMessage
    case myBookingActionConfig
    case thankYouAction
    case bookingPrivacyString
    case myBookingPagenation
    case myBookingEnablePrivacy
    case shouldSendCCDetails
    case privacyGoCashtext
    case retryMessagetext
    case gstDictionary
    case socialDictionary
    case enableBackPayu
    case setGcContactSync
    case isSegmentEnabled
    case isApiStatusTrackEnable
    case fbSegmentEventEnabled
    case contactBatchSize
    case webcheckinMessageKey
    case isExpandPaxDetailsEnable
     case scratchCardData
    case isHtmlOfferEnabled
//    case showReschedule

//Crowd Funding
    case cfBackGroundColor
    case cfHowItWorksArray
    case cfHowItWorksHeading
    case cfGiftItems
    case cfCreateTaskData
    case cfEnableDestinationSelection
    
    //Vault
    case vaultVoucherStatusColors
    
    
    //Feature DB keys
    case isFeatureEnable
    
    //Add KeyPath for firebase key
    public func description() -> String {
        switch self {
        case .callNumberError : return "core.callNumberError"
        case .isGIAClose : return "gia.closeGIA"
        case .isGIAIPL : return  "gia.isIPL"
            
        //Auth: - Sync Contacts Screen Titles
        case .syncGoContactsNewUser: return "syncGoContacts.newUser"
        case .syncGoContactsPreviouslySynced: return "syncGoContacts.previouslySynced"
        case .syncGoContactsneverSynced: return "syncGoContacts.neverSynced"
            
        //Auth:- OTP Screen
        case .wtsAppShowCount: return "otpScreen.wts_app_show_count"
        case .otpHeader: return "otpScreen.header"
            
        //Auth:- SignUp profile
        case .showFb: return "signUpProfileScreen.show_Fb_SignUp"
        case .signUpHeader: return "signUpProfileScreen.signUpHeader"
        case .signUpHeaderNewUI: return "signUpProfileScreen.signUpHeaderNewUI"
        case .signUpNameTitle:return "signUpProfileScreen.signUpNameTitle"

        //Auth:- Refer & Earn Screen
        case .reOffer: return "reScreen.offer"
        case .reDescription: return "reScreen.description"
        case .showOffer: return "reScreen.showOffer"
        case .shareReferral: return "reScreen.shareReferral"
        
        //Ipl
        case .iplBurnConfig: return "ipl"
        case .isIplEnabled : return "ipl.isEnabled"
        case .enableIplSubTitle : return "ipl.enableIplSubTitle"
        case .enableIplTitle : return "ipl.enableIplTitle"
        case .enableIplLeftkey : return "ipl.enableIplLeftkey"
        case .enableIplRightKey : return "ipl.enableIplRightKey"
        case .iplDownData : return "ipl.iplDownData"
        case .iplSettingsTitle : return "ipl.iplSettingsTitle"
        case .iplOnBoardingText : return "ipl.iplOnBoardingText"
        case .iplLockedData : return "ipl.iplLockedData"
        case .iplSmallBallEnabled : return "ipl.iplSmallBallEnabled"

        
        case .isIPLErrorState: return "ipl.isIPLErrorState"
        case .hideLoginSkipButton: return "core.hideLoginSkip"
        case .throttleTime: return "core.throttle"
            
            
        //core
        case .appVersions: return "core.appversions"
        case .scratchCardData : return "scratchCardData"
        case .enableAppVersionHandling: return "core.enable_firebase_app_version_handling_new"
        case .appUpdatePopupSkipAppVersions: return "core.update_skip_app_versions"
        case .enableGoContactRewards: return "core.eanble_reward"
        case .goContactTieringImageUrls: return "core.tierUrls"
        case .enableFreeSMS: return "core.enable_sms"
        case .freeSMSCtaText: return "core.sms_cta"
        case .disableNotificationAlert: return "core.disableNotificationBanner"//"core.disableNotificationAlert"
        case .goCashPlusUsageText: return "core.gc_usg_msg"
        case .gaDispatchTime: return "core.gaDispatchTime"
        case .forceUpdateText: return "core.update.fut"
        case .forceUpdateForAppVersions: return "core.update.fuv"
        case .forceUpdateForVerticalTags: return "core.update.fu_vt"
        case .newNotificationsUpdateTextData: return "core.update.u_vt_data"
        case .remoteConfigExpiryTime: return "core.remoteExpTime"
        case .disableTrell: return "core.disableTrell"
        case .notificationBannerColor: return "core.bannerColorHexCode"
        case .KeychainLogInEnabled : return "core.KeychainLogInEnabled"
        case .enablePigeonAPICallOnForeGround: return "pigeonCallEnabled"
        case .goEngageData: return "goEngage"
        case .cfBackGroundColor : return "cf.bgcolor"
        case .cfHowItWorksArray : return "cf.cfHowItWorksArray"
        case .cfHowItWorksHeading : return "cf.cfHowItWorksHeading"
        case .cfGiftItems: return "cf.gift"
        case .cfCreateTaskData : return "cf.cfCreateTaskData"
        case .cfEnableDestinationSelection: return "cf.enableDestionation"
        case .akmaiSDKEnable: return "enable_akmai"
            
        //Filo
        case .earnScreenData: return "earnPage"
        case .tierData: return "gocash.tier"
        case .dynamicTierData: return "gocash.dynamic_tier"
        case .goCash_faq : return "gocash.faq"
        case .goCash_howearn : return "gocash.howearn"
        case .goCash_filter : return "gocash.filter"
        case .goCash_infoText : return "gocash.text.infoText"
        case .goCash_action: return "gocash.gch_action"
        case .goCash_notLoggeIn: return "gocash.notloggedin"
        case .goCash_reward: return "gocash.reward"
        case .signinRewardIntro: return "tierPopup.signin"
        case .appUpdateRewardIntro: return "tierPopup.appUpdate"
        case .signupRewardIntro: return "tierPopup.signup"
        case .upgradeRewardPopup: return "tierPopup.upgrade"
        case .upgradeTierDays : return "tierPopup.upgradeTierDays"
        case .xTimeToShowTutorial: return "home.xTimeToShowTutorial"
        case .showUpComingBookingCardOnHome: return "home.showUpcomingBookingCard"
        case .relaunchEarnScreenInDays: return "home.earn_vis_days"
        case .enableGoogleMapAPIKeyInUrl: return "home.send_google_apikey"
        case .googleMapAPIKey: return "home.googlemap_apikey"
        case .googlePlacesAPIKey: return "home.googleplaces_apikey"
        case .addMoneyTextData: return "gocash.wallet"
        case .homeRecentSearchesLimit: return "home.recentSearchesLimit"
        case .homeStatesPositions: return "home.homeStatesPositions"
            
        //Collaborative
        case .enablePlanAutoCreateOnSRP: return "core.cl.enable_plan_autocreate_srp"
        case .collaborativeMessages: return "core.cl.msgs"
        case .groupDealOfferTitle: return "core.cl.deal_title"
        case .groupDealOfferUrl: return "core.cl.deal_url"
        //Ola
        case .staticLoaderTimeForOla: return "core.olaUrls.loaderTime"
        
        case .enableTune: return "core.enableTune"
        case .enableAppsFlyer: return "core.enableAppsFlyer"
            
        //Onboarding
        case .onboarding: return "core.onboarding"
        case .enableSecureAccountDisplay: return "core.onboarding.sa_display"
        case .clearCookieOnLogin: return "core.onboarding.clear_Cookie"
        case .onboardingSyncScreenShown: return "onboarding.enable_sync_new" //onboarding.enable_sync
        case .onboardingSynchCTAs: return "onboarding.congratsScreen.ctas"
        case .onboardingWelcomeTutorial: return "onboarding.welcome.list"
        case .onboardingInstallSourceTutorial : return "onboarding.welcome.sourceList"
        case .onboardingGoCashInfoShow: return "onboarding.congratsScreen.showInfo"
            
        // Social
        case .social: return "social"
        case .socialContactListTitle: return "social.t_s_title"
        case .socialContactListSubTitle: return "social.t_s_subtitle"
        case .socialgoCashInviteTitle: return "social.gocash_Invite_title"
        case .socialgoCashInviteSubTitle: return "social.gocash_Invite_subtitle"
        case .isAskGoCashHidden: return "social.isAskGoCashHidden"
        case .isGiftGoCashHidden: return "social.isGiftGoCashHidden"
        case .isTopUpGoCashHidden: return "social.isTopUpGoCashHidden"
            

        case .isFlightsShowBusineessLayOver: return "flights.is_flights_show_businees_layover"
        case .socialSettingsDisableSyncMsg: return "social.s_d_s_alert"
        //goHomes
        case .goHomeAmenitiesMap: return "gohomes.gohomes_amenities_mapping"

        case .gstMetaData: return "core.GST.metaData"
        case .getFlightBusinessDealData: return "flights.fl_bp_offer"
        case .contactSyncMessageOnTop: return "social.gcMessageInfoNew"
        case .contactSyncMessageDetails: return "social.gcMessageInfoDetail"
            
        
        //Business Profile
        case .businessnotverified: return "core.businessprofile.profilechangeerror"
        case .businessnotverifiedResend: return "core.businessprofile.profilechangeerrorResend"
        case .gstRegex: return "core.businessprofile.gstRegex"
        case .businessemailnotValid: return "core.businessprofile.profileemailinvalid"
        case .businessResendEnabled: return "core.businessprofile.profileResendlink"
        case .businessemailnotValidEnabled : return "core.businessprofile.pemailinvalidEnabled"
        case .buinessProfileInfo: return "core.businessprofile.buinessProfileInfo"
        case .showGOBizBanner: return "hotels.show_bp_popup_srp"
        case .buinessProfileCreateAPPLaunch: return "core.businessprofile.bpcreateEnabled"
        case .isReactHotelsEnabledFromDB: return "hotels.react_funnel_enabled"
        case .isGOStaysBrandingEnabled: return "hotels.isGOStaysBrandingEnabled"
        case .recommendedConactLimit: return "social.rc"
        case .isExpencesManagerEnabled: return "core.businessprofile.isExpenseManagerEnabled"
            
        //Flights
        case .flightMsgPackStatus: return "flights.ismsgpck"
        case .isAutoRegisterFareAlerts: return "flights.isregisteralerts"
        case .isMealsBaggageHeaderDisplay: return "flights.is_meals_baggage_header_display"
        case .isMealsBaggageenabled: return "flights.is_meal_baggage_header_enabled_new_a"
        case .isSMSVerificationTrue: return "flights.is_sms_verification_true"
        case .defaultSortingOption: return "flights.default_sorting_option"
        case .defaultSmartFilterOption: return "flights.default_smart_filter_option"
        case .isToShowSmartFilters: return "flights.is_smart_filters_enabled"
        case .isToShowGradientColor: return "flights.show_gradient_color"
        case .defaultDomDepartureDate: return "flights.default_dom_departure_date"
        case .defaultIntDepartureDate: return "flights.default_int_departure_date"
        case .paymentBackButtonMsg: return "flights.payment_back_button_msg"
        case .isToShowMulticityTab: return "flights.is_multicity_enabled"
        case .ticketingDelayText: return "flights.ticketingDelayText"
        case .isHappyReviewFlow: return "flights.is_Happy_Review_New_Version"
        case .isHappyReviewFlowOnly: return "flights.is_Happy_Review_Only_New"
        case .smartEngageIndex: return "flights.smart_Engage_Index"
        case .smartEngageSlots: return "flights.smart_Engage_Slots"
        case .isToShowSmartEngage: return "flights.is_Smart_Engage_Enabled"
        case .flightBundling: return "flights.flight_bundling"
        case .isToShowIPLEnrollmentButton: return "flights_is_IPL_Enroll_Enabled"
        case .showFlightStatusCheck: return "flights.showFlightStatusCheck"
        case .isMSEFlow: return "flights.is_mse_flow"
        case .setMSEFlowForAll: return "flights.set_mse_for_all"
        case .exclusiveFareText: return "flights.exclusive_fare_text"
        case .addComboText: return "flights.add_combo_text"
        case .mseHeaderText: return "flights.mse_header_text"
        case .bundlingHeaderText: return "flights.bundling_header_text"
        case .showNewIns: return "flights.show_new_ins"

        //Trains
        case .grPersuationTexts : return "gorails.persuation_texts"
        case .grIntroPopUp :  return "gorails.intro_popup"
        case .grOffers: return "gorails.banners"
        case .grSharePNRMessage: return "gorails.share_pnr_m"
        case .grForgotPasswordURL: return "gorails.frgt_pwd_url"
        case .grIsNativeForgotPasswordEnabled: return "gorails.native_frgt_pwd_e"
        case .grIsNativeForgotUserNameEnabled: return "gorails.native_frgt_usrid_e"
        case .grForgotUserIdMessage: return "gorails.frgt_usrid_msg"
        case .grBookingTimer: return "gorails.booking_timer"
        case .grIRCTCUserNameRegex: return "gorails.username_regex"
        case .grIRCTCSecurityAnswerRegex: return "gorails.securityAnswer_regex"
        case .grIRCTCAddressRegex: return "gorails.IRCTCAddress_regex"
        case .grSignUpNameRegex: return "gorails.grSignUpNameRegex_regex"
        case .grTrainShareStausMessage : return "gorails.trainStatus.shareMessage"
        case .grTrainShareStausURL : return "gorails.trainStatus.shareURL"
        case .grHideStatusShareBtn : return "gorails.trainStatus.hideShareButton"
        case .grHideNotifyMeButton : return "gorails.trainStatus.grHideNotifyMeButton"
        case .grTrainStatusNotifyButtonText : return "gorails.trainStatus.grTrainStatusNotifyButtonText"
        case .grTrainStatusInfoButtonText : return "gorails.trainStatus.grTrainStatusInfoButtonText"
        case .grTrainStatusDateChangePopUpTitle : return "gorails.trainStatus.grTrainStatusDateChangePopUpTitle"
        case .grTrainStatusStationChangePopUpTitle : return "gorails.trainStatus.grTrainStatusStationChangePopUpTitle"
        case .grTrainStatusStationChangePopUpSubTitle : return "gorails.trainStatus.grTrainStatusStationChangePopUpSubTitle"
        case .grRetryBookingTitle : return "gorails.retry.title"
        case .grRetryBookingURL : return "gorails.retry.url"
        case .grRetryRailWebViewEnabled : return "gorails.retry.railWebViewEnabled"
        case .grCleanMyCoachOptionDictionary : return "cleanMyCoach.optionDictionary"
        case .grCleanMyCoachTitle : return "gorails.cleanMyCoach.title"
        case .grCleanMyCoachMessage : return "gorails.cleanMyCoach.message"
        case .grTrainNumberCellText : return "trainNumber.cellText"
        case .grCalendarTitle : return "calendar.title"
        case .grClassChangeMessage : return "calendar.classTitle"
        case .grClassChangeAlertTitle : return "calendar.classTitle"
        case .grNumberOfMonthForCalendar : return "calendar.numberOfMonthForCalendar"
        case .grHomeHeaderIconURL: return "home.h_icon_url"
        case .grIsClassSectionEnabled : return "bookingInfo.classSectionEnabled"
        case .grIsTrainNumberSectionEnabled : return "bookingInfo.trainNumberSectionEnabled"
        case .grTravellerScreenJourneyDetailMessage : return "traveller.journeyDetailMessage"
        case .grIRCTCSettingVCTitle : return "irctcSetting.title"
        case .grIsIRCTCTrayEnabled : return "irctcSetting.isEnabled"
        case .grCalendarHeaderInfoDictArray : return "calendar.headerInfoDictArray"
        case .grHomeTitleArray : return "home.headerTiteArray"
        case .grIsSrpFilterEnabled : return "srp.isFilterEnabled"
        case .grIsIrctcToolKitEnabled : return "webView.isToolkitEnabled"
        case .grTrainWebViewShareMessage : return "gorails.webview.shareMessage"
        case .grTrainStatusApiDelayTime : return "webView.delayTime"
        case .grIsCancellationProtectionEnabled : return "isCancellationProtectionEnabled"
        case .grCpDiffrenceCharges : return "grCpDifferenceCharges"
        case .grShowReviewPersuasion : return "review.grIsPersuasionEnabled"
        case .grIsHappyReviewEnabled : return "review.isHappyReviewEnabled"
        case .grCpTutorialShownLimit : return "grCpTutorialShownLimit"
        case .grShouldShowTravelCash : return "grShouldShowTravelCash"
        case .grIsPacEnabled : return "isPacEnabled"
        case .grIsPacV2Enabled : return "isPacv2Enabled"
        case .grIsDefaultGoCashOn : return "isDefaultGoCashOn"
        case .grIsPaymentHelpTYBtnEnabled : return "isPaymentHelpTYBtnEnabled"
        case .grIsPacNativePaymentFlowEnabled : return "grIsPacNativePaymentFlowEnabled"
        case .grRecentPsngrCountLimit : return "grRecentPsngrCountLimit"
        case .grIsHappyTravellerEnabled : return "grIsHappyTravellerEnabled"
        case .grPacIssueUrl : return "grPacIssueUrl"
            
        //Bus
        case .busHomeRecentSearchLimit: return "bus.h_rs_l"
        case .busReviewGoCashDefaultEnabled: return "bus.gc_d_s"
        case .busSRPDefaultSorting: return "bus.srp.d_s"
        case .busSRPAmenities: return "bus.srp_amenities"
        case .busTrackDateOffset: return "bus.track_dt_offset"
        case .busMaxAllowedBookingDays: return "bus.max_b_days"
        case .busCategoryMessages: return "bus.cat_selection.cat_msg"
        case .busDetailsTutorial: return "bus.product_detail.tutorial"
        case .busSRPErrorCount: return "bus.srp.error_count"
        case .busSRPRatingColorCodes: return "bus.srp.rating_color_codes"
        case .busHire: return "bus.isBusHireEnabled"

        //Cars
        case .gcHomeLocateApiDelayInMs: return "gocars.gc_h_lct_api_d"
        case .showCarBookingTimeline : return "gocars.ty_stl"
        case .gcPromoCodeAutoApply: return "gocars.gc_prm_cd"
        case .gcPromoEnabled: return "gocars.gc_prm_e"
        case .gcHomeCardsRootFirebasePath: return "gocars.gc_h_cards_rp"
        case .gcHomeLocationPopupEnabled: return "gocars.gc_h_lct_popup_e"
        case .gcMinimumBookingTimeInMins: return "gocars.min_booking_time_mins"
        case .gcRegexForRealtime: return "gocars.home.real_time_booking"
        case .gcHomeBanners: return "gocars.home.banners"
        case .gcSrpHatchbackUrl: return "gocars.srp.hatchback_url"
        case .gcSrpSedanUrl: return "gocars.srp.sedan_url"
        case .gcSrpSuvUrl: return "gocars.srp.suv_url"
        case .gcSrpBannerUrl: return "gocars.srp.banner_url"
        case .gcSrpRoundTripBannerUrl: return "gocars.srp.rt_banner_url"
        case .gcSRPAmenitiesArray: return "gocars.srp.amenities"
        case .gcSRPRoundTripAmenities: return "gocars.srp.rt_amenities"
        case .gcReviewChatEnabled: return "gocars.review.chat_e"
        case .gcReviewChatParams: return "gocars.review.chat_params"
        case .gcReviewTAndCSubTitle: return "gocars.review.tnc_st"
        case .gcAPIAuthString: return "gocars.gc_auth"
        case .gcPersuasionBanners: return "home.persuasion"
        case .gcPersuasionBannersV2 : return "gocars.persuationV2"
        case .gcPopularAirports: return "gocars.popular_airports"
        case .gcRecentSearchesLimit: return "gocars.as_rs_lmt"
        case .gcFlightNumberPersuation : return "gocars.flightNumberPersuation"
        case .gcEnterFlightNumberTitle : return "gocars.gcEnterFlightNumberTitle"
        case .gcEnterFlightPlaceholder : return "gocars.gcEnterFlightNumberTitle"
        case .gcFlightRegex : return "gocars.gcFlightRegex"
        case .gcCrossSellExpand : return "gcCrossSellExpand"
        case .gcReviewCapFlightTitle : return "gcReviewCapFlightTitle"
        case .gcReviewCapFlightSubTitle : return "gcReviewCapFlightSubTitle"
        
        //QuickHelp
        case .quickHelpUrl: return "core.quickhelp_url"
            
        case .eTicketDianaUrl: return "core.quickHelp.diana_eTicket_url"
        case .supportDianaUrl: return "core.quickHelp.diana_support_url"
        case .eTicketQuickHelpUrl: return "core.quickHelp.quickHelp_eTicket_url"
        case .supportQuickHelpUrl: return "core.quickHelp.quickhelp_url"
        case .isDianaSupportEnable: return "core.quickHelp.isonlysupportquickhelp_off"
        case .isDianaEticketEnable: return "core.quickHelp.isonlyeticketquickhelp_off"
            
        //MyBooking
        case .ratingEnableStatus: return "core.ratingEnableStatus"
        case .ratingTimeDelay: return "core.ratingTimeDelay"
        case .validVerticals: return "core.MyBookingsv2.validVerticals"
        case .isActivityTicketHidden: return "core.MyBookingsv2.isActivityTicketHidden"
        case .noNetworkText : return "core.MyBookingsv2.noNetworkText"
        case .apiFaliureText : return "core.MyBookingsv2.apiFaliureText"
        case .paymnetFailedReasons : return "MyBooking.ThanksYou.PaymentFailed.fcode_list"
        case .mybookingStatusMapping: return "MyBooking.MyBookingStatusMapping"
        case .crossSellEnabled: return "MyBooking.enableCrossSell"
            
        //Home Screen
        case .homeLob: return "home.homeLobOrder_1"
        case .homeLobData: return "home.homeLobData"

        //UGC
        case .writeReviewConcerns: return "ugc.wr.concerns"
        case .shouldShowGoRooms: return "ugc.enableGoRooms"
        case .submitReviewMsg: return "ugc.submitReviewMsg"
        case .csSubmitMessage: return "cs.submitMessage"
        case .csSubmitActivityMessage: return "cs.submitActivityMessage"
        case .csNoQuestionErrorMessage: return "cs.noQuestionErrorMessage"
        case .reviewGoCashPlus: return "ugc.reviewGoCashPlus"
        case .homeLocationTitle: return "ugc.homeLocationTitle"
        case .homeLocationSubTitle: return "ugc.homeLocationSubTitle"
        case .locationSharedMessage: return "ugc.locationSharedMessage"
        case .carReviewPopup: return "ugc.carReviewPopup"
        case .blockerTitle: return "ugc.blockerTitle"
        case .videoGoCash: return "videoGoCash"
        case .videoMaxTime: return "videoMaxTime"
        case .videoReviewEnabled: return "videoReviewEnabled"
        case .videoTags: return "videoTags"
        case .reviewContexts: return "reviewContext"
        case .useNativeCamera: return "useNativeCamera"
        case .captivate: return "switchCaptivate"
        case .amenitiesList: return "amenitiesList"
        case .goStaysBannerUrl: return "strings.mbg.page_url"
        case .moneyBackNumber: return "strings.mbg.phoneNumber"
        case .callScreenText: return "strings.mbg.call_screen_txt"
        case .notContactedText: return "strings.mbg.contact_no_txt"
        case .mbMessageOne: return "strings.mbg.mswrMessageOnegTop"
        case .mbMessageTwo: return "strings.mbg.wrMessageTwo"
        case .wrMessageOne: return "strings.wrMessageOne"
        case .wrMessageTwo: return "strings.wrMessageTwo"
            
            
        //MyBooking
        case .myBookingSyncInterval : return "core.myBooking_syncInterval_New"
        case .isMyBookingFirebaseEnable : return "core.isMyBookingFirebaseEnable"
        case .isMyBookingAPIDateSelected : return "core.isMyBookingAPIDateSelected"
        case .deeplinkParsingURLArray : return  "deeplink.parsingurl"
            
        //Hotel
        case .shouldBusinessDealBeDefaultForIH: return "isBusinessSelected"
        case .panMessage: return "panInfoMessage"
        case .goStayBrandingImageUrl: return "hotels.gostaybrandimageurl"
        case .shouldEnableHotelCancelReactFlow: return "hotel.is_cncl_rct_flw_enbld"
        case .goStaysAdVideo: return "hotels.goStaysAdVideo"
            
        //TEZ
        case .tezUPIType: return "core.Payment.tezUPIType"
        //Gocash
        case .goCashTopUpOption: return "gocash.topUpOption"// old path "core.goCash.topUpOption"
        case .goCashThankYou: return "core.goCash.ThankYou"
        case .loadWalletDiscount: return "core.goCash.loadWalletDiscount"
        case .isLoadWalletEnable: return "gocash.isLoadWalletEnable" // old path "core.goCash.isLoadWalletEnable"
        
        //Daina Profile
        case .isDianaProfileEnable: return "core.Diana.isEnable"
        case .dianaProfileText: return "core.Diana.dianaText"
        
        //Payment
        case .supportedPaymentOptions: return "payment.paymentOptions"
        case .supportedPaymentOptionsV2: return "payment.supportedPaymentOptionsV2"
        case .isPaymentV2Enable: return "payment.isPaymentV2Enable"
        case .paymentMethodValidation: return "payment.needToValidate"
        case .saveCardHeaderTitle: return "payment.saveCardHeaderTitle"
        case .paymentModeHeaderOption: return "payment.paymentModeHeaderOption"
        case .savedPaymentHeaderText: return "payment.savedPaymentHeaderText"
        case .goBackButtonMsg: return "payment.goBackButtonMsg"
        case .shouldClearamazonBrowserCookies: return "payment.shouldClearamazonBrowserCookies"
        case .upiIntents: return "payment.upintent"
        case .upiIntentheading: return "payment.upintentHeading"
        case .shouldCallUPIDiscountAPI : return "payment.shouldCallUPIDiscountAPI"
        case .isExpressEnable : return "payment.isExpressEnable"
            

        //Local Notification 
        case .geoLocationsFirebasePath : return "core.notificationpath"
            
        case .enableLocalNotification: return "core.enableLocalNotif"
        case .enableGeoLocalNotification: return "core.enableLocalGeoNotif"
        case .enableKeepSynch: return "core.enableKeepSync"
        case .enableNotificationKeepSynch: return "core.enableNotifKeepSync"
        //Whatapp
        case .whatsapp_login_msg: return "onboarding.whatsapp.msg"
        case .whatsapp_msg: return "whatsapp.msg"
        case .whatsapp_alert_title: return "whatsapp.alert.title"
        case .whatsapp_alert_message: return "whatsapp.alert.message"
        case .whatsapp_alert_continue: return "whatsapp.alert.continue"
        case .whatsapp_alert_cancel: return "whatsapp.alert.cancel"
        case .whatsapp_optin_disable_flag: return "whatsapp.optin.disable"
        case .whatsapp_login_phone: return "onboarding.whatsapp.phone"
        case .whatsapp_login_abid: return "onboarding.whatsapp.abid"
        case .whatsapp_login_text: return "onboarding.whatsapp.text"
        case .whatsappLoginTextReferral: return "onboarding.whatsapp.rText"
        case .whatsappAlreadyLoginAlertMsg: return "onboarding.whatsapp.alreadyLoginAlertMsg"
        case .whatsappAlreadyLoginAlertCTA: return "onboarding.whatsapp.alreadyLoginAlertCTA"
        case .whatsapp_login_button_text: return "onboarding.whatsapp.buttonTitle"
        case .whatsappLoginEnabled: return "onboarding.whatsapp.enable"
          
        case .enableDevFeatureForEmails: return "developer.emails"
        case .me_order: return "me.order"
        case .me_order_loggedin: return "me.orderloggedin"
            
        case .pricePersonalization : return "price_personalization"
        case .appsflyer_config_segment : return "appsflyer_config_segment"
        case .is_offer_upfront : return "is_offer_upfront"
        case .rsv : return "rsv"
        case .domFlightCounter : return "dom_flight_counter"
        case .fphHot : return "fph_hot"
        case .ccDigitsCount : return "cc_digits_count"
        case .intFlightCounter : return "int_flight_counter"
        case .intFph  : return "int_fph"
        case .isFlighReviewBlock : return "is_fl_rv_blk"
        case .isAskText : return "is_ask_text"
        case .showVariant2 : return "showVariant2"
        case .showFareGraph : return "showFareGraph"
        case .verticalHint : return "vertical_hint"
        case .maxApiRetry : return "max_api_retry"
        case .maxApiRetryInterval : return "max_api_retry_interval"
        case .kUpcomingTripSkipItemList : return "h_st_d"
        case .callUsList : return "crm.callus"
        case .goOffers : return "offer.fd2"
        case .inviteAll : return "invite_all"
        case .srpOffersEnabled : return "fph.srp_offer_enabled"
        case .busSessionTime : return "bus.busSessionTime"
        case .busSessionExpireMessage : return "bus.busSessionExpireMsg"
        case .myBookingActionConfig : return "core.MyBookingsv2.actions_config"
        case .thankYouAction : return "core.thankyou_actionsv2"
        case .bookingPrivacyString : return "core.booking_Privacy_Strings"
        case .myBookingPagenation : return "core.mybooking_pagination"
        case .myBookingEnablePrivacy : return "core.mybooking_enable_privacy_all"
        case .shouldSendCCDetails : return "core.shouldSendCCDetail"
        case .privacyGoCashtext : return "core.privacy_gocash_text"
        case .retryMessagetext: return "core.retryMessagetext"
        case .gstDictionary : return "core.GST"
        case .socialDictionary : return "social"
        case .enableBackPayu : return "core.enable_back_payu_review"
        case .setGcContactSync : return "core.gc_gift_contactSyncoff_msg"
        case .isSegmentEnabled : return "is_segement_enable"
        case .isApiStatusTrackEnable : return "is_api_status_track_enable"
        case .fbSegmentEventEnabled : return "is_fb_segement_event_enable"
        case .contactBatchSize : return "contactbatchsize"
        case .webcheckinMessageKey : return "webcheckin_message_key"
        case .isExpandPaxDetailsEnable : return "is_expand_pax_details_enable"
        case .isHtmlOfferEnabled: return "is_html_offer_enabled"
//        case .showReschedule : return "show_reschedule"
        case .rn_hotel_loader_text: return "rn_hotel_loader_text"
        case .rn_hotel_loader_delay :     return "rn_hotel_loader_delay"
        case .rn_hotel_loader_duration : return "rn_hotel_loader_duration"
            
        //Vault
        case .vaultVoucherStatusColors: return "vlt.vchr.status_colr"
            
            
        case .isFeatureEnable: return "hotel.isFeatureEnabled"
        
        }
    }
    
    //Default Value for Key
    public func defaultValue() -> Any {
        switch self {
        case .callNumberError : return "This feature is not supported by this device"
        case .isGIAClose : return false
        case .isGIAIPL : return false
            
        //Auth: - Sync Contacts Screen Titles
        case .syncGoContactsNewUser: return DefaultValueProvider.getUserConfirmationValuesforNewUser()
        case .syncGoContactsPreviouslySynced: return DefaultValueProvider.getUserConfirmationValuesforPreviouslySynced()
        case .syncGoContactsneverSynced: return DefaultValueProvider.getUserConfirmationValuesforNeverSynced()
            
        //Auth:- OTP Screen
        case .wtsAppShowCount: return 2
        case .otpHeader: return "Enter 4-digit OTP sent to"
            
        //Auth:- Refer & Earn Screen
        case .reOffer: return DefaultValueProvider.getReferAndEarnOffer()
        case .reDescription: return DefaultValueProvider.getReferAndDescription()
        case .showOffer: return false
        case .shareReferral: return DefaultValueProvider.getReferAndEarnShare()
            
            //Auth:- UserSignUp profile
        case .showFb: return false
        case .signUpHeader: return "Welcome! \n Complete your profile"
        case .signUpHeaderNewUI: return "One last thing.."
        case .signUpNameTitle:return "What do we call you?"
            
        //Ipl
        case .iplBurnConfig: return [:]
        case .isIplEnabled : return false
        case .enableIplSubTitle : return "Do you want to enroll to Travel Cash Fest?"
        case .enableIplTitle : return ""
        case .enableIplLeftkey : return "Yes"
        case .enableIplRightKey : return "Cancel"
        case .iplDownData : return ["buttonTitle" : "GO BACK","subTitle" : "Please try again after sometime","title" : "Oops! Something went wrong"]
        case .iplSettingsTitle : return "Enroll to Travel Cash Fest"
            
        case .isIPLErrorState: return false
        case .hideLoginSkipButton: return true
        case .throttleTime: return ["default" : "30"]
            
        //core
        case .scratchCardData : return DefaultValueProvider.getScratchCardTaskData()
        case .appVersions: return []
        case .enableAppVersionHandling: return false
        case .appUpdatePopupSkipAppVersions: return [""] //["667"]
        case .enableGoContactRewards: return true
        case .goContactTieringImageUrls: return ["1":"https://gos3.ibcdn.com/bronze-1533126956.png", "2":"https://gos3.ibcdn.com/silver-1533127009.png", "3":"https://gos3.ibcdn.com/gold-1533127076.png", "4":"https://gos3.ibcdn.com/platinum-1533127030.png", "5":"https://gos3.ibcdn.com/titanium-1533127055.png" ]
        case .enableFreeSMS: return false
        case .freeSMSCtaText: return "Invite Using Free SMS"
        case .disableNotificationAlert: return false
        case .goCashPlusUsageText: return ""
        case .gaDispatchTime: return 20
        case .forceUpdateText: return "This version is not supported. Please update your app to latest version"
        case .akmaiSDKEnable: return false
        case .forceUpdateForAppVersions: return []//["6.6.2"]
        case .forceUpdateForVerticalTags: return [:]//["301":["msg":"Bus is not suported","versions":["6.6.3"]]]
        case .newNotificationsUpdateTextData: return ["gnr":"This feature is not supported in your app, please update your app"]//["gnr":"This feature is not supported in your app, please update your app","742":"742 tag is not supported","skip_tag":["743"]]
        case .remoteConfigExpiryTime: return 60 //Integer value(Time in minutes)
        case .disableTrell: return false
        case .notificationBannerColor: return "#2E69B3"
        case .KeychainLogInEnabled : return true
        case .enablePigeonAPICallOnForeGround: return true
        case .goEngageData: return [String:Any]()
        
        case .cfBackGroundColor : return "#2276e3"
        case .cfHowItWorksArray : return DefaultValueProvider.getCFHowItWorkSData()
        case .cfHowItWorksHeading : return "How it works"
        case .cfGiftItems: return DefaultValueProvider.getCfGiftItemData()
        case .cfCreateTaskData : return DefaultValueProvider.getCFCreateeTaskData()
        case .cfEnableDestinationSelection: return true
        case .carReviewPopup: return true
        
        //Ola
        case .staticLoaderTimeForOla: return 4

        case .isReactHotelsEnabledFromDB: return false
        case .isGOStaysBrandingEnabled: return true
            
        //Filo
        case .earnScreenData: return [:]
        case .tierData: return DefaultValueProvider.defaultTierValues()
        case .dynamicTierData: return DefaultValueProvider.defaultTierValues()
        case .goCash_faq: return DefaultValueProvider.defaultGoCashFaqValues()
        case .goCash_howearn : return DefaultValueProvider.defaultGoCashHowToEarnValues()
        case .goCash_filter : return DefaultValueProvider.defaultGoCashFilterValues()
        case .goCash_infoText : return "Credits is the part of Goibibo Wallet which has usage restrictions. The exact amount of credits applicable on a particular booking will be known to you in the fare breakup while making your Flight, Hotel, Bus or Cab booking."
        case .goCash_action: return DefaultValueProvider.defaultGoCashActionValues()
        case .goCash_notLoggeIn: return DefaultValueProvider.defaultGoCashGuestStateValues()
        case .goCash_reward: return DefaultValueProvider.defaultGoCashRewardsValues
        case .signupRewardIntro: return DefaultValueProvider.defaultSignupRewardsIntro()
        case .upgradeRewardPopup: return DefaultValueProvider.defaultUpgradeRewards()
        case .signinRewardIntro: return DefaultValueProvider.defaultSignInRewards()
        case .appUpdateRewardIntro: return DefaultValueProvider.defaultAppUpgradeRewards()
        case .upgradeTierDays: return  5
        case .xTimeToShowTutorial: return 10
        case .showUpComingBookingCardOnHome: return false
        case .relaunchEarnScreenInDays: return 7
        case .enableGoogleMapAPIKeyInUrl: return true
        case .googleMapAPIKey: return "AIzaSyB2yjrZLY7hO2mFpeJR84XQU7aRck3OvGc"
        case .googlePlacesAPIKey: return "AIzaSyCF3Hs9v56feDPHFld_a3c4A8FIIu51mKk"
        case .addMoneyTextData: return [String:Any]()
        case .homeRecentSearchesLimit: return DefaultValueProvider.getDefaultHomeRecentSearchesLimit()
        case .homeStatesPositions: return DefaultValueProvider.getDefaultHomeStatePositions()
            
        //Collaborative
        case .enablePlanAutoCreateOnSRP: return true
        case .collaborativeMessages: return ["p_t": "Plan Members", "p_st": "Add friends to the plan and get great value deals.", "cl_rm": "The host removed you from the plan. You will not be able to see the details.", "cl_rm_t": "Uh Oh!!"]
        case .groupDealOfferTitle: return "Group Deal- Get 50 gocash+/Traveller"
        case .groupDealOfferUrl: return "https://www.goibibo.com/info/group-booking/"
            
        //Onboarding
        case .onboarding: return DefaultValueProvider.getOnboardingValues()
        case .enableSecureAccountDisplay: return false
        case .clearCookieOnLogin: return true
        case .onboardingSyncScreenShown: return true
        case .onboardingSynchCTAs: return []
        case .onboardingGoCashInfoShow: return false
        case .onboardingWelcomeTutorial: return  DefaultValueProvider.getDefaultOnboardingWelcomeData()
        case .onboardingInstallSourceTutorial: return DefaultValueProvider.getDefaultOnboardingInstallSourceWelcomeData()
        case .iplOnBoardingText : return DefaultValueProvider.getDefaultOnboardingWelcomeDataForIpl()
        case .iplLockedData : return ["tg":1503,"nkey":"wallet_locked"]
        case .iplSmallBallEnabled : return true
            
        // Social
        case .social: return DefaultValueProvider.getSocialValues()
        case .socialContactListTitle: return "Earn from your phone book contacts"
        case .socialContactListSubTitle: return ""
        case .socialgoCashInviteTitle: return "Connect & Earn "
        case .socialgoCashInviteSubTitle: return "Invite your contacts and earn ₹100 goCash+ when they complete their first travel. Your contact earns ₹150 goCash+. Earn ₹25 goCash+ everytime they travel."
        case .isAskGoCashHidden: return false
        case .isGiftGoCashHidden: return false
        case .isTopUpGoCashHidden: return false

            
        case .isFlightsShowBusineessLayOver: return true
        case .socialSettingsDisableSyncMsg: return "Sync your phonebook to earn goCash+ instantly every time your contacts book"
        case .goHomeAmenitiesMap: return DefaultValueProvider.getgoHomeAmenitiesMap()
        case .gstMetaData: return []
        case .getFlightBusinessDealData : return ["":""]
        case .contactSyncMessageOnTop: return ["bgcolor":"#fffbc9","btnInfo":["title":"Know More "],"msgs":[["text":"Why do I see these trips?", "font": "regular","textcolor":"#333333","fontsize":16]]] //,"textColor":"#ffffff","bgColor":"#FF6421"
            
        case .contactSyncMessageDetails: return ["bgcolor":"#ffffff","msgs":[["text":"Your contacts have agreed to share these trips", "font": "semibold","textcolor":"#333333","fontsize":15,"alignment":"center"], ["text":"\n\n\nYou can manage your privacy settings from Trips section.", "font": "regular","textcolor":"#333333","fontsize":14,"alignment":"center"]]]
        
        //Business Profile
        case .gstRegex: return "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"
        case .businessnotverified: return "Your business profile is not activated. Please verify your email."
        case .businessnotverifiedResend: return "Your business profile is not activated. Please verify your email. Do you want we send a verify link?"
        case .businessemailnotValid: return "Please provide your valid business email in profile section."
        case .businessResendEnabled: return true
        case .businessemailnotValidEnabled: return true
        case .buinessProfileInfo: return "<b><center>Your business profile is not activated. Please verify your email.</center></b>"
        case .showGOBizBanner: return true

        case .buinessProfileCreateAPPLaunch: return true

        case .recommendedConactLimit: return 30
        case .isExpencesManagerEnabled: return true
            
        //Flight
        case .flightMsgPackStatus: return true
        case .isAutoRegisterFareAlerts: return false
        case .isMealsBaggageHeaderDisplay: return true
        case .isMealsBaggageenabled: return true
        case .isSMSVerificationTrue: return true
        case .defaultSortingOption: return 4
        case .defaultSmartFilterOption: return 2
        case .isToShowSmartFilters: return true
        case .isToShowGradientColor: return true
        case .defaultDomDepartureDate: return 7
        case .defaultIntDepartureDate: return 14
        case .paymentBackButtonMsg: return "We won't be able to hold this ticket price if you go back. The prices for this flight might increase."
        case .isToShowMulticityTab: return true
        case .ticketingDelayText: return  "Once the payment is done ticket will be issued within %s. \n In case there is a delay in ticketing we will keep you updated. \n Be rest assured you will get Guaranteed Seats for this flight."
        case .isHappyReviewFlow: return true
        case .isHappyReviewFlowOnly: return false
        case .smartEngageIndex: return 4
        case .smartEngageSlots: return ["flight_test_slot_1", "flight_test_slot_2", "flight_test_slot_3"]
        case .isToShowSmartEngage: return true
        case .flightBundling: return ["c" : [ "d" : "Your ticket will be protected with cancellation protection. There will be 0 cancellation fee for this ticket.", "t" : "Free Cancellation Protection", "u" : "cp"],"m" : [ "d" : "Select any meal from the widespread airline menu for free in the next step.","t" : "Free Meal", "u" : "meal"],"s" : ["d" : "Select any seat up to Rs. 300 for free in the seat selection.","t" : "Free Seat", "u" : "seat"]]
        case .isToShowIPLEnrollmentButton: return true
        case .showFlightStatusCheck: return false
        case .isMSEFlow: return true
        case .setMSEFlowForAll: return false
        case .exclusiveFareText: return "X'clusive Fares available for this flight"
        case .addComboText: return "Add combo & save more"
        case .mseHeaderText: return "X’clusive Fares only on Goibibo"
        case .bundlingHeaderText: return "Add a Super Saver Combo"
        case .showNewIns: return false

            
        //Trains
        case .grPersuationTexts : return []
        case .grIntroPopUp : return [:]
        case .grOffers: return []
        case .grSharePNRMessage: return "Current status of PNR: <PNR> is <AVBL status>. For more information please click on the link."
        case .grForgotPasswordURL: return "https://www.irctc.co.in/eticketing/forgotPassword.jsf"
        case .grIsNativeForgotPasswordEnabled: return false
        case .grIsNativeForgotUserNameEnabled: return false
        case .grForgotUserIdMessage: return "Please email to care@irctc.co.in with your IRCTC registered email ID to retrieve your username."
        case .grBookingTimer: return [:]
        case .grIRCTCUserNameRegex: return "^[a-zA-Z]([a-zA-Z0-9]){1,33}[a-zA-Z0-9]"
        case .grIRCTCSecurityAnswerRegex: return "[a-zA-Z0-9]{3,20}"
        case .grIRCTCAddressRegex: return "([a-zA-Z0-9 ,\\-_:)(/]){3,255}"
        case .grSignUpNameRegex: return "^[a-zA-Z][a-zA-Z\\s]+$"
        case .grTrainShareStausMessage : return "To subscribe to any trains live status, please click here and download the Goibibo app.<shar_link>"
        case .grTrainShareStausURL : return ""
        case .grHideStatusShareBtn : return false
        case .grHideNotifyMeButton : return true
        case .grTrainStatusNotifyButtonText : return "Notify me on status change"
        case .grTrainStatusInfoButtonText : return "Information"
        case .grTrainStatusDateChangePopUpTitle : return "When did train start from ?"
        case .grTrainStatusStationChangePopUpTitle : return "When status change"
        case .grTrainStatusStationChangePopUpSubTitle : return "Notify me"
        case .grRetryBookingTitle : return "Retry IRCTC Login"
        case .grRetryBookingURL : return "https://goibibo.com/trains/app/retry/?transactionId=<paymentId>&channel=ios-eticket-header"
        case .grRetryRailWebViewEnabled : return true
        case .grCleanMyCoachOptionDictionary : return ["Cleaning":"C","Watering of Coaches": "W","Disinfection /Pest Control": "P","Linen/Bedroll":"B","Train Lighting/AC":"E","Petty Repairs":"R"]
        case .grCleanMyCoachTitle : return "Clean My Coach"
        case .grCleanMyCoachMessage : return "Choose service"
        case .grTrainNumberCellText : return "I know my train (optional)"
        case .grCalendarTitle : return "Select Date"
        case .grClassChangeMessage : return "Select Class"
        case .grClassChangeAlertTitle : return "Goibibo"
        case .grNumberOfMonthForCalendar : return "1"
        case .grHomeHeaderIconURL: return ""
        case .grIsClassSectionEnabled : return false
        case .grIsTrainNumberSectionEnabled : return true
        case .grTravellerScreenJourneyDetailMessage : return "You are booking for <trainName> on <date> starting from <source> to <destination> with <class>"
        case .grIRCTCSettingVCTitle : return "IRCTC Settings"
        case .grIsIRCTCTrayEnabled : return true
        case .grCalendarHeaderInfoDictArray : return DefaultValueProvider.getTrainCalendarHeaderData()
        case .grHomeTitleArray : return DefaultValueProvider.getTrainHomePageTitleArray()
        case .grIsSrpFilterEnabled : return true
        case .grIsIrctcToolKitEnabled : return true
        case .grTrainWebViewShareMessage : return "Your friend <name> is trying to book a train ticket but is unable to. They need your help. They have already paid for the transaction but are unable to remember the password for their IRCTC userID or have already made their alloted 6 bookings for the month. Please click on the link below <shareUrl>. You do not have to pay anything for this transaction.*<speacialString>*"
        case .grTrainStatusApiDelayTime : return 5
        case .grIsCancellationProtectionEnabled : return false
        case .grCpDiffrenceCharges : return 60
        case .grShowReviewPersuasion : return false
        case .grIsHappyReviewEnabled : return true
        case .grCpTutorialShownLimit : return 2
        case .grShouldShowTravelCash : return true
        case .grIsPacEnabled : return false
        case .grIsPacV2Enabled : return false
        case .grIsDefaultGoCashOn : return false
        case .grIsPaymentHelpTYBtnEnabled : return true
        case .grIsPacNativePaymentFlowEnabled : return true
        case .grRecentPsngrCountLimit : return 10
        case .grIsHappyTravellerEnabled : return true
        case .grPacIssueUrl : return "https://goibibo.typeform.com/to/H2v8S9"

        //Bus
        case .busHomeRecentSearchLimit: return 15
        case .busReviewGoCashDefaultEnabled: return true
        case .busSRPDefaultSorting: return "cheapest"
        case .busSRPAmenities: return [:]
        case .busTrackDateOffset: return 30
        case .busMaxAllowedBookingDays: return 90
        case .busCategoryMessages: return [:]
        case .busSRPErrorCount: return 2
        case .busDetailsTutorial: return ["e":"true","i":7]
        case .busSRPRatingColorCodes: return [
                                                "18A160",
                                                "7CCF51",
                                                "FBB10A",
                                                "FF6D38"
                                            ]
        case .busHire: return false
            
        //Cars
        case .gcHomeLocateApiDelayInMs: return 0
        case .showCarBookingTimeline : return false
        case .gcPromoCodeAutoApply: return ""
        case .gcPromoEnabled: return false
        case .gcHomeCardsRootFirebasePath: return "/gocars/home_cards/v1/"
        case .gcHomeLocationPopupEnabled: return true
        case .gcMinimumBookingTimeInMins: return 120
        case .gcRegexForRealtime: return []
        case .gcHomeBanners: return []
        case .gcSrpHatchbackUrl: return ""
        case .gcSrpSedanUrl: return ""
        case .gcSrpSuvUrl: return ""
        case .gcSrpBannerUrl: return ""
        case .gcSrpRoundTripBannerUrl: return ""
        case .gcSRPAmenitiesArray: return []
        case .gcSRPRoundTripAmenities: return []
        case .gcReviewChatEnabled: return false
        case .gcReviewChatParams: return [:]
        case .gcReviewTAndCSubTitle: return "Fare Rules, Cancellation, Driver Details etc."
        case .gcAPIAuthString: return "foo:bar"
        case .gcPersuasionBanners: return [:]
        case .gcPersuasionBannersV2 : return [:]
        case .gcPopularAirports: return[]
        case .gcRecentSearchesLimit: return 5
        case .gcFlightNumberPersuation : return "Great! your pickup is now secured in case of flight delays"
        case .gcEnterFlightNumberTitle : return "Enter your flight number to ensure your cab is waiting, even if your flight is delayed"
        case .gcEnterFlightPlaceholder : return "Enter Flight Number Ex - “UK-123”"
         case .gcFlightRegex : return ""
        case .gcCrossSellExpand : return false
        case .gcReviewCapFlightTitle : return "Add Flight No. (Optional)"
        case .gcReviewCapFlightSubTitle : return "Provide your flight no to ensure your Cab is waiting even if your flight gets delayed"
            
        //QuickHelp
        case .quickHelpUrl: return "https://www.goibibo.com/support/?flavour=ios"
        
            
        case .eTicketDianaUrl: return "https://diana.goibibo.com/view/quick_help/?pid={{paymentid}}&leg_id={{legid}}/?flavour=ios"
        case .supportDianaUrl: return "https://diana.goibibo.com/api/sessionAuth/?flavour=ios"
        case .eTicketQuickHelpUrl: return "https://www.goibibo.com/myaccount/trips/{{paymentid}}/quickhelp/?flavour=ios&leg_id={{legid}}"
        case .supportQuickHelpUrl: return "https://www.goibibo.com/support/?flavour=ios"
        case .isDianaSupportEnable: return true
        case .isDianaEticketEnable: return true
        
        //MyBooking
        case .ratingEnableStatus: return "Booking Confirmed,Booking Successful"
        case .ratingTimeDelay: return 10
        
        //Home Screen
        case .homeLob: return "hotel,flight,train,bus,cab,apCabs,exp,cf"
        case .homeLobData: return ["hotel":["enabled" : true,
                                             "tag" : 201,
                                             "text" : "Hotels",
                                             "width" : 65],
                                   "flight":["enabled" : true,
                                             "tag" : 101,
                                             "text" : "Flights",
                                             "width" : 65],
                                   "train":["enabled" : true,
                                            "hint" : "",
                                            "hint_color" : "#008000",
                                            "tag" : 400,
                                            "text" : "IRCTC Trains",
                                            "url" : "https://gos3.ibcdn.com/irctcIcon-1558513276.png",
                                            "width" : 65],
                                   "bus":["enabled" : true,
                                             "tag" : 301,
                                             "text" : "Buses",
                                             "width" : 65],
                                   "cab":["enabled" : true,
                                            "icon_normal" : "icCars_filled",
                                            "tag" : 1001,
                                            "text" : "Outstation Cabs",
                                            "width" : 60],
                                   "apCabs":["enabled" : true,
                                             "gd" : [
                                                "flow" : "appHome_Airport_Transfers",
                                                "showLast" : true,
                                                "trip_type" : "airport"
                                              ],
                                             "hint" : "SAVE ₹150",
                                             "hint_color" : "#18a160",
                                             "icon_normal" : "icCarsAT_filled",
                                             "minVersion" : 681,
                                             "tag" : 1001,
                                             "text" : "Airport Cabs",
                                             "width" : 60],
                                   "exp":["enabled" : true,
                                            "hint" : "Deals @₹1",
                                            "minVersion" : 679,
                                            "tag" : 1401,
                                            "text" : "Experiences",
                                            "width" : 95],
                                   "cf":["enabled" : true,
                                             "flow" : "CP",
                                             "gd" : [
                                                "all_filters" : [
                                                    "hctx" : "dh_cf"
                                                ],
                                                "flow" : "CP",
                                                "hotelContext" : "cf",
                                                "hotelContextColor" : "#E54762",
                                                "hotelContextIcon" : "couple-friendly",
                                                "hotelContextTitile" : "Couple Friendly",
                                                "tag" : 201,
                                                "template_id" : "dh_cf_home"],
                                             "icon_normal" : "Cf_white",
                                             "minVersion" : 695,
                                             "tag" : 201,
                                             "text" : "Couple Friendly",
                                             "width" : 95]]
            
        //hotel
        case .shouldBusinessDealBeDefaultForIH: return true
        case .panMessage: return "For Leisure/Personal travel outside India, RBI mandates submission of PAN Card details of the traveller"
        case .goStayBrandingImageUrl: return "https://gos3.ibcdn.com/gostays-srp-1506509210.jpg"
        case .shouldEnableHotelCancelReactFlow: return true
        case .goStaysAdVideo: return ""
            
        //UGC
        case .writeReviewConcerns: return [ ["key" : "ac","text" : "AC absent/ Not working"
            ],["key" : "linen","text" : "Linen not clean/ dirty"],[
                "key" : "wifi", "text": "Wifi absent/ Not working"],["key" : "tv",
                "text" : "TV absent/ Not working"],[
                "key" : "other",
                "text" : "Other"] ]
        case .shouldShowGoRooms: return true
        case .submitReviewMsg : return [
            "onlineMsg":"Your review will be visible to other travellers after moderation by our system.",
            "offlineMsg": "You are currently offline. Your review is saved and will be submitted for moderation once you are online. Post moderation, it will be visible to other travellers.",
            "goRoomsOfflineMsg": "You are currently offline. Your review is saved and will be submitted for goStays money-back claim once you are online. Your GoTime guarantee will start once your review is submitted",
            "goRoomsOnlineMsg": "We have received your goStays money-back claim and are validating the same. We assure you the best possible resolution as per our GoTime guarantee of 1 hour"]
        case .csSubmitMessage: return "Your task has been completed successfully. If applicable, your goCash+ reward will be credited to your wallet."
        case .csSubmitActivityMessage: return "Submitting response..."
        case .csNoQuestionErrorMessage: return "Seems like you have already completed this task or we got some problem fetching the details."
        case .reviewGoCashPlus: return 0
        case .homeLocationTitle: return "Share your Home Location"
        case .homeLocationSubTitle: return "Sharing your location will help us show tasks relevant to you"
        case .locationSharedMessage: return "Your account will shortly be credited with 20 goCash+"
        case .blockerTitle: return "How was your Experience ?"
        case .videoGoCash: return 50
        case .videoMaxTime: return 15
        case .videoReviewEnabled: return true
        case .videoTags: return []
        case .reviewContexts: return []
        case .useNativeCamera: return false
        case .captivate: return true
        case .amenitiesList: return [:]
        case .goStaysBannerUrl: return ""
        case .moneyBackNumber: return ""
        case .callScreenText: return "You can claim moneyback by calling us"
        case .notContactedText: return "90% times, hoteliers will resolve your issues and ensure you have a pleasant stay if you contact them"
        case .mbMessageOne: return "We have received your goStays money-back claim and are validating the same. We assure you the best possible resolution as per our policy."
        case .mbMessageTwo: return "You review will be live after moderation"
        case .wrMessageOne: return "Your review has been submitted successfully. If applicable, your goCash+ reward will be credited to your wallet post review approval."
        case .wrMessageTwo: return "You review will be live after moderation"
          
        //TEZ
        case .tezUPIType: return ["Okaxis","Okhdfcbank","Okicici"]
        // Gocash
        case .goCashTopUpOption: return ["UPI"]
        case .goCashThankYou: return ["AddMoney":["PAYMENT_SUCCESS":["buttonTag":101,"buttonTitle": "Check goCash Balance","status":"Payment Done"],"PAYMENT_FAILED":["buttonTag":102,"buttonTitle": "QuickHelp","status":"Payment Failed"]]]
        case .loadWalletDiscount: return 1
        case .isLoadWalletEnable: return false
        case .upiIntents: return []
        case .upiIntentheading : return "UPI Payment Provider"
            
          //Daina Profile
          case .isDianaProfileEnable: return true
          case .dianaProfileText: return "MyChat"
          
          //MyBooking
          case .myBookingSyncInterval : return 30
          case .isMyBookingFirebaseEnable : return true
          case .isMyBookingAPIDateSelected : return true
          case .validVerticals: return ["flight","hotel","bus","gocar","train","gohomes"]
          case .isActivityTicketHidden: return false
          case .noNetworkText : return "Please check your internet connection"
          case .apiFaliureText : return "Info about free add-ons on your ticket is not available"
          case .paymnetFailedReasons : return []
        case .crossSellEnabled: return true
        case .mybookingStatusMapping: return [
            "Booking Confirmed" : "booking_done",
            "Booking Failed" : "booking_failed",
            "Booking Failed, Refunded" : "booking_failed_refunded",
            "Booking In Progress" : "booking_in_progress",
            "Booking Successful" : "booking_done",
            "Cancellation Requested" : "cancellation_requested",
            "Expired" : "expired",
            "Partially Paid" : "partially_paid",
            "Payment Done" : "payment_done",
            "Payment Failed" : "payment_failed",
            "Payment Pending " : "payment_pending ",
            "Payment done, Booking failed" : "booking_failed",
            "Redeemed" : "redeemed",
            "Refund Under Process" : "refund_under_process",
            "Refunded" : "refunded",
            "Request Submitted" : "request_submitted",
            "Reservation In Progress" : "reservation_in_progress",
            "Reserved for You" : "reservation_done",
            "Vendor Cancelled" : "vendor_cancelled"
            ]

          case .deeplinkParsingURLArray : return ["/hotels/app/"]

        //Payment
        case .supportedPaymentOptions: return ["card":["isEnable":true],"CC":["isEnable":true],"DC":["isEnable":true],"EMI":["isEnable":true],"UPI":["isEnable":true],"NB":["isEnable":true],"TEZ":["isEnable":true],"CITI":["isEnable":true],"CASHCARD":["isEnable":true],"WALLET":["isEnable":true],"PAYPAL":["isEnable":true], "AMAZONPAY":["isEnable":true], "LAZYPAY": ["isEnable":true]] //["CC,DC,EMI,UPI,NB,TEZ,CITI,CASHCARD,WALLET"]
        
        case .supportedPaymentOptionsV2:  return ["card":["isEnable":true],"CC":["isEnable":true],"DC":["isEnable":true],"EMI":["isEnable":true],"UPI":["isEnable":true],"NB":["isEnable":true],"TEZ":["isEnable":true],"CITI":["isEnable":false],"CASHCARD":["isEnable":false],"WALLET":["isEnable":false],"PAYPAL":["isEnable":true], "AMAZONPAY":["isEnable":true], "LAZYPAY": ["isEnable":true], "ICICI_PAYLATER": ["isEnable": true], "SIMPL": ["isEnable":true], "BAJAJFINSERV":["isEnable":true]];
        case .isPaymentV2Enable: return true
        case .paymentMethodValidation: return true
        case .saveCardHeaderTitle: return "By proceeding, you accept the booking terms and Goibibo general terms of use and services"
        case .paymentModeHeaderOption: return "Payment Options"
        case .savedPaymentHeaderText: return "Saved payment options"
        case .goBackButtonMsg: return "We won't be able to hold this ticket price if you go back. The prices for this activity might increase."
        case .shouldClearamazonBrowserCookies: return true
        case .shouldCallUPIDiscountAPI: return true
        case .isExpressEnable : return false
            
        case .enableTune: return true
        case .enableAppsFlyer: return true
        case .enableLocalNotification: return true
        case .enableGeoLocalNotification: return true
        case .enableKeepSynch: return true
        case .enableNotificationKeepSynch: return true
            
        //Local Notification
        case .geoLocationsFirebasePath :
            return "/notifications/iosapp/"
        
        //Whatapp
        case .whatsapp_login_msg : return "Send booking updates on this number on Whatsapp"
        case .whatsapp_msg: return "Send updates on WhatsApp on <mobile_number>"
        case .whatsapp_alert_title: return "Goibibo"
        case .whatsapp_alert_message: return "Are you sure you don't wont to receive notifications on WhatsApp?"
        case .whatsapp_alert_continue: return "Continue"
        case .whatsapp_alert_cancel: return "Cancel"
        case .whatsapp_optin_disable_flag: return false
        case .whatsappLoginEnabled: return true
        case .whatsapp_login_phone: return "+919213025552"
        case .whatsapp_login_abid: return "12354"
        case .whatsapp_login_text: return "Sign me into Goibibo App"
        case .whatsappLoginTextReferral: return "Sign me into Goibibo App with invite code: <rcode>"
        case .whatsappAlreadyLoginAlertMsg: return "You are already logged in with <phone>. Do you want to logout?"
        case .whatsappAlreadyLoginAlertCTA: return "Logout"
        case .whatsapp_login_button_text: return "Continue with Whatsapp"

        case .enableDevFeatureForEmails: return []
        case .me_order: return  ["2","3,4,5,18,6,7,8,9,10","11,12,13,14,15"]
        case .me_order_loggedin: return  ["1","3,4,5,18,6,7,8,9,10","11,12,13,14,15"]

        case .pricePersonalization : return false
        case .appsflyer_config_segment : return true
        case .is_offer_upfront : return false
        case .rsv : return 5
        case .domFlightCounter : return "-100--"
        case .fphHot : return 10
        case .ccDigitsCount : return 23
        case .intFlightCounter : return "-0--"
        case .intFph : return false
        case .isFlighReviewBlock : return true
        case .isAskText : return true
        case .showVariant2 : return false
        case .showFareGraph : return false
        case .verticalHint : return ["hotel":"","car":"Outstation!","bus":"","train":"New!","flight":"","fph":"","goHomes":"NEW"]
        case .maxApiRetry : return 5
        case .maxApiRetryInterval : return 300.0
        case .kUpcomingTripSkipItemList : return  ["refund","pending","payment failed","cancelled","3rd party fol_up", "fake","progress"];
        case .callUsList : return []
        case .goOffers : return [ ["k" : "Hotels",  "v" : "hotels"], [ "k" : "Flights",
        "v" : "flight"  ], [ "k" : "Bus", "v" : "bus" ], [  "k" : "goCar",
        "v" : "gocars" ] ]
        case .inviteAll : return true
        case .srpOffersEnabled : return false
        case .busSessionTime : return 7
        case .busSessionExpireMessage : return "Bus seat selection session expired"
        case .myBookingActionConfig : return [String:Any]()
        case .thankYouAction : return [String:Any]()
        case .bookingPrivacyString : return [String:Any]()
        case .myBookingPagenation : return 30
        case .myBookingEnablePrivacy : return true
        case .shouldSendCCDetails : return false
        case .privacyGoCashtext : return "By sharing your trip, you will earn goCash+ each time any of your contact books on Goibibo."
        case .retryMessagetext: return "Sorry ! we are unable to fetch some of your bookings. Please try again."
        case .gstDictionary : return [String:Any]()
        case .socialDictionary : return  DefaultValueProvider.getSocialValues()
        case .enableBackPayu : return true
        case .setGcContactSync : return "Please sync your contacts"
        case .isSegmentEnabled : return true
        case .isApiStatusTrackEnable : return false
        case .fbSegmentEventEnabled : return false
        case .contactBatchSize : return 300
        case .webcheckinMessageKey : return "Unable to proceed with webcheckin, please verify that your ticket is confirmed prior to Web-Checkin"
        case .isExpandPaxDetailsEnable : return false
        case .isHtmlOfferEnabled: return true
        case .rn_hotel_loader_text: return "Loading the best price and deals"
        case .rn_hotel_loader_delay : return 1
        case .rn_hotel_loader_duration : return 1
            
        case .vaultVoucherStatusColors: return ["redeemed": "#18A160", "expired": "#FF1515"]
        case .isFeatureEnable: return true
        }
    }
}

public class DefaultValueProvider {
    
    public static func getgoHomeAmenitiesMap() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = [:]
        return defaultValue
    }
    
    public static func getReferAndEarnOffer() -> Dictionary<String, Any> {
        let defaultValue : Dictionary<String, Any> = ["h":"", "sh":"","img":""]
        return defaultValue
    }
    
    public static func getReferAndEarnShare() -> Dictionary<String, Any> {
        let defaultValue : Dictionary<String, Any> = ["body":"Hey! I have given you ₹150 goCash+. Download the Goibibo App & use my code {{invite_code}} while you SignUp to Claim ₹150  goCash+ Instantly. Click: {{branch_link}} to save additional ₹150 on your Travel Bookings. Claim Now!","fb_url":"http://www.goibibo.com/refer-earn/v2/{{invite_code}}/","fb_body":"http://www.goibibo.com/refer-earn/v1/{{invite_code}}/"]
        return defaultValue
    }
    
    public static func getReferAndDescription() -> Dictionary<String, Any> {
        let defaultValue : Dictionary<String, Any> = ["h":"1 Referral = 150 goCash+", "t1":"You","t2":"Your friend earns you",
                                                      "msg1":"Refer a friend", "msg2":"on Sign Up", "msg3":"on first travel", "c1":"₹50", "c2":"₹100"]
        return defaultValue
    }
    
    public static func getUserConfirmationValuesforNewUser() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = ["h": "Hi {{First_Name}}",
                                                    "hst": "You've signed up successfully",
                                                    "st": "Introducing goContacts",
                                                    "sst": "Sync & Earn Rs.25 goCash+",
                                                    "et1": "Earn Rs.10 goCash+",
                                                    "e1": "every time your contact books with Goibibo",
                                                    "et2": "Discover contacts",
                                                    "e2": "who have visited any city you search for",
                                                    "bt": "LINK MY PHONEBOOK",
                                                    "rp":"{{Friend 1}}, {{Friend 2}} & {{Friends Count}} others have earned more than 1000 goCash+"]
        return defaultValue
    }
    
    public static func getUserConfirmationValuesforPreviouslySynced() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = ["h": "Hi {{First_Name}}",
                                                     "hst": "Welcome back!",
                                                     "st": "Sync & Earn Rs.10 goCash+",
                                                     "sst": "every time a contact books with Goibibo",
                                                     "et1": "Discover contacts",
                                                     "e1": "who have visited any city you search for",
                                                     "et2": "Get answers",
                                                     "e2": "to all your questions, by people you know and trust",
                                                     "bt": "LINK MY PHONEBOOK",
                                                     "rp": "{{Friend 1}}, {{Friend 2}} & {{Friends Count}} others have earned more than 1000 goCash+"]
        return defaultValue
    }
    
    public static func getUserConfirmationValuesforNeverSynced() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = ["h": "Hi {{First_Name}}",
                                                     "hst": "Welcome back!",
                                                     "st": "Sync & Earn Rs.25 goCash+",
                                                     "sst": "Earn Rs.10 goCash+ every time your contact books with Goibibo",
                                                     "et1": "Discover contacts",
                                                     "e1": "who have visited any city you search for",
                                                     "et2": "Get answers",
                                                     "e2": "to all your questions, by people you know and trust",
                                                     "bt": "LINK MY PHONEBOOK",
                                                     "rp": "{{Friend 1}}, {{Friend 2}} & {{Friends Count}} others have earned more than 1000 goCash+"]
        return defaultValue
    }

    public static func getOnboardingValues() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = ["c_s_d_ds" : "Join millions of others who have linked their phonebooks and are enjoying bigger discounts and a more social & more informed travel experience.",
                                                     "c_s_gd_1" : "Earn goCash+ ⓘ every time a contact books with Goibibo",
                                                     "c_s_gd_2" : "Discover contacts who have visited any city you search for, and get all your questions answered by people you know and trust.",
                                                     "c_s_gd_3" : "Stay updated with your friends about their latest Travels, Reviews, Questions and Answers.",
                                                     "c_s_gd_3_v" : false,
                                                     "d_s_d_ds" : "• Save more on bookings with goCash+ and goCash.\n•  Get all your questions answered by the goibibo community.\n• Access your bookings across all devices.",
                                                     "f_p" : "email,public_profile,user_mobile_phone,user_birthday,user_location",
                                                     "sa_s_d_ds" : "•  Login even without access to your mobile phone.\n•  Get quicker support on your bookings.",
                                                     "wp_r_st" : "Sync your contacts to earn goCash+\neach time your contacts make a booking.",
                                                     "sa_display":true,
                                                     "wp_r_t" : "Signup to claim your goCash.",
                                                     "newGoCashTitle" : "Earn goCash+\nwhen you Signup\n"]
        return defaultValue
    }
    
    public static func getSocialValues() -> Dictionary<String, Any> {
        let defaultValue: Dictionary<String, Any> = ["s_d_s_alert": "Earn goCash+ each time any of your contact travels. Earn ₹1000 for every referral. Your contact earns ₹1000.", "d_synced" : "Earn goCash+ each time any of your contact travels. Earn 1000 for every referral. Your contact earns 1000.", "d_syncing" : "Please invite from below methods",  "h_msg" : "Earn goCash+ each time any of your contact travels. Earn ₹1000 for every referral. Your contact earns ₹1000.", "t_synced" : "Connect & Earn from notongoibibo Contacts", "t_syncing" : "Contacts are syncing...", "invitemsg" : "get ₹1000 goCash", "social_sync_msg" : ["Share your “phone book” contacts","Start earning goCash+ each time any of your contacts travels","Use goCash+ to book Flight, Hotels,Bus & Cars. Use without limits"],"connectEarnData": ["headerArray" : [ [
            "fontsize" : 18,
            "text" : "Connect & Earn from Contacts ",
            "textcolor" : "#333333"
            ], [
                "fontsize" : 15,
                "text" : "Earn goCash+ each time any of your contact books on Goibibo.",
                "textcolor" : "#333333"
            ], [
                "fontsize" : 12,
                "text" : "eg: 10 Contacts x 50 = Rs.500. goCash+ is without any usage restrictions!",
                "textcolor" : "#9B9B9B"
            ] ],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "msg1" : "1. Invite your friends to Download Goibibo App",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "msg2" : "2. Contact joins, you earn ₹1000 goCash and your contact earns ₹3000 goCash",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "msg3" : "3. Link your phonebook. earn goCash+ each time they book",    "msg4" : "3. Earn goCash+ each time they book", "ctalink" : "Sync Your Contact", "ctaleft" : "Invite & Earn", "pagetitle" : "Invite & Earn", "ctatop" : "Invite & Earn"],
                                                     "gc_logout" : [
                                                        "gc_d" : [ [
                                                            "al" : "c",
                                                            "b" : false,
                                                            "bp" : 10,
                                                            "c" : "#8F8E94",
                                                            "s" : 12,
                                                            "t" : "goCash is your personal travel currency. You can save on your travel bookings when you book using goCash.",
                                                            "tp" : 10
                                                            ], [
                                                                "al" : "l",
                                                                "b" : true,
                                                                "bp" : 10,
                                                                "c" : "#040404",
                                                                "s" : 15,
                                                                "t" : "What is goCash?",
                                                                "tp" : 10
                                                            ], [
                                                                "al" : "l",
                                                                "b" : false,
                                                                "bp" : 10,
                                                                "c" : "#333333",
                                                                "s" : 12,
                                                                "t" : "goCash is earned through promotional activities for example Refer & earn, Cashbacks, Voucher code redemption, etc. This has usage limit for booking and validity of 90 days from the date of earning.",
                                                                "tp" : 10
                                                            ], [
                                                                "al" : "l",
                                                                "b" : true,
                                                                "bp" : 10,
                                                                "c" : "#040404",
                                                                "s" : 15,
                                                                "t" : "What is goCash+?",
                                                                "tp" : 10
                                                            ], [
                                                                "al" : "l",
                                                                "b" : false,
                                                                "bp" : 10,
                                                                "c" : "#333333",
                                                                "s" : 12,
                                                                "t" : "goCash+ is earned by * Cancellation & Refund : No usage limits & unlimited validity * Promotional activites: Refer & Earn and Contact Gratifications bonus. NO usage limits & Vaildity of 90 days.",
                                                                "tp" : 10
                                                            ]],
                                                        "img_url" : ""
            ]
        ]
        return defaultValue
    }
    
    public static func defaultTierValues() -> [[String:Any]] {
        let dic = [ [
            "benefit" : [ [
                "point" : [ [
                    "locked" : false,
                    "pst" : "Use 100% of your goCash+ without any restrictions on your flight and hotel bookings",
                    "pt" : "Use 100% goCash+ on bookings"
                    ], [
                        "locked" : false,
                        "pst" : "With every travel booking on Goibibo, earn a chance to win goCash+ as cashback. Use goCash+ on bookings and save more!",
                        "pt" : "Earn goCash+ on bookings"
                    ], [
                        "pst" : "Enjoy a free hotel room upgrade or meal plan upgrade upto ₹2,000 on all eligible domestic hotel bookings.",
                        "pt" : "Free Hotel Room Upgrade"
                    ], [
                        "pst" : "Relax and enjoy a free airport lounge access at the Premium Plaza airport lounges at Hyderabad, Bangalore and New Delhi.",
                        "pt" : "Free Airport Lounge Access"
                    ], [
                        "pst" : "Enjoy a free meal upto ₹300 applicable on all domestic flight bookings. Free meal can be availed on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                        "pt" : "Free Meals on Flight Bookings"
                    ], [
                        "pst" : "Enjoy a free seat selection upto ₹300 applicable on all domestic flight bookings. Free seat can be used on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                        "pt" : "Free Seat on Flight Bookings"
                    ], [
                        "pst" : "Secure your travel through a free insurance applicable on all domestic flight bookings.",
                        "pt" : "Free Insurance on Flight Bookings"
                    ] ],
                "title" : "Bronze Level Benefits"
                ], [
                    "point" : [ [
                        "pst" : "Get a goCars voucher worth ₹350 which can be used for your inter-city travel.",
                        "pt" : "Complimentary goCars Vouchers"
                        ], [
                            "pst" : "Access to our priority hotline for us to assist you in your travel queries instantaneously.",
                            "pt" : "Priority hotline (Coming Soon)"
                        ], [
                            "pst" : "Get upto ₹1000 goCash+ as a one-time benefit when your Rewards level gets upgraded",
                            "pt" : "Upto ₹1000 goCash+ on Rewards level upgrade"
                        ] ],
                    "title" : "Bronze Exclusive Privileges"
                ] ],
            "bgColorEnd" : "#bf8466",
            "bgColorStart" : "#825f4c",
            "bgcolor" : "#bf8466",
            "gcpMax" : 499,
            "gcpMin" : 0,
            "id" : 0,
            "msg1" : "Earn ₹<gcp> goCash+ to reach Bronze level",
            "msg2" : "View Benefits",
            "name" : "Bronze Level",
            "nextTierMsg" : "Earn ₹<gcp> goCash+ to reach Silver level",
            "pbcolor" : "#2ddf39",
            "tierUpgradeMsg" : [
                "bgColor" : "#2ad321",
                "subTitle" : "You’ve earned ₹<gcp> goCash+, you are now a <level> Member",
                "title" : "Congrats! You are a <level> Member now",
                "txtColor" : "#ffffff"
            ],
            "unlockedmsg" : "Congrats! You have leveled up",
            "upgrade_benefit" : 100
            ], [
                "benefit" : [ [
                    "point" : [ [
                        "locked" : false,
                        "pst" : "Secure your travel through a free insurance for 1 passenger on any of your domestic flight booking.",
                        "pt" : "1 free insurance on Flight Booking"
                        ], [
                            "locked" : false,
                            "pst" : "Use 100% of your goCash+ without any restrictions on your flight and hotel bookings",
                            "pt" : "Use 100% goCash+ on bookings"
                        ], [
                            "locked" : false,
                            "pst" : "With every travel booking on Goibibo, earn a chance to win goCash+ as cashback. Use goCash+ on bookings and save more!",
                            "pt" : "Earn goCash+ on bookings"
                        ], [
                            "pst" : "Enjoy a free hotel room upgrade or meal plan upgrade upto ₹2,000 on all eligible domestic hotel bookings.",
                            "pt" : "Free Hotel Room Upgrade"
                        ], [
                            "pst" : "Relax and enjoy a free airport lounge access at the Premium Plaza airport lounges at Hyderabad, Bangalore and New Delhi.",
                            "pt" : "Free Airport Lounge Access"
                        ], [
                            "pst" : "Enjoy a free meal upto ₹300 applicable on all domestic flight bookings. Free meal can be availed on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "Free Meals on Flight Bookings"
                        ], [
                            "pst" : "Enjoy a free seat selection upto ₹300 applicable on all domestic flight bookings. Free seat can be used on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "Free Seat on Flight Bookings"
                        ] ],
                    "title" : "Silver Level Benefits"
                    ], [
                        "point" : [ [
                            "locked" : false,
                            "pst" : "Get ₹100 goCash+ as a one-time benefit when your Rewards level gets upgraded to Silver",
                            "pt" : "₹100 goCash+ on upgrade"
                            ], [
                                "pst" : "Get a goCars voucher worth ₹350 which can be used for your inter-city travel.",
                                "pt" : "Complimentary goCars Vouchers"
                            ], [
                                "pst" : "Access to our priority hotline for us to assist you in your travel queries instantaneously.",
                                "pt" : "Priority hotline (Coming Soon)"
                            ] ],
                        "title" : "Silver Exclusive Privileges"
                    ] ],
                "bgColorEnd" : "#d5d5d5",
                "bgColorStart" : "#566082",
                "bgcolor" : "#d5d5d5",
                "gcpMax" : 2499,
                "gcpMin" : 500,
                "id" : 1,
                "msg1" : "Earn <gcp> goCash+ to reach Silver level",
                "msg2" : "View Benefits",
                "name" : "Silver Level",
                "nextTierMsg" : "Earn ₹<gcp> goCash+ to reach Gold level",
                "pbcolor" : "#2ddf39",
                "tierUpgradeMsg" : [
                    "bgColor" : "#2ad321",
                    "subTitle" : "You’ve earned ₹<gcp> goCash+, you are now a <level> Member",
                    "title" : "Congrats! You are now a <level> Member",
                    "txtColor" : "#ffffff"
                ],
                "unlockedmsg" : "Congrats! You have leveled up",
                "upgrade_benefit" : 300
            ], [
                "benefit" : [ [
                    "point" : [ [
                        "locked" : false,
                        "pst" : "Enjoy one free meal upto ₹300 applicable on any of your domestic flight bookings. Free meal can be availed on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                        "pt" : "1 Free Meal on Flight Booking"
                        ], [
                            "locked" : false,
                            "pst" : "Enjoy 1 free seat selection upto ₹300 applicable on any of your domestic flight bookings. Free seat can be used on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "1 Free Seat on Flight Booking"
                        ], [
                            "locked" : false,
                            "pst" : "Secure your travel through a free insurance for 2 passengers overall on any of your domestic flight bookings.",
                            "pt" : "2 free insurance on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Use 100% of your goCash+ without any restrictions on your flight and hotel bookings",
                            "pt" : "Use 100% goCash+ on bookings"
                        ], [
                            "locked" : false,
                            "pst" : "With every travel booking on Goibibo, earn a chance to win goCash+ as cashback. Use goCash+ on bookings and save more!",
                            "pt" : "Earn goCash+ on bookings"
                        ], [
                            "pst" : "Enjoy a free hotel room upgrade or meal plan upgrade upto ₹2,000 on all eligible domestic hotel bookings.",
                            "pt" : "Free Hotel Room Upgrade"
                        ], [
                            "pst" : "Relax and enjoy a free airport lounge access at the Premium Plaza airport lounges at Hyderabad, Bangalore and New Delhi.",
                            "pt" : "Free Airport Lounge Access"
                        ] ],
                    "title" : "Gold Level Benefits"
                    ], [
                        "point" : [ [
                            "locked" : false,
                            "pst" : "Get a goCars voucher worth ₹350 which can be used for your inter-city travel.",
                            "pt" : "Complimentary goCars Voucher"
                            ], [
                                "locked" : false,
                                "pst" : "Get ₹300 goCash+ as a one-time benefit when your Rewards level gets upgraded to Gold",
                                "pt" : "₹300 goCash+ on upgrade"
                            ], [
                                "pst" : "Access to our priority hotline for us to assist you in your travel queries instantaneously.",
                                "pt" : "Priority hotline (Coming Soon)"
                            ] ],
                        "title" : "Gold Exclusive Privileges"
                    ] ],
                "bgColorEnd" : "#f3d861",
                "bgColorStart" : "#f3d861",
                "bgcolor" : "#f3d561",
                "gcpMax" : 4999,
                "gcpMin" : 2500,
                "id" : 2,
                "msg1" : "Earn <gcp> goCash+ to reach Gold level",
                "msg2" : "View Benefits",
                "name" : "Gold Level",
                "nextTierMsg" : "Earn <gcp> goCash+ to reach Platinum level",
                "pbcolor" : "#2ddf39",
                "tierUpgradeMsg" : [
                    "bgColor" : "#2ad321",
                    "subTitle" : "You’ve earned ₹<gcp> goCash+, you are now a <level> Member",
                    "title" : "Congrats! You are now a <level> Member",
                    "txtColor" : "#ffffff"
                ],
                "unlockedmsg" : "Congrats! You have leveled up",
                "upgrade_benefit" : 500
            ], [
                "benefit" : [ [
                    "point" : [ [
                        "locked" : false,
                        "pst" : "Enjoy two free hotel room upgrade or meal plan upgrade upto ₹2,000 each on all eligible domestic hotel bookings.",
                        "pt" : "2 Free Hotel Room Upgrades"
                        ], [
                            "locked" : false,
                            "pst" : "Relax and enjoy two free airport lounge access passes at the Premium Plaza airport lounges at Hyderabad, Bangalore and New Delhi.",
                            "pt" : "2 Free Airport Lounge Access"
                        ], [
                            "locked" : false,
                            "pst" : "Enjoy one free meal upto ₹300 applicable on any of your domestic flight bookings. Free meal can be availed on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "2 Free Meals on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Enjoy two free seats selection upto ₹300 each applicable on any of your domestic flight bookings. Free seat can be used on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "2 Free Seats on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Secure your travel through a free insurance for 3 passengers overall on any of your domestic flight bookings.",
                            "pt" : "3 free insurance on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Use 100% of your goCash+ without any restrictions on your flight and hotel bookings",
                            "pt" : "Use 100% goCash+ on bookings"
                        ], [
                            "locked" : false,
                            "pst" : "With every travel booking on Goibibo, earn a chance to win goCash+ as cashback. Use goCash+ on bookings and save more!",
                            "pt" : "Earn goCash+ on bookings"
                        ] ],
                    "title" : "Platinum Level Benefits"
                    ], [
                        "point" : [ [
                            "locked" : false,
                            "pst" : "Get 2 goCars vouchers worth ₹350 each which can be used for your inter-city travel on Goibibo.",
                            "pt" : "2 Complimentary goCars Vouchers"
                            ], [
                                "locked" : false,
                                "pst" : "Get ₹500 goCash+ as a one-time benefit when your Rewards level gets upgraded to Platinum",
                                "pt" : "₹500 goCash+ on upgrade"
                            ], [
                                "locked" : false,
                                "pst" : "Access to our priority hotline for us to assist you in your travel queries instantaneously.",
                                "pt" : "Priority hotline (Coming Soon)"
                            ] ],
                        "title" : "Platinum Exclusive Privileges"
                    ] ],
                "bgColorEnd" : "#5187b8",
                "bgColorStart" : "#8c60ac",
                "bgcolor" : "#5187b8",
                "gcpMax" : 7999,
                "gcpMin" : 5000,
                "id" : 3,
                "msg1" : "Earn ₹<gcp> goCash+ to reach Platinum level",
                "msg2" : "View Benefits",
                "name" : "Platinum level",
                "nextTierMsg" : "Earn ₹<gcp> goCash+ to reach Titanium level",
                "pbcolor" : "#2ddf39",
                "tierUpgradeMsg" : [
                    "bgColor" : "#2ad321",
                    "subTitle" : "You’ve earned ₹<gcp> goCash+, you are now a <level> Member",
                    "title" : "Congrats! You are now a <level> Member",
                    "txtColor" : "#ffffff"
                ],
                "unlockedmsg" : "Congrats! You have leveled up",
                "upgrade_benefit" : 1000
            ], [
                "benefit" : [ [
                    "point" : [ [
                        "locked" : false,
                        "pst" : "Enjoy four free hotel room upgrades or meal plan upgrades upto ₹2,000 each on all eligible domestic hotel bookings.",
                        "pt" : "4 Free Hotel Room Upgrades"
                        ], [
                            "locked" : false,
                            "pst" : "Relax and enjoy two free airport lounge access passes at the Premium Plaza airport lounges at Hyderabad, Bangalore and New Delhi.",
                            "pt" : "2 Free Airport Lounge Access"
                        ], [
                            "locked" : false,
                            "pst" : "Enjoy one free meal upto ₹300 applicable on any of your domestic flight bookings. Free meal can be availed on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "2 Free Meals on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Enjoy two free seats selection upto ₹300 each applicable on any of your domestic flight bookings. Free seat can be used on Indigo, SpiceJet, GoAir and AirAsia bookings.",
                            "pt" : "2 Free Seats on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Secure your travel through a free insurance for 3 passengers overall on any of your domestic flight bookings.",
                            "pt" : "3 free insurance on Flight Bookings"
                        ], [
                            "locked" : false,
                            "pst" : "Use 100% of your goCash+ without any restrictions on your flight and hotel bookings",
                            "pt" : "Use 100% goCash+ on bookings"
                        ], [
                            "locked" : false,
                            "pst" : "With every travel booking on Goibibo, earn a chance to win goCash+ as cashback. Use goCash+ on bookings and save more!",
                            "pt" : "Earn goCash+ on bookings"
                        ] ],
                    "title" : "Titanium Level Benefits"
                    ], [
                        "point" : [ [
                            "locked" : false,
                            "pst" : "Get 4 goCars vouchers worth ₹350 each which can be used for your inter-city travel on Goibibo.",
                            "pt" : "4 Complimentary goCars Vouchers"
                            ], [
                                "locked" : false,
                                "pst" : "Get ₹1000 goCash+ as a one-time benefit when your Rewards level gets upgraded to Platinum",
                                "pt" : "₹1000 goCash+ on upgrade"
                            ], [
                                "locked" : false,
                                "pst" : "Access to our priority hotline for us to assist you in your travel queries instantaneously.",
                                "pt" : "Priority hotline (Coming Soon)"
                            ] ],
                        "title" : "Titanium Exclusive Privileges"
                    ] ],
                "bgColorEnd" : "#565656",
                "bgColorStart" : "#306a9f",
                "bgcolor" : "#565656",
                "gcpMax" : 20000,
                "gcpMin" : 8000,
                "id" : 4,
                "msg1" : "Earn ₹<gcp> goCash+ to reach Titanium level",
                "msg2" : "View Benefits",
                "name" : "Titanium level",
                "nextTierMsg" : "Awesome! Enjoy the benefits of being our most valued customer",
                "pbcolor" : "#2ddf39",
                "tierUpgradeMsg" : [
                    "bgColor" : "#2ad321",
                    "subTitle" : "You’ve earned ₹<gcp> goCash+, you are now a <level> Member",
                    "title" : "Congrats! You are now a <level> Member",
                    "txtColor" : "#ffffff"
                ],
                "unlockedmsg" : "Congrats! You have leveled up",
                "upgrade_benefit" : 0
            ] ]

        return dic
    }
    
    //MARK:faq
    static func defaultGoCashFaqValues() -> [[String:Any]] {
        let dic = [ [
            "ans" : "goCash+ is your travel currency at Goibibo. You can use 100% of your goCash+ without any restrictions on Flight, Hotel, Bus and Cab bookings.",
            "que" : "What is goCash+?"
            ], [
                "ans" : "Earn goCash+ by referring your friends, amazing cashbacks through travel bookings, syncing your contacts and much more. Start earning goCash+ by visiting the ‘Earn’ section on the App",
                "que" : "How do I earn goCash+?"
            ], [
                "ans" : "goCash+ is 100% redeemable. 100% of the goCash+ can be used on flight, hotel, bus and cab bookings without any restrictions.",
                "que" : "How can I use my goCash+?"
            ], [
                "ans" : "credits is the part of Goibibo wallet which has usage restrictions. Look for the flights, hotels, bus and cabs sections to understand the usage rules.",
                "que" : "What is credits? Are there any usage rules?"
            ], [
                "ans" : "Your goCash+ Rewards level is calculated based on the total amount of goCash+ you have earned in the last 12 months. The goCash+ earned is calculated from the program start date - 1st July 2018.",
                "que" : "How is my goCash+ Rewards level calculated?"
            ], [
                "ans" : "Keep levelling up and enjoy a plethora of benefits ranging from free hotel room upgrades, free seat & meals on flights to free airport lounge access passes.",
                "que" : "What are the benefits from goCash+ Rewards?"
            ], [
                "ans" : "goCash+ earned through friends gifting, one time reward upgrade benefit, wallet top-up, cancellation refunds, goTime promise is not calculated under Rewards program.",
                "que" : "Is every goCash+ I have earned calculated under Rewards program?"
            ] ]
        
        
        return dic
    }
    static func defaultGoCashHowToEarnValues() -> [String:Any] {
        return ["hd":"How to Earn goCash+?","subhd":"Earn goCash+ each time you book, Invite friends, and help others in Goibibo.","way":[["amt":"₹300","cur":"goCash+","st":"Create an account using your mobile number.","t":"Sign Up"],["amt":"₹300","cur":"goCash+","st":"Create an account using your mobile number.","t":"Sign Up"]]]
    }
    //MARK:Filter
    static func defaultGoCashFilterValues() -> [[String:Any]] {
        let dic = [ [
            "id" : "all",
            "txt" : "All"
            ], [
                "id" : "rewards",
                "txt" : "Rewards"
            ], [
                "id" : "gocashplus",
                "txt" : "goCash+"
            ], [
                "id" : "gocash",
                "txt" : "credits"
            ], [
                "id" : "mycash",
                "txt" : "Refund / Top-up"
            ] ]

        return dic
    }
    //MARK:Gocash Action
    static func defaultGoCashActionValues() -> [[String:Any]] {
        let dic = [ [
            "id" : 1,
            "txt" : "Top-up"
            ], [
                "id" : 2,
                "txt" : "Gift"
            ], [
                "id" : 3,
                "txt" : "Earn"
            ], [
                "id" : 4,
                "txt" : "More"
            ] ]

        return dic
    }
    //MARK:Gocash Guest state
    static func defaultGoCashGuestStateValues() -> [String:Any] {
        let dic = ["basepoint" : [ "Free room upgrade on hotel bookings", "Free seat and meals on flight bookings", "Avail lounge access at airports", "Get intercity goCars vouchers" ],
            "headerttxt" : "Sign-up now and earn ₹200 goCash+",
            "toppoint" : [ [
                "img" : "https://i.imgur.com/gUDc9Mj.png",
                "st" : "goCash+ is your travel currency at Goibibo. You can use 100% of your goCash+ without any restrictions on Flight, Hotel, Bus and Cab bookings.",
                "t" : "What is goCash+?"
                ], [
                    "img" : "https://i.imgur.com/EISXNtv.png",
                    "st" : "Earn goCash+ by referring your friends, amazing cashbacks through travel bookings, syncing your contacts and many more.",
                    "t" : "How do I earn goCash+?"
                ], [
                    "img" : "https://i.imgur.com/ja2YlKP.png",
                    "st" : "Keep earning goCash+ and jump up the rewards wagon! With every goCash+ you earn, you are a step closer to being our 'Titanium' customer with all exclusive benefits",
                    "t" : "What is goCash+ Rewards?"
                ] ]
            ] as [String : Any]

        return dic
    }
    //MARK:Gocash Guest state
    static func defaultGoCashRewardsValues() -> [String:Any] {
        return [String:Any]()
    }
    
    //MARK:Rewards Intro
    
    static func defaultSignupRewardsIntro() -> [String:Any] {
        return ["title":"Congrats <fname>!","cta":[["txt":"Continue"]],"tipAndSubtitles":[["id" : 0,"subtitle" : "You’ve earned goCash+ for signing up and enrolled to new rewards program.","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 1,"subtitle" : "You’ve earned goCash+ for signing up and enrolled to new rewards program.","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 2,"subtitle" : "You’ve earned goCash+ for signing up and enrolled to new rewards program.","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 3,"subtitle" : "You’ve earned goCash+ for signing up and enrolled to new rewards program.","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 4,"subtitle" : "You’ve earned goCash+ for signing up and enrolled to new rewards program.","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"]]]
    }
    
    static func defaultUpgradeRewards() -> [String:Any] {
        return ["title":"Congrats <fname>!","cta":[["txt":"Continue"]],"cta_learn":["txt":"Learn more"],"tipAndSubtitles":[["id" : 0,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 1,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 2,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 3,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 4,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"]]]
    }
    
    static func defaultSignInRewards() -> [String:Any] {
        return ["title":"Congrats <fname>!","cta":[["txt":"Continue"]],"tipAndSubtitles":[["id" : 0,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 1,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 2,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 3,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"],["id" : 4,"subtitle" : "You are now enrolled to our goCash+ Rewards program","tip" : "TIP: Earn more goCash+ to level up and get amazing upgrade benefits"]]]
    }
    
    static func defaultAppUpgradeRewards() -> [String:Any] {
        return ["title":"You have been upgraded","cta_learn":["txt":"Learn more"],"cta":[["txt":"Continue"]],"tipAndSubtitles":[["id" : 0,
            "subtitle" : "You have been upgraded to our new goCash+ Rewards program. Happy travelling!",
            "tip" : "TIP : Did you know you can use 100% goCash+ on your flight and hotel bookings? You can also earn goCash+ cashback on every booking as a Bronze member."],["id" : 1,"subtitle" : "You have been upgraded to our new goCash+ Rewards program. Happy travelling!","tip" : "TIP : Did you know you can use 100% goCash+ on your flight and hotel bookings? You can also earn goCash+ cashback on every booking as a Bronze member."],["id" : 2,"subtitle" : "You have been upgraded to our new goCash+ Rewards program. Happy travelling!","tip" : "TIP : Did you know you can use 100% goCash+ on your flight and hotel bookings? You can also earn goCash+ cashback on every booking as a Bronze member."],["id" : 3,"subtitle" : "You have been upgraded to our new goCash+ Rewards program. Happy travelling!","tip" : "TIP : Did you know you can use 100% goCash+ on your flight and hotel bookings? You can also earn goCash+ cashback on every booking as a Bronze member."],["id" : 4,"subtitle" : "You have been upgraded to our new goCash+ Rewards program. Happy travelling!","tip" : "TIP : Did you know you can use 100% goCash+ on your flight and hotel bookings? You can also earn goCash+ cashback on every booking as a Bronze member."]]]
    }
    
    static func getDefaultOnboardingInstallSourceWelcomeData() -> [[String:Any]]{
        return [
            ["bgImage":"https://imgur.com/79n1VBc.jpg", "lob":["dh"], "sub_lob":["couple"]],
            ["bgImage":"https://imgur.com/lwaLCUB.jpg", "lob":["dh"], "sub_lob":["student"]],
            ["bgImage":"https://imgur.com/RMXjSxQ.jpg", "lob":["dh"], "sub_lob":["business"]],
            ["bgImage":"https://imgur.com/FRg3uFJ.jpg", "lob":["dh"], "sub_lob":["women"]],
            ["bgImage":"https://imgur.com/9TPlKix.jpg", "lob":["dh"], "sub_lob":["pilgrims"]],
            ["bgImage":"https://imgur.com/RxnKeA6.jpg", "lob":["train"], "sub_lob":["train"]],
            ["bgImage":"https://imgur.com/ep0Vwlq.jpg", "lob":["df"], "sub_lob":["new user"]],
            ["bgImage":"https://imgur.com/Og9QniN.jpg", "lob":["cab"], "sub_lob":["new user"]],
            ["bgImage":"https://imgur.com/WHpl4Xy.jpg", "lob":["bus"], "sub_lob":["new user"]],
            ["bgImage":"https://imgur.com/rSPxmGA.jpg", "lob":["exp"], "sub_lob":["all"]],
            ["bgImage":"https://imgur.com/mmA7Due.jpg", "lob":["rewards"], "sub_lob":["all"]]
        ]
    }
    
    static func getDefaultHomeRecentSearchesLimit() -> Int {
        return 10
    }
    
    static func getDefaultHomeStatePositions() -> Dictionary<String, Any> {
        return [
            "h_guest": ["RS","GU"],
            "in_first_newtask": ["UL","TA","RS", "WE", "GP", "WN", "GA"],
            "in_first_notnewtask": ["UL", "RS", "WE", "GP", "WN", "TA", "GA"],
            "in_notfirst_newtask": ["TA","RS", "WE", "GP", "UL", "WN", "GA"],
            "in_notfirst_notnewtask": ["RS", "WE", "GP", "UL", "WN", "TA", "GA"]
        ]
    }
    
    static func getDefaultOnboardingWelcomeData() -> [[String:Any]]{
        return [
            ["title":"Signup Now to", "subtitle1":"Get benefits at each level ","subtitle2":"like free meals, room upgrade and more", "bgImage":"onboardingBgImg","logoImage":"rewardsLogo"],
            ["title":"Signup Now to", "subtitle1":"Earn goCash+ instantly","subtitle2":"and use 100% goCash+ without restrictions","bgCornerImage":"onboardingRupee","type":1],
            ["title":"Signup Now to", "subtitle1":"Earn when your friends travel","subtitle2":"and plan your next dream vacation together","bgCornerImage":"onboardingFriends"],
            ["title":"Signup Now to", "subtitle1":"Get answers to your questions","subtitle2":"from real users in the Goibibo travel community","bgCornerImage":"onboardingQnA"]
        ]
    }
    
    
    static func getDefaultOnboardingWelcomeDataForIpl() -> [[String:Any]]{
        return [
            ["title":"Signup Now to", "subtitle1":"Join the Travel Cash Fest","subtitle2":"Earn Travel Cash Live with RCB & KKR. Use 100% on Hotels and Flights.", "bgImage":"onboardingBgImg","logoImage":"https://gos3.ibcdn.com/ipl_tcfest-1552654008.png"],
            ["title":"Signup Now to", "subtitle1":"Save on Travel Bookings as RCB & KKR play","subtitle2":"Earn Travel Cash with every 4, 6, 50, 100, Win, Scratch Cards & more.","type":1,"logoImage":"https://gos3.ibcdn.com/ipl_rcb_kkr_logos-1552654040.png"],
            ["title":"", "subtitle1":"Use Travel Cash to","subtitle2":"Book a Hotel, Flight, Bus, Cab, Experience or Buy a goPass","logoImage":"https://gos3.ibcdn.com/ipl_play_and_earn-1552653920.png"],
            ["title":"Signup Now to", "subtitle1":"Earn Rs. 100 goCash+ instantly","subtitle2":"And join India’s largest Travel Loyalty Program","logoImage":"rewardsLogo"]
        ]
    }
    
    static func getCFOccasionList() -> [[String:Any]]{
        return []
//        return [["name": "Birthday","imgUrl": "https://i.imgur.com/Sd21EbK.png","taskType": "birthday","smileyCode": "\u{1F635}","colorCode": "#de547e","donor_heading":"is celebrating", "create_heading":"<name> birthday celebration in <destination> on <date>","popup_msg1":"wished you","popup_msg2":"Happy Birthday","popup_img":"https://i.imgur.com/Sd21EbK.png"],["name": "anniversary","imgUrl": "","taskType": "anniversary","smileyCode": "\u{1F635}","colorCode": "#3802d0","donor_heading":"is celebrating", "create_heading":"<name> birthday celebration in <destination> on <date>","popup_msg1":"wished you","popup_msg2":"Happy Birthday","popup_img":"https://i.imgur.com/Sd21EbK.png"]]
    }
    
    
    static func getCFHowItWorkSData() -> [[String:Any]]{
     return [["msg": "A sample event is created","img": "https://i.imgur.com/OxsC3MS.png","cellType": "left"],["msg": "Friends can wish and contribute for your event","img": "https://i.imgur.com/O5kIn1B.png","cellType": "right"],["msg": "We'll notify you when a friend a wishes","img": "https://i.imgur.com/ThIgsPN.png","cellType": "left"]]

    }
    
    static func getCfGiftItemData() -> [String:Any]{
        return [String:Any]()
//        return ["birthday":[["title":"Special Gift","subtitle":"Send a basic Happy Bday Message","cardId":100, "cardBgColor":"#46eeaa","cardBgImg":"https://imgur.com/yuSfsOB.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":false],
//                            ["title":"Premium Gift","subtitle":"Send a special message to your friend.","cardId":101, "cardBgColor":"#f5317f","cardBgImg":"https://imgur.com/VcKCDo0.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":true],["title":"Basic Gift","subtitle":"Wish your Friend happy birthday","cardId":102, "cardBgColor":"#ff8b59","cardBgImg":"https://imgur.com/Mae0FmX.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":false]],
//
//                "anniversary":[["title":"Special Gift","subtitle":"Send a basic Happy Bday Message","cardId":100, "cardBgColor":"#46eeaa","cardBgImg":"https://imgur.com/yuSfsOB.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":false],
//                               ["title":"Premium Gift","subtitle":"Send a special message to your friend.","cardId":101, "cardBgColor":"#f5317f","cardBgImg":"https://imgur.com/VcKCDo0.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":true],
//                               ["title":"Basic Gift","subtitle":"Wish your Friend happy birthday","cardId":102, "cardBgColor":"#ff8b59","cardBgImg":"https://imgur.com/Mae0FmX.png","cardImg":"https://i.imgur.com/Sd21EbK.png","showGiftMsg":false]]]
    }
    
    
    static func getCFCreateeTaskData() -> [String:Any]{
        return ["cFHeadingText":"Create an Event","cFSubheadingText":"Let’s create an event and help you \n celebrate it better with your friends","cFBackGroundColor":"#2276e3","cFOccasionCellHeading":"What’s the Occasion ?","cFDestinationHeading":"Where are you celebrating ?","cFDestinationPlaceHolder":"Enter your dream destination","cFDateHeading":"When are you celebrating ?","cFDatePlaceHolder":"dd/mm/yyyy","cFBudgetHeading":"Enter a Budget","cFMaxBudget":10000,"cFMinBudget":100,"cFAddBudgetLabelColor":"#ff7d24","cFBudgetPlaceHolder":"Enter or slide to select budget","cdAddBudgetText":"Have a budget in mind ?","removeBudgetText":"Remove","cFCreateEventButtonTitle":"CREATE EVENT","cFOccasionList":DefaultValueProvider.getCFOccasionList()]
    }
    
    
    static func getScratchCardTaskData() -> [String:Any]{
        return ["percentage":35,"heading":"Scratch & Win","ctaDta":["txt":"Continue","bgColor":"#ff6d38","color":"#ffffff","tag":0],"onFaliure":["title":"😅 OOPS !","midLabel":"No Rewards for you today","bottomLabel":"Try again tomorrow. We have rewards for you everyday.","ImageUrl":""],"onSucess":["title":"🤩 Hooray !","midLabel":"","bottomLabel":"","ImageUrl":"https://gos3.ibcdn.com/go_coin-1542796195.png"]]
    }
    
    static func getTrainCalendarHeaderData() -> Array<Dictionary<String,Any?>> {
        
       let data =  [[ "imageName":nil,
               "backGroundColor":"#7ED321",
               "title": "AVAILABLE"
            ],
            [  "imageName":nil,
               "backGroundColor":"#F26722",
               "title": "WAITING LIST"
            ],
            [   "imageName":nil,
                "backGroundColor":"#d0021b",
                "title": "REGRET"
            ],
            [
                "imageName":"invalidName",
                "backGroundColor":"#ffffff",
                "title": "HOLIDAY"
            ],
            [
                "imageName":nil,
                "backGroundColor":"#d0021b",
                "title": "TRAIN DEPARTED"
            ],
            [
                "imageName":nil,
                "backGroundColor":"#ff0000",
                "title": "NOT AVAILABLE"
            ],
            [
                "imageName":nil,
                "backGroundColor":"#d0021b",
                "title": "TRAIN DOES NOT RUN"
            ]
        ]
        
        return data
    }
    
    static func getTrainHomePageTitleArray() -> Array<String> {
        let titlesArray = ["Book Train", "PNR Status", "Train Status"]
        return titlesArray
    }
    
    
    
    //,"successData":["heading":"🤩 Hooray !","midImageUrl":"","midleLabel":""],"onFaliureData":["heading":"😅 OOPS !","midleLabel":"No Rewards for you today","midLabel":"No Rewards for you today"]
}
