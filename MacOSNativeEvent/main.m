//
//  main.m
//  MacOSNativeEvent
//
//  Created by François Reynaud on 11/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-auto.h>
#import "AUT.h"
#import "HTTPServer.h"

int main (int argc, const char * argv[])
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
     NSLog(@"Hello, World!");
     [[HTTPServer sharedHTTPServer] start];
     [[NSRunLoop mainRunLoop] run]; 
     [pool drain];
     return 0;
    
    
    /*objc_startCollectorThread();
    
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    // insert code here...
    NSLog(@"Hello, World!");
    BOOL debug = NO;
    NSArray *arguments;
    if (debug){
        arguments = [NSArray arrayWithObjects: @"af5748c6-5c80-44f0-a019-26856ecab8a1.html", nil];
        
    }else {
        arguments = [NSArray arrayWithObjects: @"ebay.html", nil];
        
    }
    
    
    AUT *safari = [[AUT alloc] initWithParam:arguments];
    [safari start];
    AUT *safari2;
    if (debug){
        safari2  = [AUT getApplicationForSession:@"af5748c6-5c80-44f0-a019-26856ecab8a1"];
        
    }else {
        safari2 = [AUT getApplicationForSession:@"ebay"];
        
    }
    
    NSLog(@"working on safari : %d",[safari2 pid]);
    NSLog(@"on windowId : %d",[safari2 windowId]);
    [safari2 mouseDown:571  onY:49];
    [safari2 mouseUp:571  onY:49];
    //[safari2 mouseDragged:110  onY:110];
    //[safari2 mouseDown:300 onY:100];
    //for (int i=0;i<1200;i++){
    //   [safari2 mouseMove:i onY:i]; 
    //}
    //[safari2 simulateMouseEvent:CGEventPostToPSN onX:200 onY:200];
    //[safari2 simulateMouseEvent:kCGEventLeftMouseUp onX:200 onY:200];
    NSLog(@"done");
    
    //[safari2 mouseUp:400 onY:18];
    
    
    //[safari2 mouseMove:1200 onY:18];
    //[safari2 mouseUp:100 onY:100];
    
    //sleep(10);
    //[safari2 stop];
    
    return 0;*/
}

