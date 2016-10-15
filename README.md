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
- 并且打印出具体是哪一行代码会导致崩溃，让你快速定位导致崩溃的代码。
- 你可以获取到原本导致崩溃的主要信息<由于这个框架的存在，并不会崩溃>，进行相应的处理。比如：
  - 你可以将这些崩溃信息发送到自己服务器。
  - 你若集成了第三方崩溃日志收集的SDK,比如你用了腾讯的Bugly,你可以上报自定义异常。


---
下面先来看下防止崩溃的效果吧
===

`可导致崩溃的代码`
```
    NSString *nilStr = nil;
    NSArray *array = @[@"chenfanfang", nilStr];
```

- 若没有AvoidCrash来防止崩溃，则会直接崩溃，如下图

![崩溃截图.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/556cab1b9fa25c8265dd1e8a19c816db20e93c24/AvoidCrashDemo/Screenshot/%E5%B4%A9%E6%BA%83%E6%88%AA%E5%9B%BE.png)


- 若有AvoidCrash来防止崩溃，则不会崩溃，并且会将原本会崩溃情况的详细信息打印出来，如下图

![防止崩溃输出日志.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/556cab1b9fa25c8265dd1e8a19c816db20e93c24/AvoidCrashDemo/Screenshot/%E9%98%B2%E6%AD%A2%E5%B4%A9%E6%BA%83%E7%9A%84%E8%BE%93%E5%87%BA%E6%97%A5%E5%BF%97.png)


---

## Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod  AvoidCrash
```

### Manually【手动导入】
- Drag all source files under floder `AvoidCrash` to your project.【将`AvoidCrash`文件夹中的所有源代码拽入项目中】


---
##使用方法

- 在AppDelegate的didFinishLaunchingWithOptions方法中添加如下代码，让AvoidCrash生效

```
//这句代码会让AvoidCrash生效，若没有如下代码，则AvoidCrash就不起作用
[AvoidCrash becomeEffective];
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

![userInfo信息结构.png](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/556cab1b9fa25c8265dd1e8a19c816db20e93c24/AvoidCrashDemo/Screenshot/userInfo%E4%BF%A1%E6%81%AF%E7%BB%93%E6%9E%84.png)

- 再看下控制台输出日志来看下userInfo中的包含了哪些信息

![userInfo详细信息](https://raw.githubusercontent.com/chenfanfang/AvoidCrash/556cab1b9fa25c8265dd1e8a19c816db20e93c24/AvoidCrashDemo/Screenshot/userInfo%E8%AF%A6%E7%BB%86%E4%BF%A1%E6%81%AF.png)



---

目前可以防止崩溃的方法有
===
---
 - NSArray
   -  `1. NSArray的快速创建方式 NSArray *array = @[@"chenfanfang", @"AvoidCrash"];  //这种创建方式其实调用的是2中的方法`
   -  `2. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt`
   
   - `3. - (id)objectAtIndex:(NSUInteger)index`
  
---

- NSMutableArray 
  - `1. - (id)objectAtIndex:(NSUInteger)index`
  - `2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx`
  - `3. - (void)removeObjectAtIndex:(NSUInteger)index`
  - `4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index`
  
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
 *  `1.- (instancetype)initWithString:(NSString *)str`
 *  `2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr`
 *  `3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs`

---
- NSMutableAttributedString
 *  `1.- (instancetype)initWithString:(NSString *)str`
 *  `2.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs`


更新
===
#### 2016-10-15
- 修复上一个版本部分方法不能拦截崩溃的BUG，具体修复哪些可以查看issues和简书上的留言。
- 优化崩溃代码的定位，定位崩溃代码更加准确。
- 增加对KVC赋值防止崩溃的处理。
- 增加对NSAttributedString防止崩溃的处理
- 增加对NSMutableAttributedString防止崩溃的处理




期待
===
* 如果你发现了哪些常用的Foundation中的方法存在潜在崩溃的危险，而这个框架中没有进行处理，希望你能 issue, 或者在简书私信我,我将这些方法也添加到AvoidCrash中。谢谢
* 如果你在使用过程中遇到BUG，希望你能 issue, 或者在简书私信我。谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 毕竟一个人的能力有限，时间有限，希望有能力的你可以加入到这个项目中来，一起完善AvoidCrash。请Pull Requests我。




##[About me -- 简书](http://www.jianshu.com/users/80fadb71940d/latest_articles)