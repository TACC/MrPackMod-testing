cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for Netcdf testing"
  VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECTNAME}.f90 )

find_package( PkgConfig REQUIRED )
message( STATUS "found pkgconfig" )
pkg_check_modules( NETCDF  REQUIRED netcdf )
message( STATUS "found netcdf" )
pkg_check_modules( NETCDFF REQUIRED netcdf-fortran )
message( STATUS "found netcdff" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_INCLUDE_DIRS}
        ${NETCDFF_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_LIBRARIES}
        ${NETCDFF_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${NETCDF_LIBRARY_DIRS}
	${NETCDFF_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC netcdff netcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
