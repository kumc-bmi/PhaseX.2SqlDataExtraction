all:.make.4CE_PhaseX2_Files_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus -s $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql

	touch .make.4CE_PhaseX2_Files_oracle

clean:
	rm .make* || true
