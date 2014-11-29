//
//  injector.m
//  injector
//
//  Created by David Sahakyan on 8/20/14.
//  Copyright (c) 2014 SocialObjects Software. All rights reserved.
//

#import "injector.h"

#import <objc/runtime.h>
#import <objc/message.h>
#import <dlfcn.h>
#import "fishhook.h"

@implementation injector

/**
 + (BOOL)checkSavedRegistration;	// IMP=0x000000010000634e
 + (int)registrationType;	// IMP=0x00000001000062af
 + (id)registrationOrderID;	// IMP=0x0000000100006205
 + (id)registrationCompany;	// IMP=0x000000010000614f
 + (id)registrationName;	// IMP=0x000000010000607b
 
 - (BOOL)checkSavedRegistration;	// IMP=0x00000001000062fa
 - (int)registrationType;	// IMP=0x000000010000625c
 - (id)registrationOrderID;	// IMP=0x00000001000061a6
 - (id)registrationCompany;	// IMP=0x00000001000060d2
 - (id)registrationName;	// IMP=0x0000000100005ffe
 - (id)registrationData;	// IMP=0x0000000100005fa0
 - (int)registrationType:(id)arg1;	// IMP=0x0000000100005e7a
 - (id)registrationOrderID:(id)arg1;	// IMP=0x0000000100005da8
 - (id)registrationCompany:(id)arg1;	// IMP=0x0000000100005cb4
 - (id)registrationName:(id)arg1;	// IMP=0x0000000100005bc0
 - (BOOL)checkRegistrationLicense:(id)arg1;	// IMP=0x0000000100005abd
 - (BOOL)checkRegistrationToken;	// IMP=0x000000010000599f
 - (int)getRegistrationTokenFromServer;	// IMP=0x0000000100005660
 */

+ (int)registrationType
{
    NSLog(@"registrationType called");
    return 1;
}

+ (BOOL)checkSavedRegistration
{
    NSLog(@"checkSavedRegistration called");
    return YES;
}

+ (id)registrationOrderID
{
    NSLog(@"registrationOrderID called");
    return @"12345";
}

+ (id)registrationCompany
{
    NSLog(@"registrationCompany called");
    return @"12345";
}

+ (id)registrationName
{
    NSLog(@"registrationName called");
    return @"12345";
}

- (BOOL)checkSavedRegistration
{
    NSLog(@"-checkSavedRegistration called");
    return YES;
}

////////////////////////////////
- (id)registrationOrderID
{
    NSLog(@"-registrationOrderID called");
    return @"12345";
}

- (id)registrationCompany
{
    NSLog(@"-registrationCompany called");
    return @"12345";
}

- (id)registrationName
{
    NSLog(@"-registrationName called");
    return @"12345";
}

- (id)registrationData
{
    NSLog(@"-registrationData called");
    return nil;
}

- (int)registrationType:(id)arg1
{
    NSLog(@"-registrationType called: %@", arg1);
    return 1;
}

- (id)registrationOrderID:(id)arg1
{
    NSLog(@"-registrationOrderID called: %@", arg1);
    return @"12345";
}

- (id)registrationCompany:(id)arg1
{
    NSLog(@"-registrationCompany called: %@", arg1);
    return @"12345";
}

- (id)registrationName:(id)arg1
{
    NSLog(@"-registrationName called: %@", arg1);
    return @"12345";
}

- (BOOL)checkRegistrationLicense:(id)arg1
{
    NSLog(@"-checkRegistrationLicense called: %@", arg1);
    return YES;
}

- (BOOL)checkRegistrationToken
{
    NSLog(@"-checkRegistrationToken called");
    return YES;
}

- (int)getRegistrationTokenFromServer
{
    NSLog(@"-getRegistrationTokenFromServer called");
    return 1;
}

+ (id)aquaticPrimeWithKey:(NSString *)key privateKey:(NSString *)privateKe
{
    NSLog(@"Public key: %@", key);
    NSLog(@"Private key: %@", privateKe);
    return nil;
}










static void (*orig_setApplicationStatus)(int);
static int (*orig_getApplicationStatus)(void);

void save_original_symbols() {
    orig_setApplicationStatus = dlsym(RTLD_DEFAULT, "_setApplicationStatus");
    orig_getApplicationStatus = dlsym(RTLD_DEFAULT, "_getApplicationStatus");
    
    if (orig_getApplicationStatus) {
        NSLog(@"FOUND!!!!!!!!!!!!");
    } else {
        NSLog(@"NOT FOUND!!!!!!!!!!!!");
    }
    // Do some error checking
	char* lError = dlerror();
	if (lError) {
		// This error doesn't get hit
		printf("Error: %s\n", lError);
	}
}

void my_setApplicationStatus(int s) {
    printf("Calling real setApplicationStatus\n");
    orig_setApplicationStatus(s);
}

int my_getApplicationStatus(int s) {
    printf("Calling real getApplicationStatus\n");
    
    return 1;
}

#include <sys/ptrace.h>
#include <sys/types.h>

+ (void)load
{
    NSLog(@"Hello from dylib");
    save_original_symbols();
    int a = rebind_symbols((struct rebinding[2]){{"_setApplicationStatus", my_setApplicationStatus}, {"_getApplicationStatus", my_getApplicationStatus}}, 2);
    NSLog(@"######## Error rebinding:%d", a);
//    [self swizzleInstanceMethod:@"checkSavedRegistration" withMethod:@"checkSavedRegistration"];
//    [self swizzleInstanceMethod:@"getRegistrationTokenFromServer" withMethod:@"getRegistrationTokenFromServer"];
//    [self swizzleInstanceMethod:@"checkRegistrationLicense:" withMethod:@"checkRegistrationLicense:"];
//    [self swizzleInstanceMethod:@"registrationName:" withMethod:@"registrationName:"];
//    [self swizzleInstanceMethod:@"registrationCompany:" withMethod:@"registrationCompany:"];
//    [self swizzleInstanceMethod:@"registrationOrderID:" withMethod:@"registrationOrderID:"];
//    [self swizzleInstanceMethod:@"registrationType:" withMethod:@"registrationType:"];
//    [self swizzleInstanceMethod:@"registrationData" withMethod:@"registrationData"];
//    [self swizzleInstanceMethod:@"registrationName" withMethod:@"registrationName"];
//    [self swizzleInstanceMethod:@"registrationCompany" withMethod:@"registrationCompany"];
//    [self swizzleInstanceMethod:@"registrationOrderID" withMethod:@"registrationOrderID"];
//    
//    [self swizzleClassMethod:@"registrationName" withMethod:@"registrationName"];
//    [self swizzleClassMethod:@"registrationOrderID" withMethod:@"registrationOrderID"];
//    [self swizzleClassMethod:@"checkSavedRegistration" withMethod:@"checkSavedRegistration"];
//    [self swizzleClassMethod:@"registrationType" withMethod:@"registrationType"];
    
//    [self swizzleClassMethod:@"aquaticPrimeWithKey:privateKey:" withMethod:@"aquaticPrimeWithKey:privateKey:"];
//    IMP imp = [self methodForSelector:NSSelectorFromString(@"checkRegistrationLicense:")];
//    void(* foo)(id, SEL, int) = (void(*)(id, SEL, int))imp;
//    char * dump = (char *)foo;
//    
//    NSData *data = [NSData dataWithBytes:dump
//                                  length:2000];
//    
//    [data writeToFile:@"/Users/davidsahakyan/Desktop/dump/checkRegistrationLicense_dump.bin" atomically:YES];
}

+ (id)callMethod:(NSString *)aMethod onClass:(NSString *)aClass
{
    return objc_msgSend(NSClassFromString(aClass), NSSelectorFromString(aMethod));
}

+ (id)callMethod:(NSString *)aMethod onInstance:(id)aInstance
{
    return objc_msgSend(aInstance, NSSelectorFromString(aMethod));
}

+ (void)swizzleInstanceMethod:(NSString *)aOrigMethod
                   withMethod:(NSString *)aSwizzleMethod
{
    Method origMethod = class_getInstanceMethod(NSClassFromString(@"HopperAppDelegate"), NSSelectorFromString(aOrigMethod));
    Method newMethod = class_getInstanceMethod([self class], NSSelectorFromString(aSwizzleMethod));
    method_exchangeImplementations(origMethod, newMethod);
}

+ (void)swizzleClassMethod:(NSString *)aOrigMethod
                   withMethod:(NSString *)aSwizzleMethod
{
    Method origMethod = class_getClassMethod(NSClassFromString(@"AquaticPrime"), NSSelectorFromString(aOrigMethod));
    Method newMethod = class_getClassMethod([self class], NSSelectorFromString(aSwizzleMethod));
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)applicationWillFinishLaunching:(id)arg1
{
    NSLog(@"########## Catched");
}

@end
