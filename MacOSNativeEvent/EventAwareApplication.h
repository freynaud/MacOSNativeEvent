//
//  EventAwareApplication.h
//  MacOSNativeEvent
//
//  Created by François Reynaud on 11/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *launchPath;
static int safariMenuHeigth;

@interface  EventAwareApplication : NSObject {

    ProcessSerialNumber psn;
    NSTask *task;
    NSArray *args;
    int  pid;
    int windowId;
    
}

//@property (assign) NSTask *task;
@property (assign) NSArray *args;
@property int  pid;
@property int windowId;

+ (void) initialize;

- (id)initWithParam: (NSArray *)args;
- (void)start;
- (void)stop;
- (int) windowId;
- (void) mouseDown: (int)x onY:(int)y;
- (void) mouseUp: (int)x onY:(int)y;

@end
