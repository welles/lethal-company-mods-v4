# TypeLoadExceptionFixer

Fixes the following issues:

- `Assembly.GetTypes` unexpectedly throwing if there are unloadable types
- Unity's Input system initialization exploding if there are unloadable types
