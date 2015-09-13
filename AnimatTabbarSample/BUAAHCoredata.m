//
//  BUAAHCore_data.m
//  config
//
//  Created by !n on 15/7/21.
//  Copyright (c) 2015年 !n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAAHCoredata.h"
#import "ManagedObjectSubClass.h"

static NSPersistentStoreCoordinator *psc = nil;

static NSManagedObjectContext *context=nil;

@interface BUAAHCoredata()

@end

@implementation BUAAHCoredata


+(void)initializeCoredata{
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *tpsc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"model.data"]];
    
    
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [tpsc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }

    psc=  tpsc;
}

+(void)insert:(NSString*)managedObjectName forData:(NSDictionary*)data{
    
    if(context==nil){
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = psc;
    }
    
    
    // 传入上下文，创建一个Person实体对象
    ManagedObjectSubClass *object = [NSEntityDescription insertNewObjectForEntityForName:managedObjectName inManagedObjectContext:context];
    // 设置Person的简单属性
    
    
    if([object insert:data]){
        NSArray* keys = [data allKeys];
        for(NSString* key in keys){
            [object setValue:[data valueForKey:key] forKey:key];
        }
        NSError *error = nil;
        BOOL success = [context save:&error];
        if (!success) {
            [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        }
    }
    else{
        NSLog(@"插入失败");
    }

}


+(NSArray*)query:(NSString*)managedObjectName forSort:(NSSortDescriptor*)sort forPredicate:(NSPredicate*)predicate{
    if(context==nil){
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = psc;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:managedObjectName inManagedObjectContext:context];
    // 设置排序（按照age降序）
    //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    if(sort!=nil)
        request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*MJ*"];
    if(predicate!=nil){
        request.predicate = predicate;
    }
    
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
        return nil;
    }
    // 遍历数据
    return objs;

    
}

+(void)delete:(NSManagedObject*)object{
    
    if(context==nil){
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = psc;
    }
    [context deleteObject:object];
    NSError *error = nil;
    [context save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }

}



+(void)clear:(NSString*)managedObjectName {
    if(context==nil){
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator=psc;
    }
    NSArray* arr =[BUAAHCoredata query:managedObjectName forSort:nil forPredicate:nil];
    for(NSManagedObject* object in arr){
        [BUAAHCoredata delete:object];
    }
}


//可能不用这个函数
+(NSManagedObject*)getNSManagedObject:(NSString*)managedObjectName{
    if(context==nil){
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = psc;
    }
    
    
    // 传入上下文，创建一个Person实体对象
    ManagedObjectSubClass *object = [NSEntityDescription insertNewObjectForEntityForName:managedObjectName inManagedObjectContext:context];
    return object;
}

@end