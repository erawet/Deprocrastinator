//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Don Wettasinghe on 1/12/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

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
    self.dataArray = [[NSMutableArray alloc]init];
    self.editBtnPress=false;
}


- (IBAction)onSwipeGestureColorChange:(UISwipeGestureRecognizer*)sender {

    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    Task *tt = [self.dataArray objectAtIndex:swipedIndexPath.row];
    
//    int curColor = tt.tapColour ;
//    if (curColor == 3) {
//        arrayTask.tapColour = 0;
//    } else {
//        tt.tapColour = arrayTask.tapColour + 1;
//    }
//    
//    [self updateCellColorWithTask:arrayTask andCell:swipedCell];
}

- (void)updateCellColorWithTask:(Task *)task andCell:(UITableViewCell *)cell {
    if (task.tapColour == 0) {
        cell.textLabel.textColor = [UIColor blackColor];
    } else if (task.tapColour == 1) {
        cell.textLabel.textColor = [UIColor redColor];
    } else if (task.tapColour == 2) {
        cell.textLabel.textColor = [UIColor orangeColor];
    } else {
        cell.textLabel.textColor = [UIColor greenColor];
    }
}


- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self.dataArray addObject:self.contentText.text];
    Task *task=[[Task alloc]init];
    task.tapColour=0;
    task.isComplete=NO;
    
    
    [self.tableView reloadData];
    self.contentText.text=@"";
    [self.view endEditing:YES];
    
}


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
//    cell.textLabel.text=[NSString stringWithFormat:@"%@", [self.dataArray objectAtIndex:indexPath.row] ];
    Task *tsk=[Task new];
    tsk.textString = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", tsk.textString];

    [self updateCellColorWithTask:tsk andCell:cell];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    Task *task=[Task new];
    task = [self.dataArray objectAtIndex:indexPath.row];
    
    NSLog(@"%i", task.isComplete);
    
    if (task.isComplete) {
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
   
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
