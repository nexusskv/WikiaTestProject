//
//  CustomLinksCell.m
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import "CustomLinksCell.h"
#import "UIImageView+AFNetworking.h"


@interface CustomLinksCell ()
@property (nonatomic, strong) UIImageView *wikiImgView;
@property (nonatomic, strong) UILabel *wikiTitleLbl;
@property (nonatomic, strong) UILabel *wikiLinkLbl;
@end


@implementation CustomLinksCell

#pragma mark - Constructor
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.wikiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 50.0f, 50.0f)];
        [self addSubview:self.wikiImgView];
        
        self.wikiTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 10.0f, self.bounds.size.width - 110.0f, 20.0f)];
        self.wikiTitleLbl.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:self.wikiTitleLbl];
        
        self.wikiLinkLbl = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 35.0f, self.bounds.size.width - 110.0f, 15.0f)];
        self.wikiLinkLbl.font = [UIFont boldSystemFontOfSize:13];
        self.wikiLinkLbl.textColor = [UIColor blueColor];
        [self addSubview:self.wikiLinkLbl];
    }
    
    return self;
}
#pragma mark -


#pragma mark - Setters
- (void)setWikiImage:(NSString *)img {
    if ((img) && ([img componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]]))
        [self.wikiImgView setImageWithURL:[NSURL URLWithString:img]];
}

- (void)setWikiTitle:(NSString *)title {
    if ((title) && ([title componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]]))
        self.wikiTitleLbl.text = title;
}

- (void)setWikiLink:(NSString *)link {
    if ((link) && ([link componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]]))
        self.wikiLinkLbl.text = link;
}
#pragma mark -

@end
