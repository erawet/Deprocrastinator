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
@property BOOL editBtnPress;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *onAddBtn;

@property NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithObjects:self.contentText.text, nil];
    self.editBtnPress=false;
}

- (IBAction)onSwipeGestureColorChange:(UISwipeGestureRecognizer*)sender {
    
    
}
- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self.dataArray addObject:self.contentText.text];
    
    [self.tableView reloadData];
    self.contentText.text=@"";
    [self.view endEditing:YES];
    
}

//- (IBAction)onAddButtonPressed:(UIButton *)sender {
//    
//    [self.dataArray addObject:self.contentText.text];
//    
//    [self.tableView reloadData];
//    self.contentText.text=@"";
//    [self.view endEditing:YES];
//}


- (IBAction)onEditButtonPressed:(UIBarButtonItem*)sender {
    
    if (self.editBtnPress==false) {
        self.editBtnPress=true;
       [self.tableView setEditing:true ];
       sender.title=@"Done";
    }else{
        self.editBtnPress=false;
       [self.tableView setEditing:false];
       sender.title=@"Edit";
    }
    
}

#pragma mark UItableView Delegates

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text=[NSString stringWithFormat:@"%@", [self.dataArray objectAtIndex:indexPath.row] ];
    cell.textLabel.highlightedTextColor = [UIColor greenColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *arrayItem=[self.dataArray objectAtIndex:sourceIndexPath.row];
    [self.dataArray removeObject:arrayItem];
    [self.dataArray insertObject:arrayItem atIndex:destinationIndexPath.row];
    
    [self.tableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end
