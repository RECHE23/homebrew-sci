class RealRegex < Formula
  desc "Header-only linear-time, ReDoS-safe regex engine for C++20"
  homepage "https://github.com/RECHE23/real-regex"
  url "https://github.com/RECHE23/real-regex/archive/refs/tags/v2026.7.46.tar.gz"
  sha256 "03948e580403d989f3eadb495754c38fcbe2bd49b911de30c99d1607941df244"
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
