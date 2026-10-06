cmake_minimum_required(VERSION 3.31)
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for Cantera testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} )
target_sources( ${PROJECTNAME} PRIVATE ${PROJECTNAME}.cpp)
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_20 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( CANTERA REQUIRED cantera )
pkg_check_modules( FMTLIB REQUIRED fmt )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${CANTERA_INCLUDE_DIRS}
	${FMTLIB_INCLUDE_DIRS}
        )

target_link_directories(
        ${PROJECTNAME} PUBLIC
        ${CANTERA_LIBRARY_DIRS}
	${FMTLIB_LIBRARY_DIRS}
        )

target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${CANTERA_LIBRARIES}
	${FMTLIB_LIBRARIES}
        )

install(TARGETS ${PROJECTNAME} DESTINATION . )
