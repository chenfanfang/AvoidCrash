[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/chenfanfang/AvoidCrash) [![pod](https://img.shields.io/badge/pod-2.5.1-yellow.svg)](https://github.com/chenfanfang/AvoidCrash) [![platform](https://img.shields.io/badge/platform-iOS-ff69b4.svg)](https://github.com/chenfanfang/AvoidCrash) [![aboutme](https://img.shields.io/badge/about%20me-chenfanfang-blue.svg)](http://www.jianshu.com/users/80fadb71940d/latest_articles)

疑惑解答
===
很多开发小伙伴经常私信问我一些问题:
> 1、若集成了腾讯Bugly或者友盟等等异常搜集的SDK,AvoidCrash会影响到它们的异常搜集吗？


> 2、为什么集成了AvoidCrash还是会报unrecognized selector sent to instance的异常？

关于疑惑的解答，请点击[AvoidCrash疑惑解答](http://www.jianshu.com/p/2b90aa96c0a0)


前言
===
一个已经发布到AppStore上的App，最忌讳的就是崩溃问题。为什么在开发阶段或者测试阶段都不会崩溃，而发布到AppStore上就崩溃了呢？究其根源，最主要的原因就是数据的错乱。特别是 服务器返回数据的错乱，将严重影响到我们的App。



---
Foundation框架存在许多潜在崩溃的危险
===
- 将 nil 插入可变数组中会导致崩溃。
- 数组越界会导致崩溃。
- 根据key给字典某个元素重新赋值时，若key为 nil 会导致崩溃。
- ......

---

AvoidCrash简介
===
- 这个框架利用runtime技术对一些常用并且容易导致崩溃的方法进行处理，可以有效的防止崩溃。
- 并且打印出具体是哪个方法会导致崩溃，让你快速定位导致崩溃的代码。
- 你可以获取到原本导致崩溃的主要信息<由于这个框架的存在，并不会崩溃>，进行相应的处理。比如：
  - 你可以将这些崩溃信息发送到自己服务器。
  - 你若集成了第三方崩溃日志收集的SDK,比如你用了腾讯的Bugly,你可以上报自定义异常。
- 或许你会问就算防止了崩溃，但是所获取到的数据变成nil或者并非是你所需要的数据，这又有什么用？对于防止崩溃，我的理解是，宁愿一个功能不能用，都要让app活着，至少其他功能还能用。

---
下面先来看下防止崩溃的效果吧
===

`可导致崩溃的代码`
```
    NSString *nilStr = nil;
    NSArray *array = @[@"chenfanfang", nilStr];
```

- 若没有AvoidCrash来防止崩溃，则会直接崩溃，如下图

![崩溃截图.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/66b631627443490776f964d5f6cdc0d9215d7b09/AvoidCrashDemo/Screenshot/%E5%B4%A9%E6%BA%83%E6%88%AA%E5%9B%BE.png)


- 若有AvoidCrash来防止崩溃，则不会崩溃，并且会将原本会崩溃情况的详细信息打印出来，如下图

![防止崩溃输出日志.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/66b631627443490776f964d5f6cdc0d9215d7b09/AvoidCrashDemo/Screenshot/%E9%98%B2%E6%AD%A2%E5%B4%A9%E6%BA%83%E7%9A%84%E8%BE%93%E5%87%BA%E6%97%A5%E5%BF%97.png)


---

## Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod 'AvoidCrash', '~> 2.5.1'
```

### Manually【手动导入】
- Drag all source files under floder `AvoidCrash` to your project.【将`AvoidCrash`文件夹中的所有源代码拽入项目中】
- 对 NSMutableArray+AvoidCrash.m 文件进行 -fno-objc-arc 设置(若使用CocoaPods集成则无需手动配置)，配置过程如下图：


![](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/e955af927c5ed57f783a71eaca19cb3f028377d0/AvoidCrashDemo/Screenshot/%E9%85%8D%E7%BD%AEmutableArray.png)



---


使用方法
===



- AvoidCrash使用注意点讲解
```
       //让AvoidCrash生效方法有两个becomeEffective和makeAllEffective，若都不调用，则AvoidCrash就不起作用
       [AvoidCrash becomeEffective]; //【默认不开启  对”unrecognized selector sent to instance”防止崩溃的处理】
       
       //若要开启对对”unrecognized selector sent to instance”防止崩溃的处理】，请使用
       //[AvoidCrash makeAllEffective],使用注意点，请看AvoidCrash.h中的描述，必须配合[AvoidCrash setupNoneSelClassStringsArr:]的使用
       //【建议在didFinishLaunchingWithOptions最初始位置调用】[AvoidCrash makeAllEffective]
       
     /*
      [AvoidCrash becomeEffective]和[AvoidCrash makeAllEffective]是全局生效。若你只需要部分生效，你可以单个进行处理，比如:
      [NSArray avoidCrashExchangeMethod];
      [NSMutableArray avoidCrashExchangeMethod];
      .................
      .................
      */
```

- 在AppDelegate的didFinishLaunchingWithOptions方法中的最初始位置添加如下代码，让AvoidCrash生效


```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //启动防止崩溃功能(注意区分becomeEffective和makeAllEffective的区别)
    //具体区别请看 AvoidCrash.h中的描述
    //建议在didFinishLaunchingWithOptions最初始位置调用 上面的方法
    
    [AvoidCrash makeAllEffective];
    
    //若出现unrecognized selector sent to instance导致的崩溃并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    NSArray *noneSelClassStrings = @[
                                     @"NSString"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    return YES;
}
```

- 若你想要获取崩溃日志的所有详细信息，只需添加通知的监听，监听的通知名为:AvoidCrashNotification

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AvoidCrash becomeEffective];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    return YES;
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}
```

- 下面通过打断点的形式来看下userInfo中的信息结构，看下包含了哪些信息

![userInfo信息结构.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/66b631627443490776f964d5f6cdc0d9215d7b09/AvoidCrashDemo/Screenshot/userInfo%E4%BF%A1%E6%81%AF%E7%BB%93%E6%9E%84.png)

- 再看下控制台输出日志来看下userInfo中的包含了哪些信息

![userInfo详细信息](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/556cab1b9fa25c8265dd1e8a19c816db20e93c24/AvoidCrashDemo/Screenshot/userInfo%E8%AF%A6%E7%BB%86%E4%BF%A1%E6%81%AF.png)



---

目前可以防止崩溃的方法有
===
---


- unrecognized selector sent to instance
   -  `1. 对”unrecognized selector sent to instance”防止崩溃的处理`

---

 - NSArray
   -  `1. NSArray的快速创建方式 NSArray *array = @[@"chenfanfang", @"AvoidCrash"];  //这种创建方式其实调用的是2中的方法`
   -  `2. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt`
   
   - `3. 通过下标获取元素 array[100]、[array objectAtIndex:100]`
     - `- (id)objectAtIndex:(NSUInteger)index`
     
   - `4. - (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes`
   - `5. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range`
  
---

- NSMutableArray 
  - `1. 通过下标获取元素 array[100]、[array objectAtIndex:100] `
      - `- (id)objectAtIndex:(NSUInteger)index`
  - `2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx`
  - `3. - (void)removeObjectAtIndex:(NSUInteger)index`
  - `4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index`
  - `5. - (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes`
  - `6. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range`
  
---

- NSDictionary
  - `1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"AvoidCrash"}; //这种创建方式其实调用的是2中的方法`
  - `2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt`

---


- NSMutableDictionary
  - `1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey`
  - `2. - (void)removeObjectForKey:(id)aKey`
  
  
  
---


- NSString
	- `1. - (unichar)characterAtIndex:(NSUInteger)index`
	- `2. - (NSString *)substringFromIndex:(NSUInteger)from`
	- `3. - (NSString *)substringToIndex:(NSUInteger)to {`
	- `4. - (NSString *)substringWithRange:(NSRange)range {`
	- `5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement`
	- `6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange`
	- `7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement`

---


- NSMutableString
	- `1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了`
	- `2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString`
	- `3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc`
	- `4. - (void)deleteCharactersInRange:(NSRange)range`

  
---


- KVC
  -  `1.- (void)setValue:(id)value forKey:(NSString *)key`
  -  `2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath`
  -  `3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用`
  -  `4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues`

---

- NSAttributedString
  -  `1.- (instancetype)initWithString:(NSString *)str`
  -  `2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr`
  -  `3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs`

---


- NSMutableAttributedString
  -  `1.- (instancetype)initWithString:(NSString *)str`
  -  `2.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs`


更新
===
#### 2017-12-26 (pod 2.5.1)
- 	兼容iOS11的处理

#### 2017-08-11
- 	优化对”unrecognized selector sent to instance”防止崩溃的处理

#### 2017-07-25
- 	优化对”unrecognized selector sent to instance”防止崩溃的处理


#### 2017-07-23
- 	增加对”unrecognized selector sent to instance”防止崩溃的处理

---

#### 2016-12-19
- Release环境下取消控制台的输出。


---

#### 2016-12-1
- 处理数组的类簇问题，提高兼容性，不论是由于array[100]方式，还是[array objectAtIndex:100]方式 获取数组中的某个元素操作不当而导致的crash,都能被拦截防止崩溃。
 - 上一个版本只能防止array[100]导致的崩溃，不能防止[array objectAtIndex:100]导致的崩溃。

- 统一对线程进行处理，监听通知AvoidCrashNotification后，不论是在主线程导致的crash还是在子线程导致的crash，监听通知的方法统一在"主线程"中。
 - 上一个版本中，在哪个线程导致的crash, 则监听通知的方法就在哪个线程中。

- 新增防止崩溃 （NSArray、NSMutableArray） `- (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range`


---

#### 2016-11-29
- 修复在键盘弹出状态下，按Home键进入后台会导致崩溃的bug。
- 新增防止崩溃（NSArray、NSMutableArray） `- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes`

---



#### 2016-10-15
- 修复上一个版本部分方法不能拦截崩溃的BUG，具体修复哪些可以查看issues和简书上的留言。
- 优化崩溃代码的定位，定位崩溃代码更加准确。
- 增加对KVC赋值防止崩溃的处理。
- 增加对NSAttributedString防止崩溃的处理
- 增加对NSMutableAttributedString防止崩溃的处理

---



提示
===
- 1、由于@try @catch的原因，如果防止了你项目中将要crash的代码，有些方法将导致些许的内存泄漏。若你的代码不会导致crash，当然就不存在内存泄漏的问题,crash和些许内存泄漏的选择当然取决于你自己。目前发现的内存泄漏的方法如下图所示，没有显示在下图中的方法，不论是否会导致crash，都不会有内存泄漏。
  
  ![](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/fdad9c8808559c0b20c8672b2cb6e901d4e4f006/AvoidCrashDemo/Screenshot/Leaks.png)
  
- 2、有朋友提出，AvoidCraah和[RegexKitLite](https://github.com/wezm/RegexKitLite)有冲突，毕竟代码不在同一个时代上的（RegexKitLite最后一次提交时在2011年）。同时也说明AvoidCrash的健壮性不够，大家若有什么意见可以提出。

期待
===
* 如果你发现了哪些常用的Foundation中的方法存在潜在崩溃的危险，而这个框架中没有进行处理，希望你能 issue, 或者在简书私信我,我将这些方法也添加到AvoidCrash中。谢谢
* 如果你在使用过程中遇到BUG，希望你能 issue, 或者在简书私信我。谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 毕竟一个人的能力有限，时间有限，希望有能力的你可以加入到这个项目中来，一起完善AvoidCrash。请Pull Requests我。




[About me -- 简书](http://www.jianshu.com/users/80fadb71940d/latest_articles)
===












