cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for Kokkos testing"
  VERSION 1.0
  LANGUAGES CUDA CXX
)

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cu )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

set(CMAKE_CXX_EXTENSIONS OFF)
find_package( Kokkos REQUIRED )

target_link_libraries( ${PROJECTNAME} Kokkos::kokkos)

install( TARGETS ${PROJECTNAME} DESTINATION . )
