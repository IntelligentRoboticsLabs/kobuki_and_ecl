##############################################################################
# Enable
##############################################################################

# Enable CXX17 and abort if not available
macro(ecl_enable_cxx17_compiler)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)  # aborts with an error if the requested standard is not available
  set(CMAKE_CXX_EXTENSIONS OFF)  # if ON, it will use gnu++17 instead of std++17
  set(CMAKE_CXX_STANDARD 17)
endmacro()

# Enable at least CXX14 (uses CXX17 for Jazzy/Sophus compatibility)
macro(ecl_enable_cxx14_compiler)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)  # aborts with an error if the requested standard is not available
  set(CMAKE_CXX_EXTENSIONS OFF)  # if ON, it will use gnu++17 instead of std++17
  set(CMAKE_CXX_STANDARD 17)
endmacro()

# Enable CXX11 and abort if not available
macro(ecl_enable_cxx11_compiler)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)  # aborts with an error if the requested standard is not available
  set(CMAKE_CXX_EXTENSIONS OFF)  # if ON, it will use gnu++11 instead of std++11
  set(CMAKE_CXX_STANDARD 11)
endmacro()

# Enable the kitchen sink, i.e. as much as possible.
macro(ecl_enable_cxx_warnings)
  if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wall -Wextra -Werror -Wpedantic)
  endif()
endmacro()

#--------------------------------------------------------------------------
# Conda/Pixi packaging friendliness
#
# When building inside a Conda environment (including Pixi), CMake commonly
# injects the environment's lib directory into the installed RPATH.
# That makes artifacts non-portable if they are later packaged/reused under a
# different prefix. Prefer relying on the environment setup hooks instead.
#--------------------------------------------------------------------------
if(UNIX AND NOT APPLE)
  if(DEFINED ENV{CONDA_PREFIX})
    set(CMAKE_INSTALL_RPATH "" CACHE STRING "" FORCE)
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH OFF CACHE BOOL "" FORCE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF CACHE BOOL "" FORCE)
  endif()
endif()

