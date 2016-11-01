//
//  SHPlayerConfig.h
//  SohaPlayer
//
//  Created by Le Cuong on 10/14/16.
//  Copyright © 2016 Le Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// SHPlayerConfig keys
static NSString *SHPlayerConfigNativeCallOutKey = @"nativeCallout";
static NSString *SHPlayerConfigChromecastKey = @"chromecast.plugin";
static NSString *SHPlayerConfigNativeAdIdKey = @"nativeAdId";

@protocol SHPlayerConfigDelegate <NSObject>

@required
- (void)sourceUrlReadyPlay;

- (void)linkPlayError:(NSError*)error;

@end




@interface SHPlayerConfig : NSObject

- (instancetype)initWithServer:(NSString *)serverURL uiConfID:(NSString *)uiConfId partnerId:(NSString *)partnerId;

// with source url for player, no need request to get real source url.
- (instancetype)initWithSourceUrl:(NSString *)sourceUrl appkey:(NSString*)appkey secretKey:(NSString*)secretKey vid:(NSString*)v_id;

- (instancetype)initWithShortLinkUrl:(NSString *)linkUrl appkey:(NSString*)appkey secretKey:(NSString*)secretKey vid:(NSString*)v_id;

- (instancetype)initWithDomain:(NSString *)domain uiConfID:(NSString *)uiConfId partnerId:(NSString *)partnerId
DEPRECATED_MSG_ATTRIBUTE("Use initWithServer:uiConfID:partnerId:");

+ (instancetype)configWithEmbedFrameURL:(NSString*)url;


+(instancetype)configWithDictionary:(NSDictionary*)configDict;

@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *partnerId;

@property (nonatomic, readonly) NSString *uiConfId;

//add by lecuong.vcc
@property (nonatomic, readonly) NSString *appkey;

@property (nonatomic, readonly) NSString *secretKey;

@property (nonatomic, readonly) NSString *v_id;

@property (nonatomic, readonly) NSString *sourceUrl;

@property (nonatomic, readonly) NSString *shortLink;
//

@property (nonatomic, copy) NSString *localContentId;

@property (nonatomic, copy) NSString *ks;
@property (nonatomic, copy) NSString *entryId;
@property (nonatomic, copy) NSString *advertiserID;
@property (nonatomic) BOOL enableHover;

@property (nonatomic, copy) NSDictionary* supportedMediaFormats;


/// Enables the SDK user to define interface orientation of the player
@property (nonatomic) UIInterfaceOrientationMask supportedInterfaceOrientations;

@property (nonatomic) float cacheSize;

//lecuong add.
@property (nonatomic, weak) id<SHPlayerConfigDelegate> delegate;

/** Adds flags for the video request
 *
 *  @param NSString The name of the flag
 *  @param NSString The value for the flag
 */
- (void)addConfigKey:(NSString *)key withValue:(NSString *)value;

/** Converts dictionary to JSON and Adds flags to the video request
 *
 *  @param NSString The name of the flag
 *  @param NSDictionary The dictionary for the flag
 */
- (void)addConfigKey:(NSString *)key withDictionary:(NSDictionary *)dictionary;

- (NSURL *)videoURL;

- (NSURL *)sourceURL;

- (NSURL *)appendConfiguration:(NSURL *)videoURL;

-(NSMutableArray<NSURLQueryItem*>*)queryItems;

@end
