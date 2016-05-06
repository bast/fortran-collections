[![Build Status](https://travis-ci.org/bast/fortran-collections.svg?branch=master)](https://travis-ci.org/bast/fortran-collections/builds)
[![License](https://img.shields.io/badge/license-%20BSD--3-blue.svg)](../master/LICENSE)


# fortran-collections

Got tired of Fortran not having high level containers.


## API

Currently implemented types are `vector_double` and `vector_int`.

They support the methods
`init`,
`push`,
`pop`,
`at`,
`length`,
`clear`, and
`delete`.

Check out an [example](../master/test/test.f90).
