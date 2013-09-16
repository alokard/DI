#import <Kiwi.h>
#import "CRDISingletoneBuilder.h"
#import "CRDISampleClass.h"

SPEC_BEGIN(CRDiSingletoneBuilderSpec)

describe(@"CRDiSingletoneBuilderSpec", ^{
    
    Class cls = [CRDISampleClass class];
    __block CRDISingletoneBuilder *singletoneBuilder = nil;
    
    
    beforeAll(^{
        singletoneBuilder = [[CRDISingletoneBuilder alloc] initWithClass:cls];
    });
    
    it(@"Should return always same instance", ^{
        id instance = [singletoneBuilder build];
        for (NSInteger i=0; i<10; i++) {
            id otherInstance = [singletoneBuilder build];
            [[instance should] equal:otherInstance];
        }
    });
    
    it(@"Should return instance with same class of instance builder", ^{
        id instance = [singletoneBuilder build];
        [[instance should] beKindOfClass:cls];
    });
    
    
});

SPEC_END