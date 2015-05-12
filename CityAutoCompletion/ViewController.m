//
//  ViewController.m
//  CityAutoCompletion
//
//  Created by Bryan Bolivar Martinez on 5/12/15.
//  Copyright (c) 2015 Bryan Bolivar Martinez. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
NSString * const kCountry = @"USA";
#warning Insert your Google API key and enable place services, then delete me
NSString * const kGoogleAPIKey = @"USE-YOUR-KEY-HERE";
@interface ViewController (){
    NSArray *results;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)updateRequest:(UITextField *)sender {
    NSString *requestStr;
    requestStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@,%@&types=(cities)&language=es_CO&key=%@",kCountry,sender.text, kGoogleAPIKey];
    requestStr = [requestStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *citiesArray = [[NSMutableArray alloc] init];
        for (NSDictionary* local in [responseObject objectForKey:@"predictions"]){
            NSString * city = [[[local  objectForKey:@"terms"] objectAtIndex:0] objectForKey:@"value"];
            NSString * locality = [[[local objectForKey:@"terms"] objectAtIndex:1] objectForKey:@"value"];
            NSDictionary * dict = @{@"city":city,@"locality":locality };
            NSLog(@"%@", dict);
            [citiesArray addObject:dict];
        }
        results = [citiesArray copy];
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)userEndEditing:(UITextField *)sender {
    

}

- (IBAction)hideKeyBoard:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cityCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary * dict = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@",[dict objectForKey:@"city"], [dict objectForKey:@"locality"]];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict = [results objectAtIndex:indexPath.row];
    self.title = [dict objectForKey:@"city"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return results.count;
}

@end
