export console_log="${JENKINS_HOME}"/jobs/"${JOB_NAME}"/builds/"${BUILD_NUMBER}"/log

all:.make.4CE_PhaseX2_Files_oracle .make.4CE_PhaseX2_ExportFiles_oracle .make.grep_error

.make.4CE_PhaseX2_ExportFiles_oracle: #.make.4CE_PhaseX2_Files_oracle
	mkdir -p export
	rm -rf export/*
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_ExportFiles_oracle.sql export

	touch .make.4CE_PhaseX2_ExportFiles_oracle

.make.4CE_PhaseX2_Files_oracle:
	sqlplus $(ORACLE_USERNAME)/"$(ORACLE_PASSWORD)"@$(ORACLE_HOST):$(ORACLE_PORT)/$(ORACLE_SID) @4CE_PhaseX2_Files_oracle.sql "${crcSchema}" "${source_data_updated_date}"

	touch .make.4CE_PhaseX2_Files_oracle

.make.grep_error: .make.4CE_PhaseX2_ExportFiles_oracle
	grep -i 'error' "${console_log}" > error.log
	grep    'ORA-'  "${console_log}" > error_ORA.log
	grep    'SP2-'  "${console_log}" > error_SP2.log

	touch .make.grep_error

clean:
	rm .make* || true
