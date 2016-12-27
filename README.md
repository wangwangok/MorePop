# MorePop
# 目的

在一个控制器中难免会代码会导致Controller不走delloc方法，但是我们很多操作又需要在delloc中去做，比如：observer的移除，某些变量设置为nil之类的<br>
特别是在我当前这个项目中，因为我是中途加进来的，这个项目里面太多的observer了，导致很多界面的监听已经很混乱（因为操作不当控制器不走delloc，代码太多真不知道从哪里开始排查），这就是很头疼的事情。<br>
不走delloc这些操作我们放在哪里呢？所以我就做了一点小小的工作来解决这个困惑。

# 用法

> A控制器 Push到 B控制器

在B中的viewdidload方法中，添加如下代码即可:
<pre>
self.enableCapturePopCompletion = YES;
self.cdf_PopGestureCompletion = ^(BOOL animated){
  //在这里做你想要做的事情，比如removeobserver
};
</pre>

> A控制器 Present到 B控制器

在B中的viewdidload方法中，添加如下代码即可:
<pre>
self.enableCapturePopCompletion = YES;
self.cdf_PopGestureCompletion = ^(BOOL animated){
  //在这里做你想要做的事情，比如removeobserver
};
</pre>

# 注意
如果你的项目中能正常的走dealloc方法的话，就直接把`self.enableCapturePopCompletion = NO`就可以了。
