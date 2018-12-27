#! /bin/csh -f

set resultDir = ./results

# set this to correct folder
set scriptDir = ./scripts
set weights = ( 3 3 5 5 5 5 3 5 3 5 3 3 3 5 3 3 3 5 2 3 5 3 3 3 3 3 5 ) #6 6 6 6 6 12.5 12.5 12.5 12.5 10 )

if ($#argv == 1) then
    set list = $argv
    if ($list > 34) then
	echo "test ${list}: does not exist"
	exit 1
    endif
else
    set list = "0 1 2 3 4 5 6 7 8 11 12 13 14 15 17 19 20 21 22 23 24 25 26 29 30 33 34"
else
    echo "usage: run-tests.csh [whichTest]"
    exit 1
endif

if (!(( -e para.c) )) then
    echo "para.c not found. Please type 'cp ./para.c .'"
    exit 1
endif

gcc -o para para.c

make
if ($status != 0) then
    echo "Build Failed"
    exit 1
endif

@ TOTAL = 0
@ PASS = 0
@ FAIL = 0
@ TAKEN = 0
@ INDEX = 0
foreach test ($list)
    @ INDEX = $INDEX + 1
    set tmpFile = `mktemp`

    rm -f ${resultDir}/fileout
    # create the correct output
    
    # this is how you run the particular test
    (${scriptDir}/test${test}.csh > ${tmpFile}.out) >& ${tmpFile}.err
    set testStatus = $status

    # check for differences in output
    diff ${tmpFile}.out ${resultDir}/${test}.out >& ${tmpFile}.out.diff
    diff ${tmpFile}.err ${resultDir}/${test}.err >& ${tmpFile}.err.diff


    @ fail = 0
    # check if standard output, standard error are correct
    foreach type ("out" "err")
	set check = `stat -c %s ${tmpFile}.${type}.diff`
	if ($check != "0") then
	    echo "TEST ${test}: bad std${type} output"
	    echo "** Expected:"
	    cat ${resultDir}/${test}.${type}  | head -10
	    echo "** Got:"
	    cat ${tmpFile}.${type} | head -10
	    echo "** Diff file (which should be empty) instead contains:"
	    cat ${tmpFile}.${type}.diff | head -10
	    echo ""
	    @ fail = $fail + 1
	endif
    end

    # what return code should the program be giving us?
    set expectedStatus = `cat ${resultDir}/${test}.status`
    if ($testStatus != $expectedStatus) then
	echo "TEST ${test}: bad status"
	echo "** Expected return code: $expectedStatus"
	echo "** Got return code     : $testStatus"
	@ fail = $fail + 1
    endif

    if ($fail != 0) then
	echo "TEST ${test}: FAILED"
	@ FAIL = $FAIL + 1
    else
	echo "TEST ${test}: PASSED"
	@ PASS = $PASS + 1
	set TOTAL = `echo "$TOTAL + $weights[$INDEX]" | bc -l`
    endif

    # clean up...
    # rm -f ${tmpFile}.*
    # rm -f ${resultDir}/fileout
    echo ""
end

if ($#argv != 1) then
    echo "Summary:"
    echo "$PASS test(s) passed."
    echo "Total (out of 100)"
    echo "$TOTAL"
endif


