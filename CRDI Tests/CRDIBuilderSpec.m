//
//  CRDIBuilderSpec.m
//  CRDI
//
//  Created by TheSooth on 9/16/13.
//  Copyright (c) 2013 CriolloKit. All rights reserved.
//

#import <Kiwi.h>
#import "CRDIClassBuilder.h"
#import "CRDIBlockBuilder.h"
#import "CRDIContainer.h"

#import "CRDISampleClass.h"

SPEC_BEGIN(CRDIClassBuilderSpec)

describe(@"CRDIClassBuilderSpecs", ^{
    context(@"Class builder", ^{
        __block CRDIClassBuilder *classBuilder = nil;
        
        beforeAll(^{
            classBuilder = [[CRDIClassBuilder alloc] initWithClass:[CRDISampleClass class]];
        });
        
        it(@"class builder should not be nil", ^{
            [[classBuilder shouldNot] beNil];
            [[classBuilder should] beKindOfClass:[CRDIClassBuilder class]];
        });
        
        it(@"builded object should not be nil", ^{
            [[[classBuilder build] shouldNot] beNil];
        });
        
        it(@"buider should build object of class CRSampleClass", ^{
            CRDISampleClass *sampleClass = [classBuilder build];
            
            [[sampleClass should] beKindOfClass:[CRDISampleClass class]];
        });
    });
    
    context(@"Block builder", ^{
        __block CRDIBlockBuilder *blockBuilder = nil;
        
        NSNumber *testingObject = @(100500);
        
        beforeAll(^{
            blockBuilder = [[CRDIBlockBuilder alloc] initWithBlock:^id{
                return testingObject.copy;
            }];
        });
        
        it(@"block builder should not be nil", ^{
            [[blockBuilder shouldNot] beNil];
        });
        
        it(@"builded object should not be nil", ^{
            id buildedObject = [blockBuilder build];
            NSLog(@"%@", buildedObject);
            
            [[buildedObject shouldNot] beNil];
        });
        
        it(@"returned int of builded object should equal to int of testingObject", ^{
            NSInteger buildedInt = [[blockBuilder build] integerValue];
            
            [[theValue(buildedInt) should] equal:theValue(testingObject.integerValue)];
        });
    });
});

SPEC_END
