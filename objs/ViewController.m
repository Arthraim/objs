//
//  ViewController.m
//  objs
//
//  Created by Wang Xuyang on 3/19/13.
//  Copyright (c) 2013 Pingan. All rights reserved.
//

#import "ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface ViewController () {
    UILabel *label1;
    UITextField *text1;
    UILabel *label2;
    UITextField *text2;
    UIButton *btn;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor lightGrayColor];
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height / 2)];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [_webView loadHTMLString:htmlString baseURL:baseURL];
    [scrollView addSubview:_webView];
    [_webView release];
    
    ///////////////////////
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    label1.text = @"title";
    label1.backgroundColor = [UIColor clearColor];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame), 300, 30)];
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.placeholder = @"title";
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(text1.frame), 300, 20)];
    label2.text = @"message";
    label2.backgroundColor = [UIColor clearColor];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label2.frame), 300, 30)];
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"message";
    btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btn.frame = CGRectMake(10, CGRectGetMaxY(text2.frame)+10, 150, 37);
    [btn setTitle:@"Update HTML Form" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:view];
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:text1];
    [view addSubview:text2];
    [view addSubview:btn];
    
    [view release];
    [label1 release];
    [label2 release];
    [text1 release];
    [text2 release];
    [btn release];
}

- (void)btnClicked
{
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
                                                      @"$('#title').val('%@');\
                                                        $('#message').val('%@');",
                                                      text1.text, text2.text]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
