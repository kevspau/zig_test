const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("loadz", "src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run deez nuts");
    test_step.dependOn(&exe_tests.step);
}
