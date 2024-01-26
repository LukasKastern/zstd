const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zstd = b.addStaticLibrary(.{
        .name = "zstd",
        .target = target,
        .optimize = optimize,
    });

    zstd.linkLibC();

    zstd.addCSourceFiles(&.{
        "./lib/common/debug.c",
        "./lib/common/entropy_common.c",
        "./lib/common/error_private.c",
        "./lib/common/fse_decompress.c",
        "./lib/common/pool.c",
        "./lib/common/threading.c",
        "./lib/common/xxhash.c",
        "./lib/common/zstd_common.c",

        "./lib/compress/fse_compress.c",
        "./lib/compress/hist.c",
        "./lib/compress/huf_compress.c",
        "./lib/compress/zstd_compress.c",
        "./lib/compress/zstd_compress_literals.c",
        "./lib/compress/zstd_compress_sequences.c",
        "./lib/compress/zstd_compress_superblock.c",
        "./lib/compress/zstd_double_fast.c",
        "./lib/compress/zstd_fast.c",
        "./lib/compress/zstd_lazy.c",
        "./lib/compress/zstd_ldm.c",
        "./lib/compress/zstd_opt.c",
        "./lib/compress/zstdmt_compress.c",

        "./lib/decompress/huf_decompress.c",
        "./lib/decompress/zstd_ddict.c",
        "./lib/decompress/zstd_decompress.c",
        "./lib/decompress/zstd_decompress_block.c",

        "./lib/decompress/huf_decompress_amd64.S",
    }, &.{});

    zstd.addIncludePath(.{ .path = "./lib" });

    b.installArtifact(zstd);
    zstd.installHeadersDirectory("./lib", "zstd");
}
