#import "P34Utils.h"

void doAfter(CGFloat delay, BasicBlock action)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), action);
}

void doSyncOnMain(BasicBlock action)
{
    if ([NSThread isMainThread])
        action();
    else
        dispatch_sync(dispatch_get_main_queue(), action);
}

BOOL isIphone5OrLarger()
{
    static NSInteger isIphone5 = -1;
    if (isIphone5 < 0)
    {
        doSyncOnMain(^{
            if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"7.0"))
            {
                isIphone5 = [[UIScreen mainScreen] bounds].size.height >= 568;
            }
            else
            {
                isIphone5 = ((!UIApplication.landscape && [[UIScreen mainScreen] bounds].size.height >= 568)
                             || (UIApplication.landscape && [[UIScreen mainScreen] bounds].size.width >= 568));
            }
        });
    }
    
    return isIphone5 > 0;
}

BOOL isIphone5()
{
    static NSInteger isIphone5 = -1;
    if (isIphone5 < 0)
    {
        doSyncOnMain(^{
            if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"7.0"))
            {
                isIphone5 = [[UIScreen mainScreen] bounds].size.height == 568;
            }
            else
            {
                isIphone5 = ((!UIApplication.landscape && [[UIScreen mainScreen] bounds].size.height == 568)
                             || (UIApplication.landscape && [[UIScreen mainScreen] bounds].size.width == 568));
            }
        });
    }
    
    return isIphone5 > 0;
}

BOOL isIphone6()
{
    static NSInteger isIphone6 = -1;
    if (isIphone6 < 0)
    {
        doSyncOnMain(^{
            isIphone6 = ((!UIApplication.landscape && [[UIScreen mainScreen] bounds].size.height == 667)
                         || (UIApplication.landscape && [[UIScreen mainScreen] bounds].size.width == 667));
        });
    }
    return isIphone6 > 0;
}

BOOL isIphone6Plus()
{
    static NSInteger isIphone6Plus = -1;
    if (isIphone6Plus < 0)
    {
        doSyncOnMain(^{
            isIphone6Plus = ((!UIApplication.landscape && [[UIScreen mainScreen] bounds].size.height == 736)
                             || (UIApplication.landscape && [[UIScreen mainScreen] bounds].size.width == 736));
        });
    }
    
    return isIphone6Plus > 0;
}

BOOL isIpad()
{
    static NSInteger isiPad = -1;
    if (isiPad < 0)
    {
        doSyncOnMain(^{
            isiPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
        });
    }
    return isiPad > 0;
}

BOOL isRetina()
{
    static NSInteger isRetina = -1;
    if (isRetina < 0)
    {   doSyncOnMain(^{
        isRetina = UIScreen.mainScreen.scale > 1;
    });
    }
    
    return isRetina > 0;
}