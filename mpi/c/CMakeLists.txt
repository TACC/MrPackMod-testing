cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for MPI testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( MPI 3.1 REQUIRED )
message( STATUS "CMAKE_C_COMPILER=${CMAKE_C_COMPILER}" )
message( STATUS "MPI_C_COMPILER=${MPI_C_COMPILER}" )
message( STATUS "MPI_C_HEADER_DIR=${MPI_C_HEADER_DIR}" )
# 4.5 and higher?
message( STATUS "MPI_C_INCLUDE_DIRS=${MPI_C_INCLUDE_DIRS}" )
message( STATUS "MPI_C_LINK_FLAGS=${MPI_C_LINK_FLAGS}" )

target_link_libraries(
	${PROJECTNAME} PUBLIC
	MPI::MPI_C
	# ${MPI_C_LIBRARIES} 
	)
install( TARGETS ${PROJECTNAME} DESTINATION . )
