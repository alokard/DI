//
//  NSObject+AutoInject.m
//  CRDI
//
//  Created by Sergey Zenchenko on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import "NSObject+AutoInject.h"
#import <objc/runtime.h>
#import "CRDIGlobalAutoInjectionStorage.h"
#import <ISMethodSwizzling/ISMethodSwizzling.h>

static const char *kAutoInjectStorageKey = "kAutoInjectStorageKey";
static const char *kAutoInjectSwizzleFlagKey = "kAutoInjectSwizzleFlagKey";

@implementation NSObject (AutoInject)

- (id)initWithInject
{
    id obj = [self initWithInject];
    
    [[[self class] injector] injectTo:obj];
    
    return obj;
}

+ (void)setInjector:(CRDIInjector *)injector
{
    
    if (![self isInitMethodSwizzled]) {
        ISSwizzleInstanceMethod(self, @selector(init), @selector(initWithInject));
        
        objc_setAssociatedObject(self, &kAutoInjectSwizzleFlagKey, @(YES), OBJC_ASSOCIATION_COPY);
    }
    
    
    NSString *key = [[CRDIGlobalAutoInjectionStorage storage] put:injector];
    
    objc_setAssociatedObject(self, &kAutoInjectStorageKey, key, OBJC_ASSOCIATION_COPY);
}

+ (CRDIInjector*)injector
{
    NSString *key = objc_getAssociatedObject(self, &kAutoInjectStorageKey);
    
    CRDIInjector *injector = nil;
    
    if (key) {
        injector = [[CRDIGlobalAutoInjectionStorage storage] get:key];
    } else {
        Class superClass = [self superclass];
        while (superClass) {
            key = objc_getAssociatedObject(superClass, &kAutoInjectStorageKey);
            if (key) {
                injector = [[CRDIGlobalAutoInjectionStorage storage] get:key];
                if (injector) {
                    [self setInjector:injector];
                    break;
                }
            }
            superClass = [superClass superclass];
        }
    }
    
    return injector;
}

+ (BOOL)isInitMethodSwizzled
{
    NSNumber *isSwizzled = objc_getAssociatedObject(self, &kAutoInjectSwizzleFlagKey);
    
    if (isSwizzled == nil) {
        Class superClass = [self superclass];
        while (superClass) {
            isSwizzled = objc_getAssociatedObject(superClass, &kAutoInjectSwizzleFlagKey);
            if (isSwizzled) {
                break;
            }
            superClass = [superClass superclass];
        }
    }
    
    return [isSwizzled boolValue];
}

@end
