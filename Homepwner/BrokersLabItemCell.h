//
//  BrokersLabItemCell.h
//  BrokersLab
//
//  Created by Jeffrey Moran on 8/31/13.
//
//

#import <Foundation/Foundation.h>

@interface BrokersLabItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *tableView;


@end