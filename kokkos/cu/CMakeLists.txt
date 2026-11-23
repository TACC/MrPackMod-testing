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
kokkos_check(DEVICES CUDA RETURN_VALUE has_cuda)
if(has_cuda)
  message(STATUS "Kokkos was built with CUDA")
else()
  message(FATAL_ERROR
    "This project requires Kokkos built with the CUDA backend, "
    "but the Kokkos found at ${Kokkos_DIR} does not provide it "
    "(enabled devices: ${Kokkos_DEVICES})."
    )
endif()


target_link_libraries( ${PROJECTNAME} Kokkos::kokkos)

install( TARGETS ${PROJECTNAME} DESTINATION . )
