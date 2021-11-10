all:.make.4CE_PhaseX2_Files_oracle .make.4CE_PhaseX2_ExportFiles_oracle

.make.4CE_PhaseX2_ExportFiles_oracle: .make.4CE_PhaseX2_Files_oracle
	mkdir -p export_PhaseX.2
	rm -rf export_PhaseX.2
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_ExportFiles_oracle.sql export_PhaseX.2

	touch .make.4CE_PhaseX2_ExportFiles_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql "${crcSchema}" "${source_data_updated_date}"

	touch .make.4CE_PhaseX2_Files_oracle


clean:
	rm .make* || true
