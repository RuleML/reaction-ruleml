Test suites in sub-directories under the directory /schema-test-suites are intended to be processed in batch mode,
either from a platform like oXygen, or by a script.

Each test suite may contain its own README.txt file explaining what it is designed to test.
Therefore, a batch validation should skip files with the .txt extension.

Documents within the test suite should reference schemas by relative paths, so that
the development version in the working directory is called.