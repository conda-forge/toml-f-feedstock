setlocal EnableExtensions EnableDelayedExpansion
@echo on

set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig;%BUILD_PREFIX%\Library\lib\pkgconfig"

meson setup _build --prefix=%LIBRARY_PREFIX% -Dfortran_args="-fvisibility=default" -Dfortran_link_args="-Wl,-export-all-symbols"
if errorlevel 1 exit 1

meson compile -C _build
if errorlevel 1 exit 1

meson test -C _build --no-rebuild --print-errorlogs
if errorlevel 1 exit 1

meson install -C _build --no-rebuild
if errorlevel 1 exit 1
