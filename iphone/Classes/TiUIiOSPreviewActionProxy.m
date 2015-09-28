/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#if IS_XCODE_7
#ifdef USE_TI_UIIOSPREVIEWACTION
#import "TiUIiOSPreviewActionProxy.h"

@implementation TiUIiOSPreviewActionProxy

-(void)_initWithProperties:(NSDictionary *)properties
{
    [self setTitle:[TiUtils stringValue:[properties valueForKey:@"title"]]];
    [self setStyle:[TiUtils intValue:[properties valueForKey:@"style"] def:UIPreviewActionStyleDefault]];
    
    [super _initWithProperties:properties];
}
                  
-(void)dealloc
{
    RELEASE_TO_NIL(action);
    
    [super dealloc];
}

-(NSString*)apiName
{
    return @"Ti.UI.iOS.PreviewAction";
}

-(UIPreviewAction*)action
{
    action = [UIPreviewAction actionWithTitle:[self title] style:[self style] handler:^void(UIPreviewAction *_action, UIViewController *_controller) {
        if([self _hasListeners:@"click"]) {
            [self fireEventWithAction:_action];
        }
    }];
    
    return action;
}

-(void)fireEventWithAction:(UIPreviewAction*)action
{
    NSDictionary *event = @{
        @"index" : NUMINT([self actionIndex]),
        @"title" : [self title],
        @"style" : NUMINT([self style])
    };
    
    [self fireEvent:@"click" withObject:event];
}

@end
#endif
#endif