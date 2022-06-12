#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "../src/heap-inl.h"
#import "../src/idna.h"
#import "../src/queue.h"
#import "../src/strscpy.h"
#import "../src/uv-common.h"
#import "../src/unix/atomic-ops.h"
#import "../src/unix/internal.h"
#import "../src/unix/spinlock.h"
#import "uv.h"
#import "uv/errno.h"
#import "uv/threadpool.h"
#import "uv/version.h"
#import "uv/tree.h"
#import "uv/unix.h"
#import "uv/darwin.h"

FOUNDATION_EXPORT double uvVersionNumber;
FOUNDATION_EXPORT const unsigned char uvVersionString[];

