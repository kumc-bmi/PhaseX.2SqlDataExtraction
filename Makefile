export console_log=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/log

all: .make.4CE_PhaseX2_ExportFiles_oracle .make.grep_potential_issues

.make.4CE_PhaseX2_ExportFiles_oracle: .make.4CE_PhaseX2_Files_oracle
	mkdir -p export
	rm -rf export/*
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_ExportFiles_oracle.sql export

	touch .make.4CE_PhaseX2_ExportFiles_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql "${crcSchema}" "${source_data_updated_date}"

	touch .make.4CE_PhaseX2_Files_oracle

.make.grep_potential_issues:
	./grep_potential_issues.sh

	touch .make.grep_potential_issues

clean:
	rm .make* || true
