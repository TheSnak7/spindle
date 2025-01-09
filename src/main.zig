pub const Allocator = struct {
    pub const Error = error{OutOfMemory};

    ImplType: type,
    impl_ptr: *anyopaque,

    pub fn allocator(comptime impl_struct: anytype) Allocator {
        return .{
            .ImplType = @TypeOf(impl_struct),
            .impl_ptr = @constCast(@alignCast(@ptrCast(&impl_struct))),
        };
    }

    fn liftImpl(comptime self: Allocator) self.ImplType {
        return @as(*self.ImplType, @alignCast(@ptrCast(self.impl_ptr))).*;
    }

    pub fn alloc(self: Allocator, comptime T: type, n: usize) Error![]T {
        return try self.liftImpl().alloc(T, n);
    }

    pub fn create(self: Allocator, comptime T: type) Error!*T {
        return try self.liftImpl().create(T);
    }
};

pub fn todo(message: []const u8) noreturn {
    @compileError("TODO: " ++ message);
}

pub fn unimplemented() noreturn {
    @compileError("Unimplemented");
}
