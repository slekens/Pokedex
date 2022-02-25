//
//  CoreDataManager.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/02/22.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property(nonatomic, copy)NSString *modelName;
@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong)NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

-(NSManagedObjectContext*)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent: [NSString stringWithFormat: @"%@.sqlite", kDatabaseName]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return _persistentStoreCoordinator;
}

-(NSManagedObjectModel*)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource: kDatabaseName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

-(NSURL*)applicationDocumentsDirectory {
    NSURL *documentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory  inDomains: NSUserDomainMask]lastObject];
    return [documentsDirectoryURL URLByAppendingPathComponent: kDatabaseName];
}

-(void)saveContext {
    NSError *error = nil;
    if ([_managedObjectContext save: &error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    NSLog(@"Saved Successfully");
}

-(void)createNewEntryWith:(PokemonDisplay*)pokemon {
    NSManagedObject *model;
    model = [NSEntityDescription insertNewObjectForEntityForName: @"Pokemon" inManagedObjectContext: _managedObjectContext];
    NSNumber *pokemonNumber = [NSNumber numberWithInteger: pokemon.pokemonNumber];
    [model setValue: pokemon.pokemonName forKey: @"name"];
    [model setValue: pokemonNumber forKey: @"pokemonId"];
    [model setValue: pokemon.pokemonImage forKey: @"pokemonURL"];
    
    [self saveContext];
}

//-(instancetype)initWith:(NSString*)modelName {
//    self = [super init];
//    self.modelName = modelName;
//    NSURL *modelURL = [[NSBundle mainBundle]URLForResource: self.modelName withExtension: @"momd"];
//    self.managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL: modelURL];
//    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel: self.managedObjectModel];
//
//    NSString *storeName = [NSString stringWithFormat: @"%@.sqlite", self.modelName];
//
//    NSURL *documentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory  inDomains: NSUserDomainMask]lastObject];
//    NSURL *persistentStoreURL = [documentsDirectoryURL URLByAppendingPathComponent: storeName];
//
//
//    self.managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType: NSMainQueueConcurrencyType];
//    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
//
//    NSError *error = nil;
//    [self.persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
//                                                  configuration: nil
//                                                            URL:persistentStoreURL
//                                                        options: nil
//                                                          error: &error];
//    if (error) {
//        NSLog(@"Unable to load persistance store");
//    }
//    return self;
//}

@end
