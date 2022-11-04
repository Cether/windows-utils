@echo off
goto check_Permissions

:check_Permissions
	echo Administrative permissions required. Detecting permissions...
	
	net session >nul 2>&1
	if %errorLevel% == 0 (
		echo Success: Administrative permissions confirmed.
		::here i need to ask if they want to run a health scan or check memory
	) else (
		echo Failure: Current permissions inadequate. Please run as Administrator.
		goto pause_Forever
	)

:scan_Health
	sfc /scannow
	echo Scan one complete, now scanning health.

	dism /Online /Cleanup-image /Scanhealth
	echo Scan two complete, now checking health.

	dism /Online /Cleanup-Image /CheckHealth
	echo Scan three complete, now restoring health.

	dism /Online /Cleanup-image /Restorehealth
	echo Scans completed, you can close this window now.

	goto pause_Forever

:check_Memory
	::need to double check to see if this is the right cmd
	mdsched.exe
	exit /b

:pause_Forever
	pause >nul