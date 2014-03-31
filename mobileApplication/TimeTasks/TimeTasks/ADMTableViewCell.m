//
//  ADMTableViewCell.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMTableViewCell.h"

#import "ADMTimeTask.h"

@implementation ADMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) drawForTask:(ADMTimeTask *) aTask{

    self.taskDescriptionLabel.text = aTask.description;
    self.taskExpectedMinutesLabel.text = [NSString stringWithFormat:@"%d", aTask.time];
    self.taskPriorityLabel.text = [NSString stringWithFormat:@"%d", aTask.priority];
    
    [self setChecked: aTask.completed];
    
    
}

- (void) setChecked:(BOOL)checked{

    self.taskCheckBoxImageView.image = (checked) ? [UIImage imageNamed:@"checkbox_checked"] : [UIImage imageNamed:@"checkbox"];

}

@end
