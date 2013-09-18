//
//  CRDIClassInspector.h
//  CRDI
//
//  Created by Sergey Zenchenko on 9/18/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DIClassTemplate.h"

@interface CRDIClassInspector : NSObject

- (DIClassTemplate*)inspect:(Class)instanceClass;

@end
