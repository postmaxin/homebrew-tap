class Mediagrep < Formula
  desc "Grep for media metadata, using MediaInfoLib"
  homepage "https://github.com/postmaxin/mediagrep"
  url "https://github.com/postmaxin/mediagrep/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3f39eed70293c83ac4f56ededae34f20d967a7e75083521383cc8eaa9187e505"
  license "BSD-2-Clause"
  head "https://github.com/postmaxin/mediagrep.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "libmediainfo"

  def install
    # Load the Homebrew library by absolute path, so the runtime loader
    # needs no search. opt_lib survives libmediainfo upgrades.
    mediainfo_dylib = Formula["libmediainfo"].opt_lib/"libmediainfo.0.dylib"

    system "cmake", "-S", ".", "-B", "build",
                    "-DMEDIAGREP_BUILD_TESTS=OFF",
                    "-DMEDIAGREP_MEDIAINFO_LIBRARY=#{mediainfo_dylib}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    version = shell_output("#{bin}/mediagrep --version")
    assert_match "MediaInfoLib", version
    refute_match "not found", version

    # A one-sample 8-bit mono PCM WAV file, written byte by byte.
    wav = "RIFF".b + [37].pack("V") + "WAVEfmt ".b + [16, 1, 1, 8000, 8000, 1, 8].pack("VvvVVvv") +
          "data".b + [1].pack("V") + "\x80".b
    (testpath/"tone.wav").binwrite(wav)

    assert_match "PCM", shell_output("#{bin}/mediagrep -i pcm #{testpath}/tone.wav")
  end
end
