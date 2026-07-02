:: Build
mkdir build
cd build

@REM Link.exe is using the wrong zlib on win-32 because the regress test exe is the only item
@REM that needs zlib. Therefore zlib is not listed in the host section of the requirements.
@REM This exe is currently not a part of our test process, so skip compiling the those items.
@REM If in the future we want to enable them, we will need to add zlib as a host requirement
@REM only and ignore its run_exports since it is only a build / test time requirement.
@REM https://github.com/libevent/libevent/blob/release-2.1.12-stable/CMakeLists.txt#L873-L883

cmake -G "NMake Makefiles" ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
         -DEVENT__DISABLE_TESTS=ON ^
         %SRC_DIR%
if errorlevel 1 exit 1

:: Install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
