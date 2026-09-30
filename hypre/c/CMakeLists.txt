cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Hypre testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
# find_package( PkgConfig REQUIRED )
find_package( HYPRE REQUIRED )

message( STATUS "Hypre includes: ${HYPRE_INCLUDE_DIRS}" )
message( STATUS "Hypre library dires: ${HYPRE_LIBRARY_DIRS}" )
message( STATUS "Hypre libraries: ${HYPRE_LIBRARIES}" )

target_link_libraries( ${PROJECTNAME} PUBLIC HYPRE::HYPRE )

target_link_libraries(
        ${PROJECTNAME} PUBLIC m
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
