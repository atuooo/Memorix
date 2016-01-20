//
//  ShowTableViewCell.m
//  EveMemory
//
//  Created by Atuooo on 3/20/15.
//  Copyright (c) 2015 Atuooo. All rights reserved.
//

#import "ShowTableViewCell.h"

@implementation ShowTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.IdoImageView.layer.cornerRadius = 5.0;
    self.IdoImageView.layer.masksToBounds = YES;        // ???
    
    self.UdoImageView.layer.cornerRadius = 5.0;
    self.UdoImageView.layer.masksToBounds = YES;
}

@end
