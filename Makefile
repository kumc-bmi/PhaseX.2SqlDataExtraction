export console_log=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/log

all: .make.grep_potential_issues

.make.grep_potential_issues: .make.table_row_counts
	./grep_potential_issues.sh

	touch .make.grep_potential_issues

.make.table_row_counts: .make.4CE_PhaseX2_ExportFiles_oracle
	cd export && wc -l * > table_row_counts.csv
	
	touch .make.table_row_counts


.make.4CE_PhaseX2_ExportFiles_oracle: .make.4CE_PhaseX2_Files_oracle
	mkdir -p export
	rm -rf export/*
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_ExportFiles_oracle.sql export

	touch .make.4CE_PhaseX2_ExportFiles_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql "${crcSchema}" "${source_data_updated_date}"

	touch .make.4CE_PhaseX2_Files_oracle


clean:
	rm .make* || true
