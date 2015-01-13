//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Don Wettasinghe on 1/12/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onAddButtonPressed:(UIButton *)sender {
    
    [self.dataArray addObject:self.contentText.text];
    
    [self.tableView reloadData];
}

#pragma mark UItableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text=[NSString stringWithFormat:@"%@", [self.dataArray objectAtIndex:indexPath.row] ];
   // [tableView insertRowsAtIndexPaths:indexPath.row withRowAnimation:UITableViewRowActionStyleNormal];
    
    return cell;
}


@end
