include ./Makefile.in

# -------------------------

siteResponse: ./SiteResponse/Main.cpp $(FEMlib)
	make libs
	@$(CXX) $(CXXOPTFLAG) $(THIRDPARTY_INCLUDE) $(LINCLUDE) $(MINCLUDE) ./SiteResponse/Main.cpp $(UTILlib) $(SRTlib) $(FEMlib) $(THIRDPARTY_LIB) $(NUMLIBS) -o $(source)/bin/siteresponse
	
fem:
	make tidy
	make siteResponse

$(FEMlib):
	@ make libs

archive: $(OBJS)
	ar rv $(FEMlib) $(OBJS)

libs:
	(mkdir -p bin)
	(mkdir -p lib)
	(cd FEM; make archive)
	(cd SiteResponse; make archive)
	(cd Utilities; make archive)

clean:
	(cd FEM; make clean)
	(cd SiteResponse; make clean)
	(cd Utilities; make clean)
	
tidy:
	rm -f $(source)/bin/siteresponse
	rm -f $(source)/lib/*.a
	make clean

install: siteResponse
	cp $(source)/bin/siteresponse $(HOME)/bin/.


