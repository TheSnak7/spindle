const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const spindle = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
    });

    {
        const spindle_test = b.addTest(.{
            .name = "spindletest",
            .root_source_file = b.path("src/test.zig"),
            .target = target,
            .optimize = optimize,
        });

        spindle_test.root_module.addImport("spindle", spindle);

        const test_step = b.step("test", "Run tests");
        test_step.dependOn(&b.addRunArtifact(spindle_test).step);
    }

    {
        const spindle_check = b.addExecutable(.{
            .name = "spindltest",
            .root_source_file = b.path("src/test.zig"),
            .target = target,
            .optimize = optimize,
        });

        spindle_check.root_module.addImport("spindle", spindle);

        const check = b.step("check", "Check if spindle compiles");
        check.dependOn(&spindle_check.step);
    }
}
