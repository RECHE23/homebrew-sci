class RealRegex < Formula
  desc "Header-only linear-time, ReDoS-safe regex engine for C++20"
  homepage "https://github.com/RECHE23/real-regex"
  url "https://github.com/RECHE23/real-regex/archive/refs/tags/v2026.7.5.tar.gz"
  sha256 "bfda1f75cb2d1895a06c96f1b0540100d346b3843638030022c33e5a0918e275"
  license "MIT"
  head "https://github.com/RECHE23/real-regex.git", branch: "main"

  depends_on "cmake" => :build

  def install
    # Library only — BUILD_TESTING=OFF keeps the SciForge test harness out of the
    # packaged build (it is needed solely for REAL's own test suite, not the library).
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_TESTING=OFF"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"smoke.cpp").write <<~CPP
      #include <real/real.hpp>
      #include <real/version.hpp>
      static_assert(REAL_VERSION_MAJOR >= 2026, "version macro visible");
      int main()
      {
        const real::regex re("[0-9]+");
        return re.search("abc 42").matched() ? 0 : 1;
      }
    CPP
    system ENV.cxx, "-std=c++20", "-I#{include}", "smoke.cpp", "-o", "smoke"
    system "./smoke"
  end
end
