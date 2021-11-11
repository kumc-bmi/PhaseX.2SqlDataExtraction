set +x
grep -i 'error' ${console_log} >error.log
grep 'ORA-' ${console_log} >error_ORA.log
grep 'SP2-' ${console_log} >error_SP2.log
