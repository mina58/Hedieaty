# Path to the emulator executable
$emulatorPath = "D:\andriod-sdks\emulator\emulator.exe"
$avdName = "Pixel_4_API_VanillaIceCream"

# Start the emulator in the background
Write-Host "Starting emulator..."
Start-Process -FilePath $emulatorPath -ArgumentList "-avd $avdName -netdelay none -netspeed full" -NoNewWindow

# Wait for the emulator to fully boot
Write-Host "Waiting for emulator to fully boot..."
do {
    Start-Sleep -Seconds 5
    $bootCompleted = & adb shell getprop sys.boot_completed
} while ($bootCompleted -ne "1")

Write-Host "Emulator is fully booted."

# Run Flutter tests
Write-Host "Running integration tests..."
flutter test integration_test > test_results.txt

# Check test results
if (Select-String -Path test_results.txt -Pattern "Some tests failed.") {
    Write-Host "Tests failed. Check test_results.txt for details."
} else {
    Write-Host "All tests passed."
}

# Optional: Shutdown the emulator after tests
Write-Host "Shutting down the emulator..."
adb -s emulator-5554 emu kill
Write-Host "Emulator shutdown complete."
