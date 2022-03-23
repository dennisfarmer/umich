EXECUTABLE = problem3

# The following line looks for a project's main() in files named project*.cpp,
# executable.cpp (substituted from EXECUTABLE above), or main.cpp
PROJECTFILE = $(or $(wildcard project*.cpp $(EXECUTABLE).cpp), main.cpp)
CXX         = g++
TESTSOURCES = $(wildcard test*.cpp)
TESTS       = $(TESTSOURCES:%.cpp=%)

SOURCES     = $(wildcard *.cpp)
SOURCES     := $(filter-out $(TESTSOURCES), $(SOURCES))
OBJECTS     = $(SOURCES:%.cpp=%.o)

CXXFLAGS = -std=c++17 -Wconversion -Wall -Werror -Wextra -pedantic 

$(EXECUTABLE): $(OBJECTS)
ifeq ($(EXECUTABLE), executable)
	@echo Edit EXECUTABLE variable in Makefile.
	@echo Using default a.out.
	$(CXX) $(CXXFLAGS) $(OBJECTS)
else
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $(EXECUTABLE)
endif

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $*.cpp

test:
	@make $(EXECUTABLE) >/dev/null
	./$(EXECUTABLE) 50 600 40 27

clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

#define MAKEFILE_HELP
#...
#endef
#export MAKEFILE_HELP

#help:
#@echo "$$MAKEFILE_HELP"

help:
	@make $(EXECUTABLE) >/dev/null
	@./$(EXECUTABLE) --help


.PHONY: release clean

