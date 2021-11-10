export logfile=output.log

all:.make.4CE_PhaseX2_Files_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql "${crcSchema}" "${source_data_updated_date}" "${logfile}"

	touch .make.4CE_PhaseX2_Files_oracle

.make.4CE_PhaseX2_ExportFiles_oracle:
	mkdir -p export
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_ExportFiles_oracle.sql 

	touch .make.4CE_PhaseX2_ExportFiles_oracle
clean:
	rm .make* || true
