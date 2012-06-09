void doAfter(CGFloat delay, BasicBlock action)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_current_queue(), action);
}