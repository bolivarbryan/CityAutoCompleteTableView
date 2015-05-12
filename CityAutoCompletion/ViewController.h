//
//  ViewController.h
//  CityAutoCompletion
//
//  Created by Bryan Bolivar Martinez on 5/12/15.
//  Copyright (c) 2015 Bryan Bolivar Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)updateRequest:(UITextField *)sender;
- (IBAction)userEndEditing:(UITextField *)sender;
- (IBAction)hideKeyBoard:(id)sender;
@end

