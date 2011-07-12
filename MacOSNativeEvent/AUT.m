//
//  AUT.m
//  MacOSNativeEvent
//
//  Created by François Reynaud on 12/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AUT.h"
#import "EventFactory.h"


@implementation AUT

+ (void) initialize {
    launchPath = @"/Applications/Safari.app/Contents/MacOS/Safari";
    apps = [[NSMutableDictionary alloc]init];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}




@synthesize sessionId;
@synthesize args;
@synthesize windowId;
@synthesize pid;
@synthesize factory;
@synthesize psn;

//@property NSArray *args;
//@property int  pid;
//@property int windowId;

- (id)initWithParam: (NSArray *)args {
    self = [super init];
    if (self) {
        self.args = args;
        NSString *html = (NSString*)[args objectAtIndex:0];
        sessionId = [html  stringByReplacingOccurrencesOfString:@".html" withString:@""];
        [apps setObject:self forKey:sessionId];
        factory = [[EventFactory alloc] initWithApplication:self];
        //NSLog(@"-> %@",apps);
    }
    return self;
    
}

+ (AUT*)getApplicationForSession: (NSString *)sessionId {
    return [apps objectForKey:sessionId];
}

- (void)start {
    NSLog(@"Launching safari %@ %@",launchPath, args);
    
    task = [[NSTask alloc] init];
    [task setLaunchPath: launchPath];
    
    [task setArguments: args];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    [task launch];
    pid_t pid = [task processIdentifier];
    self.pid = pid;
    
    // TODO freynaud lazy load to have the network latency absorb the loading time.
    int res = GetProcessForPID(self.pid ,&psn);  
    while(res != noErr) {
        NSLog(@"Failed with result code: %d\n", res);
        sleep(1);
        res = GetProcessForPID(self.pid ,&psn);
    }
}

- (int) windowId {
    while (windowId == 0) {
        CGWindowListOption listOptions = kCGWindowListOptionAll;
        listOptions = listOptions | kCGWindowListOptionOnScreenOnly;
        listOptions = listOptions | kCGWindowListExcludeDesktopElements;
        
        
        CFArrayRef windowList = CGWindowListCopyWindowInfo(listOptions, kCGNullWindowID);
        NSMutableArray *windows = [(NSArray*)windowList mutableCopy];
        CFRelease(windowList);
        
        NSEnumerator *e3 = [windows objectEnumerator];
        id win;
        while (win = [e3 nextObject]) {
            //if ( [ [win objectForKey:(id)kCGWindowOwnerName] isEqualToString: @"Safari"]){
            /* NSLog(@" %@ ",[win objectForKey:(id)kCGWindowOwnerName]);
             NSLog(@" %@ ",[win objectForKey:(id)kCGWindowOwnerPID]);
             NSLog(@" %@ ",[win objectForKey:(id) kCGWindowNumber]);
             NSLog(@" %@ ",[win objectForKey:(id) kCGWindowName]);*/
            
            CFNumberRef widRef = [win objectForKey:(id) kCGWindowNumber];
            CFNumberRef pidRef = [win objectForKey:(id)kCGWindowOwnerPID];
            
            
            int tmp = 0;
            CFNumberGetValue(pidRef, CFNumberGetType(pidRef), &tmp);
            int pid = tmp;
            if (pid == self.pid){
                CFNumberGetValue(widRef, CFNumberGetType(widRef), &tmp);
                int wid = tmp;
                windowId = wid;
                NSLog(@"on windowId : %d",windowId);
                return windowId;
            }
            
        }
        NSLog(@"Cannot find the windows id. Trying again.");
        sleep(1);
    }
    return windowId;
}


- (void) mouseDown: (int)x onY:(int)y {
    /*CGEventRef CGEvent;
    NSEvent *customEvent;
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    
    int maxX = size.width; 
    int maxY = size.height;
    
    
    int offsetY = maxY - safariMenuHeigth - y;
    NSPoint point = {x,offsetY};
    
    NSDate * past = [NSDate date];
    NSTimeInterval current = [past timeIntervalSince1970];
    
    customEvent = [NSEvent mouseEventWithType: NSLeftMouseDown
                                     location: point 
                                modifierFlags: NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: windowId
                                      context: nil
                                  eventNumber: 0
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    CGEventPostToPSN(&psn, CGEvent);*/
    [factory mouseDown:x onY:y];
    
}

- (void) mouseUp: (int)x onY:(int)y {
    /*CGEventRef CGEvent;
    NSEvent *customEvent;
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    
    int maxX = size.width; 
    int maxY = size.height;
    
    
    int offsetY = maxY - safariMenuHeigth - y;
    NSPoint point = {x,offsetY};
    
    NSDate * past = [NSDate date];
    NSTimeInterval current = [past timeIntervalSince1970];
    
    customEvent = [NSEvent mouseEventWithType: NSLeftMouseUp
                                     location: point 
                                modifierFlags: NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: windowId
                                      context: nil
                                  eventNumber: 0
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    CGEventPostToPSN(&psn, CGEvent);*/
     [factory mouseUp:x onY:y];
}

- (void)stop {
    if (task != nil){
        [task terminate];
    }
    if (sessionId!=nil){
        [apps removeObjectForKey:sessionId];
    }
}

@end
