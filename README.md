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

