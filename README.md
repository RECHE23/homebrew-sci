# RECHE23/homebrew-sci

Homebrew tap for the Sci* ecosystem — header-only C++ scientific libraries.

    brew tap RECHE23/sci
    brew install RECHE23/sci/real-regex

## Formulae
| Formula      | Description |
|--------------|-------------|
| `real-regex` | Header-only linear-time, ReDoS-safe regex engine for C++20 |

_scilex, scilang, … to follow._

## Using real-regex after `brew install`

The formula installs the headers, a pkg-config file, and a CMake package config under
your Homebrew prefix. REAL is header-only and requires **C++20**.

**CMake** — `find_package`:

    find_package(real CONFIG REQUIRED)
    target_link_libraries(your_app PRIVATE real::real)

**pkg-config**:

    c++ -std=c++20 $(pkg-config --cflags real) app.cpp -o app

**Direct include**:

    c++ -std=c++20 -I"$(brew --prefix real-regex)/include" app.cpp -o app

Minimal program (`app.cpp`):

    #include <real/real.hpp>
    int main() {
      real::regex re("[0-9]+");
      return re.search("answer 42").matched() ? 0 : 1;
    }
