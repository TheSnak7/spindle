# Spindle

A Zig library for memory allocation.

## Example

```zig
const std = @import("std");
const spd = @import("spindle");

// Notice the function takes an spd.Allocator, not anytype
fn allocU8(alloc: spd.Allocator) !*u8 {
    return try alloc.create(u8);
}

test "basic usage" {
    const alloc = t.allocator;

    // We pass the struct to the function expecting the trait
    // using a decl literal
    const byte = try allocU8(.allocator(alloc));

    defer alloc.destroy(byte);
    
    byte.* = 4;

    try t.expectEqual(4, byte.*);
}
```

## Usage

build.zig.zon
```zig 
.spindle = .{
    .url = "git+https://github.com/TheSnak7/spindle#<commit hash>"
    .hash = "<hash>",
}
```
build.zig
```zig
const spindle = b.depencency("spindle", .{}).module("spindle");
my_lib.addImport("spindle", spindle);
```

## Prblems

Today in Zig some runtime control flow does not well mesh with comptime. This is only a small experiment. 

### More
On runtime control flow:
https://zsf.zulipchat.com/#narrow/channel/454360-compiler/topic/comptime.20control.20flow
On why we cannot use comptime vars: 
https://ziggit.dev/t/comptime-mutable-memory-changes/3702
Inline fns:
https://ziglang.org/documentation/master/#inline-fn


