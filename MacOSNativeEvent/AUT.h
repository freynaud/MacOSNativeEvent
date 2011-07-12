//
//  AUT.h
//  MacOSNativeEvent
//
//  Created by François Reynaud on 12/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EventFactory;

static NSString *launchPath;

static NSMutableDictionary *apps;


@interface AUT : NSObject {
    
    
    
    ProcessSerialNumber psn;
    NSTask *task;
    NSArray *args;
    NSString *sessionId;
    int pid;
    int windowId;
    EventFactory *factory;
    
}

//@property (assign) NSTask *task;
@property (assign) NSArray *args;
@property int pid;
@property int windowId;
@property NSString *sessionId;
@property EventFactory *factory;
@property ProcessSerialNumber psn;

+ (void) initialize;

- (id)initWithParam: (NSArray *)args;
+ (AUT*)getApplicationForSession: (NSString *)sessionId;

- (void)start;
- (void)stop;

- (int) windowId;

- (void) mouseDown: (int)x onY:(int)y;
- (void) mouseUp: (int)x onY:(int)y;

@end