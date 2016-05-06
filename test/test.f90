program test

    use collections, only: vector_double, vector_int

    implicit none

    type(vector_double) :: v1
    type(vector_int) :: v2

    call v1%init()
    call v1%push(1.0d0)
    call v1%push(2.0d0)
    call v1%push(3.0d0)
    call v1%push(4.0d0)
    call v1%push(5.0d0)

    call v2%init()
    call v2%push(1)
    call v2%push(2)

    call assert(v1%length() == 5)
    call assert(v1%pop() == 5.0d0)
    call assert(v1%length() == 4)
    call assert(v1%pop() == 4.0d0)
    call assert(v1%length() == 3)
    call assert(v1%at(v1%length()) == 3.0d0)

    call v1%clear()
    call assert(v1%length() == 0)

    call assert(v2%length() == 2)
    call assert(v2%pop() == 2)
    call assert(v2%pop() == 1)
    call assert(v2%length() == 0)

    call v1%delete()
    call v2%delete()

    call v1%init()
    call v1%push(5.0d0)
    call assert(v1%length() == 1)
    call assert(v1%at(v1%length()) == 5.0d0)
    call v1%delete()

contains

    subroutine assert(condition)
        logical, intent(in) :: condition
        if (.not. condition) stop 1
    end subroutine

end program
