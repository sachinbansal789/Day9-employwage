#!/bin/bash -x

isPartTime=1;
isFullTIME=2;
MAX_HRS_IN_MONTH=10;
EMP_RATE_PER_HR=20;
NUM_WORKING_DAYS=20;

# VARIABLES
totalEmpHrs=0;
totalWorkingDays=0;

declare -A dailyWages
function getEmpWage(){

	local empWage=$1
	empHours=$(( $empWage * $EMP_RATE_PER_HR ))
	echo $empHours
}

function getWorkHours(){
	local empCheck=$1
	case $empCheck in
		$isFullTIME)
			empHours=8
			;;
		$isPartTIME)
			empHours=4
			;;
		*)
			empHours=0
			;;
	esac
	echo $empHours
}

while [[ $totalEmpHrs -lt $MAX_HRS_IN_MONTH &&
	$totalWorkingDays -lt $NUM_WORKING_DAYS ]]
do
	((totalWorkingDays++))
	empCheck=$((RANDOM%3))
	empHours="$( getWorkHours $empCheck )"
	totalEmpHrs=$(( $totalEmpHrs + $empHours ))
	dailyWages["day "$totalWorkingDays]=$(getEmpWage $empHours)
done
totalSalary=$(( $totalEmpHrs * $EMP_RATE_PER_HR ))
echo ${dailyWages[@]}
echo ${!dailyWages[@]}
