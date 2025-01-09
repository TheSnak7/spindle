const std = @import("std");
const t = std.testing;
const spd = @import("spindle");

test "Allocator trait" {
    const alloc = t.allocator;

    const byte = try allocU8(.allocator(alloc));
    defer alloc.destroy(byte);

    byte.* = 4;

    try t.expectEqual(4, byte.*);
}

fn allocU8(alloc: spd.Allocator) !*u8 {
    return try alloc.create(u8);
}

test "Allocator vtable interface" {
    const alloc = t.allocator;

    const byte = try alloc.create(u8);
    defer alloc.destroy(byte);

    byte.* = 4;

    try t.expectEqual(4, byte.*);
}
