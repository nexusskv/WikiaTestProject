//
//  WTPDataLoader.m
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import "WTPDataLoader.h"
#import "AFHTTPRequestOperation.h"
#import "Constants.h"


@implementation WTPDataLoader

#pragma mark - initWithCallback:
- (id)initWithCallback:(LoadDataCallback)block
{
    if (self = [super init])
    {
        self.callbackBlock = block;
    }
    
    return self;
}
#pragma mark -


#pragma mark - loadDataByPage:
- (void)loadDataByPage:(long)page {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@=%lu&%@=%ld", kWikiURL, kLimit, kLimitValue, kBatch, page]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([[(NSDictionary *)responseObject allKeys] count] > 0) {
                        if ([(NSArray *)responseObject[@"items"] count] > 0)
                            self.callbackBlock(responseObject);
                        else
                            NSLog(@"Items list is empty");
            }
            else
                NSLog(@"Response is empty");
        }        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request error: %@", error.description);
    }];
    [operation start];
}
#pragma mark -

@end
