#import "P34Utils.h"

void doAfter(CGFloat delay, BasicBlock action)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_current_queue(), action);
}

BOOL isIphone5()
{
    static NSInteger isIphone5 = -1;
    if (isIphone5 < 0)
        isIphone5 = [[UIScreen mainScreen] bounds].size.height == 568;
    return isIphone5 > 0;
}

BOOL isIpad()
{
    static NSInteger isiPad = -1;
    if (isiPad < 0)
        isiPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    return isiPad > 0;
}

BOOL isRetina()
{
    static NSInteger isRetina = -1;
    if (isRetina < 0)
        isRetina = UIScreen.mainScreen.scale > 1;
    
    return isRetina > 0;
}