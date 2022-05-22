const std = @import("std");
const print = std.debug.print;
const bltin = @import("builtin");
const asBytes = std.mem.asBytes;
const ArrayList = std.ArrayList;
pub const fgs = .{
    .red = 91,
    .green = 92,
    .yellow = 93,
    .blue = 94,
    .magenta = 95,
    .cyan = 96,
    .white = 97,
    .black = 90,
};
pub const bgs = .{
    .red = 101,
    .green = 102,
    .yellow = 103,
    .blue = 104,
    .magenta = 105,
    .cyan = 106,
    .white = 107,
    .black = 100,
};
const Bar = struct {
    bar: ArrayList(u8),
    pub fn progress(self: *Bar, percent: usize, moveBar: bool) !void {
        if (moveBar) {
            try self.bar.appendSlice("\u{2588}");
        }
        print("\r\x1B[94m({s}%)\x1B[0m  \x1B[32m\x1B[0m", .{asBytes(&percent), self.bar.items});
    }
};
pub fn printColored(s: [*]const u8, foreground: i32, background: i32) !void {
    print("\x1B[{s};{s}m{s}\x1B[0m", .{asBytes(&background), asBytes(&foreground), s});
}
pub fn init() *Bar {
    var b = Bar{.bar = ArrayList(u8).init(std.mem.Allocator.init())};
    return &b;
}
test "prints colored text" {
    var b = init();
    try printColored("hello world!", fgs.green, bgs.black);
    for (@as([100]u0, undefined)) |_, i| {
        try b.progress(i, true);
    }
}