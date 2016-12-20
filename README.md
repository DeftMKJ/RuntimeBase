## Runtime基础API以及一些简单的用法
### 基础用法之属性，方法，成员变量，protocol的获取
```objective-c
  - (IBAction)showAll:(id)sender {
    // 获取成员变量信息
    unsigned count = 0;
    Ivar *ivarLists = class_copyIvarList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i ++)
    {
        const char *name = ivar_getName(ivarLists[i]);
        NSString *str = [NSString stringWithUTF8String:name];
        NSLog(@"111%@",str);
    }
    
    // 获取属性
    objc_property_t *property = class_copyPropertyList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i++)
    {
        const char *name = property_getName(property[i]);
        NSString *str  = [NSString stringWithUTF8String:name];
        NSLog(@"222%@",str);
    }
    
    // 获取方法
    Method *methods = class_copyMethodList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i++) {
        Method method = methods[i];
        NSLog(@"333%@",NSStringFromSelector(method_getName(method)));
    }
    
    // 获取协议
    __unsafe_unretained Protocol **protocol = class_copyProtocolList([self class], &count);
    for (NSInteger i = 0; i < count; i ++) {
        Protocol *pro = protocol[i];
        const char *nameP = protocol_getName(pro);
        NSLog(@"444%@",[NSString stringWithUTF8String:nameP]);
    }
```
### 基础用法之动态关联属性
```objective-c
  - (NSString *)name
{
    return objc_getAssociatedObject(self, identify);
}

- (void)setName:(NSString *)name
{
    
    objc_setAssociatedObject(self, identify, @"jiaojiao", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray *)properties {
    // 如果已经关联了，就依据key取出被关联的对象并返回
    NSArray *pList = objc_getAssociatedObject(self, propertiesKey);
    if (pList != nil) {
        return pList;
    }
    // 如果没有关联，则设置关联对象，并将对象返回
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned int i = 0; i < count; ++i) {
        Ivar pty = ivars[i];
        const char *cname = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:cname];
        NSString *key = [name substringFromIndex:1];
        [arrayM addObject:key];
    }
    free(ivars);
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return arrayM.copy;
}
```
### 你用runtime做过什么？配合kvc把数据映射到模型上面去
```objective-c
  + (instancetype)configModelWithDict:(NSDictionary *)jsonDict replaceDict:(NSDictionary *)replaceDict
{
    id obj = [[self alloc] init];
    unsigned int count = 0;
    // 获取变量列表
    Ivar *ivarLists = class_copyIvarList(self, &count);
    // 遍历逐个进行使用
    for (NSInteger i = 0; i < count; i ++)
    {
        // 获取变量对象
        Ivar ivar = ivarLists[i];
        const char *name = ivar_getName(ivar);
        const char *coding = ivar_getTypeEncoding(ivar); // 判断类型
        // 获取自己写的属性变量字符串 _name
        NSString *nameStr = [[NSString stringWithUTF8String:name] substringFromIndex:1];
        NSString *codingstr = [NSString stringWithUTF8String:coding];
        // 根据字符串在原生字典取值
        id value = jsonDict[nameStr];
        // 如果未取到值  说明字段已经修改了
        if (!value) {
            if (replaceDict) {
                // 然后把修改之前的原生字段拿出来进行取值
                NSString *originValue = replaceDict[nameStr];
                // 再赋值
                value = jsonDict[originValue];
            }
        }
        // 避免属性数量大于数据数量的时候，如果多出来的属性是对象类型的那正好是null,无影响，如果多出来的属性是普通类型的，那会把nil赋值过去，直接崩溃
        if ([codingstr isEqualToString:@"f"] || [codingstr isEqualToString:@"d"]) {
            value = @(0.0);
        }
        // kvc进行模型组装 这里的value类型和property里面给的属性效果是一致的，如果属性是BOOL，你强行给字符串，实际类型还是BOOL
        [obj setValue:value forKey:nameStr];
    }
    return obj;
}
```
