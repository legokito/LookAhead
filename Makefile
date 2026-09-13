CXX      = clang++
CXXFLAGS = -std=c++20 -O2
LDFLAGS  = -framework CoreFoundation -framework CoreAudio -framework AudioToolbox

SRC = main.cpp hmm.cpp cqt.cpp featureExtractor.cpp ring_buffer.cpp \
      templateGen.cpp visualizer.cpp miniaudio.cpp
OBJ = $(SRC:.cpp=.o)
DEP = $(OBJ:.o=.d)

SCORE ?= data_files/chopin-nocturne-op-9-no-1.mxl
DATA   = svgs data_files/*.f32 data_files/*.i64 data_files/*.mid data_files/*.wav

actualRun: $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

run: actualRun
	trap 'rm -rf $(DATA)' EXIT INT TERM; ./actualRun $(SCORE)

clean:
	rm -f actualRun $(OBJ) $(DEP)

clean-data:
	rm -rf $(DATA)

-include $(DEP)

.PHONY: run clean clean-data
