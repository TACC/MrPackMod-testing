cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for libm testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

target_link_libraries(
	${PROJECTNAME} PUBLIC
	m dl
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
