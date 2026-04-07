setlocal EnableExtensions EnableDelayedExpansion
@echo on

if "%module_abi%"=="gfortran" (
meson setup _build %MESON_ARGS% --prefix=%LIBRARY_PREFIX%
if errorlevel 1 exit 1

meson compile -C _build
if errorlevel 1 exit 1

meson test -C _build --no-rebuild --print-errorlogs
if errorlevel 1 exit 1

meson install -C _build --no-rebuild
if errorlevel 1 exit 1
) else (
if "%module_abi%"=="ifx" (
set "FFLAGS=!FFLAGS! -I%BUILD_PREFIX%\opt\compiler\include -I%BUILD_PREFIX%\opt\compiler\include\intel64"
)
cmake -G Ninja -B _build %CMAKE_ARGS% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% -DBUILD_SHARED_LIBS=ON -DTESTDRIVE_WITH_XDP=OFF -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON
if errorlevel 1 exit 1

cmake --build _build
if errorlevel 1 exit 1

cmake --install _build
if errorlevel 1 exit 1
)
