Some useful categories for Cocoa classes and other small utils classes, that can be used in every project.

## Dependecies


Project uses ARC.

Project uses other libraries:

* ASIHttpRequest
* Nimbus
* Reachability

All of them are loading with CocoaPods.

## Using with CocoaPods


pod 'P34Utils', :git => 'https://github.com/pilot34/P34Utils.git'

**<font color="darkred">This is not full documentation, it is only examples. All of methods you can find in header files.</font>**

## Categories


### UIView

Useful methods for coordinate access.

```objective-c
    UIView *view = [[UIView alloc] init];
    view.top = 10;
    view.left = 20;
    view.height = otherView.height + 10;
    view.origin = CGPointMake(20, 30);
    view.bottom = 30; // change top without changing height
    [view setBottom:30 changeHeight:YES]; // change height, withouth changing top
```

### NSArray

Some sort of functional methods implementation (methods are not lazy):

```objective-c
    NSArray *arr = [@"a", @"aa", @"ab", @"abb"];

    NSArray *filtered = [arr where:^(id element){
        return [element length] > 1;
    }];

    NSArray *select = [arr select^(id element){
       return [NSString stringWithFormat:@"123%@123", element]; 
    }];
```
### Loading from nib

```objective-c
    // loading view from MyView.xib
    MyView *view = [MyView fromNib]; 

    // loading controller from CustomViewController.xib
    CustomViewController *c = [CustomViewController fromNib]; 

    // loading reusable cell with identifier "CustomCell" or, if nil, cell from CustomCell.xib
    CustomCell *cell = [self.tableView cellFromNib:CustomCell.class];
```


### Reachability

```objective-c

    // static checks without stupid API
    if ([Reachability isWiFiReachable])
    {
        ...
    }

    if ([Reachability isInternetReachable])
    {
        ...
    }
```


### Fading transparency

Useful for fading scroll view. You should add UIScrollView to container UIView and add fading to container.

Warning! Fading don't layout correctly, so you should do addFading each time after resizing.

```objective-c
    UIView *container = ...;
    [container addFading:(FadingTypeTop | FadingTypeBottom) withSize:20];
```

## Inheritors

There are many inheritors for classes from UIKit. Some examples.

### BlockAlertView

```objective-c
    [BlockAlertView showTitle:nil
                         text:@"Message"
                 cancelButton:@"OK"
                       action:^{
                           // some action after user pressed OK
    }];

    [BlockAlertView showTitle:nil
                         text:@"Download this file?"
                 cancelButton:@"No"
                 submitButton:@"Yes"
                       action:^{
                           // some action if user pressed YES
    }];
```

### BlockTapGestureRecognizer

```objective-c
    BlockTapGestureRecognizer *tap = [[BlockTapGestureRecognizer alloc] initWithAction:^{
        [self dismissModalViewControllerAnimated:YES];
    }];
    [self.view addGestureRecognizer:tap];

    // or you can do it simplier
    [self.view addTapAction:^{
        // do something
    }];
```


## Other utils classes

### VideoPlayingResolver

If you have UIWebView with html, after device rotation you should reload html for correct relayouting. If you have embedded video in HTML and layout during playing video, it will be stopped. So you shouldn't reload html during fullscreen video playing.

This class subscribing to needed notifications and you can check, reload html or not.

```objective-c

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.playingResolver = [[VideoPlayingResolver alloc] init];
        self.playingResolver.delegate = self;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if (!self.playingResolver.isPlaying)
        [self reloadHTML];
}

#pragma mark - VideoPlayingResolverDelegate

- (void)videoPlayingResolverDidFinishPlaying:(BOOL)wasRotation
{
    if (wasRotation)
        [self reloadHTML];
}

```


## Macros and functions

```objective-c
doAfter(1, ^{
   // do something on this thread after 1 second with GCD
});


// doing this: weak wself = self
// using to avoid retain cycles
WSELF; 
[self addTapAction:{
   [wself doSomething]; 
}];

```


