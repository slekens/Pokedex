//
//  CoreDataManager.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/02/22.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataManager

-(instancetype)init {
    self = [super init];
    [self setUpCoreDataStack];
    return self;
}

-(void)setUpCoreDataStack {
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Pokedex.sqlite"];
    
    NSDictionary *options = @{NSPersistentStoreFileProtectionKey: NSFileProtectionComplete,
                              NSMigratePersistentStoresAutomaticallyOption:@YES};
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
    if (!store) {
        NSLog(@"Error adding persistent store. Error %@",error);
        NSError *deleteError = nil;
        if ([[NSFileManager defaultManager] removeItemAtURL:url error:&deleteError]) {
            error = nil;
            store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
        }
        if (!store) {
            NSLog(@"Failed to create persistent store. Error %@. Delete error %@",error,deleteError);
            abort();
        }
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = psc;
}
-(void)saveContext:(SaveHandler)completionHandler {
    NSError *error = nil;
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
        completionHandler(NO, error);
        return;
    }
    completionHandler(YES, nil);
}

-(void)saveNewPokemon:(PokemonDisplay*)pokemon andHandler:(nonnull SaveHandler)completionHandler {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: kDatabasePokemonListModel];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"pokemonId == %ld", pokemon.pokemonNumber];
    [request setPredicate: predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest: request error: &error];

    if ([results count] == 0) {
        [self createNewEntryWith: pokemon andHandler:^(BOOL isSuccess, NSError * _Nullable error) {
            completionHandler(isSuccess, error);
        }];
        return;
    }
    if (error != nil) {
        NSLog(@"Error already exists %@", error.localizedDescription);
        completionHandler(NO, error);
        return;
    }
}

-(void)fetchResults:(PokemonListHandler)completionHandler  {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: kDatabasePokemonListModel];
     
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching pokemon objects: %@\n%@", [error localizedDescription], [error userInfo]);
        completionHandler(nil, error);
        return;
    }
    NSMutableArray<PokemonDisplay*>* list = [[NSMutableArray alloc]init];
    for (PokemonMO *result in results) {
        [list addObject: [[PokemonDisplay alloc]initWithModel: result]];
    }
    completionHandler(list, nil);
}

-(void)deleteAllPokemons {
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName: kDatabasePokemonListModel inManagedObjectContext: self.managedObjectContext]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [self.managedObjectContext executeFetchRequest: allRecords error: &error];
    for (NSManagedObject *pokemon in result) {
        [self.managedObjectContext deleteObject: pokemon];
    }
    [self saveContext:^(BOOL isSuccess, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error deleting data! %@", error.localizedDescription);
        }
    }];
}

-(void)createNewEntryWith:(PokemonDisplay*)pokemon andHandler:(SaveHandler)completionHandler {
    PokemonMO *model = [NSEntityDescription insertNewObjectForEntityForName: kDatabasePokemonListModel inManagedObjectContext: self.managedObjectContext];
    if (model != nil) {
        model.name = pokemon.pokemonName;
        model.pokemonId = pokemon.pokemonNumber;
        model.pokemonURL = pokemon.pokemonImage;
        [self saveContext:^(BOOL isSuccess, NSError * _Nullable error) {
            completionHandler(isSuccess, error);
        }];
    } else {
        NSString *description = NSLocalizedString(@"ErrorNewEntry", @"");
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : description };
        completionHandler(NO, [[NSError alloc]initWithDomain: @"" code: 500 userInfo: userInfo]);
    }
}

@end
