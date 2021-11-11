set +x
grep -i 'error' ${console_log} >error.log || true # true needed if there is no match found
grep 'ORA-' ${console_log} >error_ORA.log || true # true needed if there is no match found
grep 'SP2-' ${console_log} >error_SP2.log || true # true needed if there is no match found
