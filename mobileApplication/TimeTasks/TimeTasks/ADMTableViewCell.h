//
//  ADMTableViewCell.h
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADMTimeTask;

@interface ADMTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *taskDescriptionLabel;

@property (nonatomic, weak) IBOutlet UILabel *taskExpectedMinutesLabel;

@property (nonatomic, weak) IBOutlet UILabel *taskPriorityLabel;

@property (nonatomic, weak) IBOutlet UIImageView *taskCheckBoxImageView;

- (void) drawForTask:(ADMTimeTask *) aTask;

- (void) setChecked: (BOOL) checked;

@end
