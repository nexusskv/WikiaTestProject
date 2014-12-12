//
//  WTPDataLoader.h
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^LoadDataCallback)(id);


@interface WTPDataLoader : NSObject

@property (nonatomic, copy) LoadDataCallback callbackBlock;

- (id)initWithCallback:(LoadDataCallback)block;
- (void)loadDataByPage:(long)page;
@end
