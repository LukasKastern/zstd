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

    const zstd_root = "third_party/zstd-dev/lib/";

    zstd.addCSourceFiles(&.{
        zstd_root ++ "/common/debug.c",
        zstd_root ++ "/common/entropy_common.c",
        zstd_root ++ "/common/error_private.c",
        zstd_root ++ "/common/fse_decompress.c",
        zstd_root ++ "/common/pool.c",
        zstd_root ++ "/common/threading.c",
        zstd_root ++ "/common/xxhash.c",
        zstd_root ++ "/common/zstd_common.c",

        zstd_root ++ "/compress/fse_compress.c",
        zstd_root ++ "/compress/hist.c",
        zstd_root ++ "/compress/huf_compress.c",
        zstd_root ++ "/compress/zstd_compress.c",
        zstd_root ++ "/compress/zstd_compress_literals.c",
        zstd_root ++ "/compress/zstd_compress_sequences.c",
        zstd_root ++ "/compress/zstd_compress_superblock.c",
        zstd_root ++ "/compress/zstd_double_fast.c",
        zstd_root ++ "/compress/zstd_fast.c",
        zstd_root ++ "/compress/zstd_lazy.c",
        zstd_root ++ "/compress/zstd_ldm.c",
        zstd_root ++ "/compress/zstd_opt.c",
        zstd_root ++ "/compress/zstdmt_compress.c",

        zstd_root ++ "/decompress/huf_decompress.c",
        zstd_root ++ "/decompress/zstd_ddict.c",
        zstd_root ++ "/decompress/zstd_decompress.c",
        zstd_root ++ "/decompress/zstd_decompress_block.c",

        zstd_root ++ "/decompress/huf_decompress_amd64.S",
    }, &.{});

    zstd.addIncludePath(.{ .path = zstd_root });
}
