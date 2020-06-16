CC = gcc
CFLAGS = -Wall -std=c99 -pedantic -g -DMOVE_IO_CLOSE -DEN_TIME
MFLAGS = -Wall -std=c99 -pedantic -g -DMOVE_IO_CLOSE 
HW8CSRC = hw8c.c
OPT1SRC = hw8c_opt1.c
OPT2SRC = hw8c_opt2.c
OPT3SRC = hw8c_opt3.c
OBJ0 = $(patsubst %.c, %.o, $(HW8CSRC))
OBJ1 = $(patsubst %.c, %.o, $(OPT1SRC))
OBJ2 = $(patsubst %.c, %.o, $(OPT2SRC))
OBJ3 = $(patsubst %.c, %.o, $(OPT3SRC))
EXE = hw8c
EXEOPT1 = hw8c_opt1
EXEOPT2 = hw8c_opt2
EXEOPT3 = hw8c_opt3
VALGRIND = valgrind --tool=memcheck --leak-check=yes --track-origins=yes 
RESULTS = out.txt
MEMTXT = mem.txt

.SILENT:
all: $(EXE) $(EXEOPT1) $(EXEOPT2) $(EXEOPT3)

$(EXE): $(OBJ0)
	@echo "Linking hw8c..."
	$(CC) $(OBJ0) -o $(EXE)
	$(CC) $(OBJ0) -o hw8c_0
	$(CC) $(OBJ0) -o hw8c_2
	$(CC) $(OBJ0) -o hw8c_3
	$(CC) $(OBJ0) -o hw8c_mem

$(EXEOPT1): $(OBJ1)
	@echo "Linking opt1..."
	$(CC) $(OBJ1) -o $(EXEOPT1)	
	$(CC) $(OBJ1) -o hw8c_opt1_0
	$(CC) $(OBJ1) -o hw8c_opt1_2
	$(CC) $(OBJ1) -o hw8c_opt1_3
	$(CC) $(OBJ1) -o hw8c_opt1_mem

$(EXEOPT2): $(OBJ2)
	@echo "Linking opt2..."
	$(CC) $(OBJ2) -o $(EXEOPT2)	
	$(CC) $(OBJ2) -o hw8c_opt2_0
	$(CC) $(OBJ2) -o hw8c_opt2_2
	$(CC) $(OBJ2) -o hw8c_opt2_3
	$(CC) $(OBJ2) -o hw8c_opt2_mem

$(EXEOPT3): $(OBJ3)
	@echo "Linking opt3..."
	$(CC) $(OBJ3) -o $(EXEOPT3)	
	$(CC) $(OBJ3) -o hw8c_opt3_0
	$(CC) $(OBJ3) -o hw8c_opt3_2
	$(CC) $(OBJ3) -o hw8c_opt3_3
	$(CC) $(OBJ3) -o hw8c_opt3_mem

.c.o: 
	@echo "Compiling program $*.c"
	$(CC) $(CFLAGS) -O1 $*.c -c
	$(CC) $(CFLAGS) -O0 $*.c -c
	$(CC) $(CFLAGS) -O2 $*.c -c
	$(CC) $(CFLAGS) -O3 $*.c -c
	$(CC) $(MFLAGS) -O1 $*.c -c

test: $(EXE) 
	@echo "running tests"
	@echo "---------TESTING HW8C---------" > $(RESULTS)
	./$(EXE) data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_0---------" >> $(RESULTS)
	./hw8c_0 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_2---------" >> $(RESULTS)
	./hw8c_2 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_3---------" >> $(RESULTS)
	./hw8c_3 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT1---------" >> $(RESULTS)
	./$(EXEOPT1) data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT1_0---------" >> $(RESULTS)
	./hw8c_opt1_0 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT1_2---------" >> $(RESULTS)
	./hw8c_opt1_2 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT1_3---------" >> $(RESULTS)
	./hw8c_opt1_3 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT2---------" >> $(RESULTS)
	./$(EXEOPT2) data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT2_0---------" >> $(RESULTS)
	./hw8c_opt2_0 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT2_2---------" >> $(RESULTS)
	./hw8c_opt2_2 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT2_3---------" >> $(RESULTS)
	./hw8c_opt2_3 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT3---------" >> $(RESULTS)
	./$(EXEOPT3) data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT3_0---------" >> $(RESULTS)
	./hw8c_opt3_0 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT3_2---------" >> $(RESULTS)
	./hw8c_opt3_2 data.txt >> $(RESULTS) 
	@echo "---------TESTING HW8C_OPT3_3---------" >> $(RESULTS)
	./hw8c_opt3_3 data.txt >> $(RESULTS) 
	@echo "check out.txt for results"

.PHONY: mem clean test all help
mem: $(EXE)
	@echo "running valgrind on hw8c_mem"
	@echo "running valgrind on hw8c_mem" > $(MEMTXT)
	$(VALGRIND) ./hw8c_mem data.txt >> $(MEMTXT) 2>&1
	@echo "running valgrind on hw8c_opt1_mem"
	@echo "running valgrind on hw8c_opt1_mem" >> $(MEMTXT)
	$(VALGRIND) ./hw8c_opt1_mem data.txt >> $(MEMTXT) 2>&1
	@echo "running valgrind on hw8c_opt2_mem"
	@echo "running valgrind on hw8c_opt2_mem" >> $(MEMTXT) 
	$(VALGRIND) ./hw8c_opt2_mem data.txt >> $(MEMTXT) 2>&1
	@echo "running valgrind on hw8c_opt3_mem"
	@echo "running valgrind on hw8c_opt3_mem" >> $(MEMTXT) 
	$(VALGRIND) ./hw8c_opt3_mem data.txt >> $(MEMTXT) 2>&1
	@echo "check mem.txt for valgrind outputs"
#	cat $(MEMTXT)

clean: 
	-rm -f $(OBJ0) $(RESULTS) $(MEMTXT) hw8c hw8c_0 hw8c_2 hw8c_3 hw8c_mem
	-rm -f $(OBJ1) hw8c_opt1 hw8c_opt1_0 hw8c_opt1_2 hw8c_opt1_3 hw8c_opt1_mem
	-rm -f $(OBJ2) hw8c_opt2 hw8c_opt2_0 hw8c_opt2_2 hw8c_opt2_3 hw8c_opt2_mem
	-rm -f $(OBJ3) hw8c_opt3 hw8c_opt3_0 hw8c_opt3_2 hw8c_opt3_3 hw8c_opt3_mem

help:
	@echo "make options are: all, clean, mem, test"

