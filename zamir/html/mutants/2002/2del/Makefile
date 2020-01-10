
STATIC_HTML_FILES=	mutants_main.html	\

STATIC_SOURCE_FILES= $(STATIC_HTML_FILES:.html=.static)

$(HEADER): ;

$(FOOTER): ;

%.html: %.static $(HEADER) $(FOOTER)
	@$(UPDATE_SCRIPT) header_file=$(HEADER) footer_file=$(FOOTER) source_file=$< target_file=$@

update_static_pages: $(STATIC_HTML_FILES)
