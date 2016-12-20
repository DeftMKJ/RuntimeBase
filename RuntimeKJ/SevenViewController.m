//
//  SevenViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SevenViewController.h"
#import "Fish.h"

@interface SevenViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) Fish *fish;
@property (nonatomic,copy) NSString *fishName;
@property (nonatomic,copy) NSString *path;

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.path = [self.path stringByAppendingPathComponent:@"fish"];
    NSLog(@"%@",self.path);
    self.textField.delegate = self;
    self.fish = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    if (!self.fish) {
        self.fish = [[Fish alloc] init];
    }
    self.textField.text = self.fish.name;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.fishName = textField.text;
}

- (IBAction)click:(id)sender {
    [self.view endEditing:YES];
    self.fish.name = self.fishName;
    [NSKeyedArchiver archiveRootObject:self.fish toFile:self.path];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
