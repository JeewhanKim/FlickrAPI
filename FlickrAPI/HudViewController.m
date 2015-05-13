//
//  HudViewController.m
//  FlickrAPI
//
//  Created by MichaelKim on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "HudViewController.h"
#import "GlobalVars.h"

@interface HudViewController ()
{
    UIButton    *_aboutButton;
    UIButton    *_searchButton;
    UILabel     *_titleLabel;
    UITextField *_searchText;
}
@end

@implementation HudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalVars *glb = [GlobalVars getGlobal];
    
    self.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, 60);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _aboutButton    = [[UIButton alloc] init];
    _searchButton   = [[UIButton alloc] init];
    _titleLabel     = [[UILabel alloc] init];
    
    _aboutButton.frame = CGRectMake(2, 27, 60, 20);
    _aboutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _aboutButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_aboutButton setTitleColor:FONT_COLOR_B forState:UIControlStateNormal];
    [_aboutButton setTitle:@"ABOUT" forState:UIControlStateNormal];
    _aboutButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureAbout = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutTap)];
    [_aboutButton addGestureRecognizer:tapGestureAbout];
    
    _searchButton.frame = CGRectMake(DEVICE_WIDTH - 70, 27, 70, 20);
    _searchButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _searchButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_searchButton setTitleColor:FONT_COLOR_B forState:UIControlStateNormal];
    [_searchButton setTitle:@"SEARCH" forState:UIControlStateNormal];
    _searchButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureSearch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTap)];
    [_searchButton addGestureRecognizer:tapGestureSearch];
    
    _titleLabel.frame = CGRectMake(30, 27, DEVICE_WIDTH-60, 20);
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = glb->searchKeywords;
    
    _searchText = [[UITextField alloc] init];
    _searchText.frame = CGRectMake(DEVICE_WIDTH, 27, DEVICE_WIDTH, 20);
    _searchText.borderStyle = UITextBorderStyleNone;
    _searchText.backgroundColor = [UIColor whiteColor];
    _searchText.font = [UIFont fontWithName:@"HelveticaNeue" size:IS_IPAD ? 20 : 18];
    _searchText.textColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1];
    _searchText.textAlignment = NSTextAlignmentCenter;
    _searchText.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchText.delegate = self;

    [self.view addSubview:_aboutButton];
    [self.view addSubview:_searchButton];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_searchText];
}

- (void)aboutTap
{
    GlobalVars *glb = [GlobalVars getGlobal];
    if(glb->pageLevel != PAGE_LEVEL_HOME) {
        return;
    }
    
    glb->pageLevel = PAGE_LEVEL_ABOUT;
    [glb->rootView aboutActive];
}

- (void)searchTap
{
    GlobalVars *glb = [GlobalVars getGlobal];
    if(glb->pageLevel != PAGE_LEVEL_HOME) {
        [_searchText resignFirstResponder];
        return;
    }
    
    [UIView
     animateWithDuration:0.25
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         _searchText.frame = CGRectMake(0, 27, DEVICE_WIDTH, 20);
     } completion:^(BOOL finished)
     {
         [_searchText becomeFirstResponder];
     }];
    
    glb->pageLevel = PAGE_LEVEL_SEARCH;
    [glb->rootView searchActive];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)resignKeyboard
{
    GlobalVars *glb = [GlobalVars getGlobal];
    glb->searchKeywords = _searchText.text;
    [_searchText resignFirstResponder];
    [self hideSearchArea];
}

- (void)hideSearchArea
{
    [UIView
     animateWithDuration:0.25
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         _searchText.frame = CGRectMake(DEVICE_WIDTH, 27, DEVICE_WIDTH, 20);
     } completion:^(BOOL finished)
     {
         
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    GlobalVars *glb = [GlobalVars getGlobal];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:charSet];
    
    if(textField.text.length >= 1 && ![trimmedString isEqualToString:@""]) {
        _titleLabel.text = textField.text;
        glb->searchKeywords = textField.text;
        [glb->rootView searchByKeyword];
    }
    
    [glb->rootView searchInactive];
    [textField resignFirstResponder];
    [self hideSearchArea];
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length >= 16 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

- (void)searchInactive
{
    GlobalVars *glb = [GlobalVars getGlobal];
    _searchText.text = @"";
    glb->searchKeywords = _searchText.text;
    
    [_searchText resignFirstResponder];
    [self hideSearchArea];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
