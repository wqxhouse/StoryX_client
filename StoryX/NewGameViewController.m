//
//  NewGameViewController.m
//  StoryX
//
//  Created by Max Xing on 10/28/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "NewGameViewController.h"
#import "UrlPath.h"
#import "DAO.h"

@interface NewGameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NewGameViewController
- (IBAction)sendButton:(id)sender {

    [DAO getRequest:[UrlPath sendString: self.textField.text] callback:^(NSDictionary *dc, NSError *error) {

        if(error == nil){
            NSLog(@"no error");
          //  dc[@"send"] = self.textField.text;
        }

        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"send failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }



    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
