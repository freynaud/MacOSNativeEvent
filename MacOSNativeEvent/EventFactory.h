//
//  EventFactory.h
//  MacOSNativeEvent
//
//  Created by François Reynaud on 12/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AUT;

static int safariMenuHeigth;

@interface EventFactory : NSObject {
    AUT *app;    
}


- (id) initWithApplication: (AUT*) app;

- (CGEventRef) mouseDown: (int)x onY:(int)y;
- (CGEventRef) mouseUp: (int)x onY:(int)y;

@end
