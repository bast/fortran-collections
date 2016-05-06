module collections

    use, intrinsic :: iso_c_binding, only: c_ptr

    implicit none

    public vector_double
    public vector_int

    private

    type vector
        type(c_ptr), private :: context
        integer, private :: l
        contains
        procedure :: init
        procedure :: clear
        procedure :: length
        procedure :: delete
    end type

    type, extends(vector) :: vector_double
        contains
        procedure :: push => push_double
        procedure :: pop => pop_double
        procedure :: at => at_double
    end type

    type, extends(vector) :: vector_int
        contains
        procedure :: push => push_int
        procedure :: pop => pop_int
        procedure :: at => at_int
    end type

contains

    subroutine init(v)
        interface vector_init
            function vector_init() result(context) bind (c)
                import :: c_ptr
                type(c_ptr) :: context
            end function
        end interface
        class(vector) :: v
        v%context = vector_init()
        v%l = 0
    end subroutine

    subroutine clear(v)
        interface vector_clear
            subroutine vector_clear(context) bind (c)
                import :: c_ptr
                type(c_ptr), value :: context
            end subroutine
        end interface
        class(vector) :: v
        call vector_clear(v%context)
        v%l = 0
    end subroutine

    function length(v) result(n)
        class(vector) :: v
        integer :: n
        n = v%l
    end function

    subroutine delete(v)
        interface vector_delete
            subroutine vector_delete(context) bind (c)
                import :: c_ptr
                type(c_ptr), value :: context
            end subroutine
        end interface
        class(vector) :: v
        call vector_delete(v%context)
        v%l = 0
    end subroutine

    subroutine push_double(v, d)
        use, intrinsic :: iso_c_binding, only: c_double
        interface vector_push
            subroutine vector_push_double(context, d) bind (c)
                import :: c_ptr, c_double
                type(c_ptr), value :: context
                real(c_double), value, intent(in) :: d
            end subroutine
        end interface
        class(vector_double) :: v
        real(c_double) :: d
        call vector_push(v%context, d)
        v%l = v%l + 1
    end subroutine

    subroutine push_int(v, i)
        use, intrinsic :: iso_c_binding, only: c_int
        interface vector_push
            subroutine vector_push_int(context, i) bind (c)
                import :: c_ptr, c_int
                type(c_ptr), value :: context
                integer(c_int), value, intent(in) :: i
            end subroutine
        end interface
        class(vector_int) :: v
        integer(c_int) :: i
        call vector_push(v%context, i)
        v%l = v%l + 1
    end subroutine

    function pop_double(v) result(d)
        use, intrinsic :: iso_c_binding, only: c_double
        interface vector_pop
            function vector_pop_double(context) result(d) bind (c)
                import :: c_ptr, c_double
                type(c_ptr), value, intent(in) :: context
                real(c_double) :: d
            end function
        end interface
        class(vector_double) :: v
        real(c_double) :: d
        d = vector_pop(v%context)
        v%l = v%l - 1
    end function

    function pop_int(v) result(i)
        use, intrinsic :: iso_c_binding, only: c_int
        interface vector_pop
            function vector_pop_int(context) result(i) bind (c)
                import :: c_ptr, c_int
                type(c_ptr), value, intent(in) :: context
                integer(c_int) :: i
            end function
        end interface
        class(vector_int) :: v
        integer(c_int) :: i
        i = vector_pop(v%context)
        v%l = v%l - 1
    end function

    function at_double(v, i) result(d)
        use, intrinsic :: iso_c_binding, only: c_double, c_int
        interface vector_at
            function vector_at_double(context, i) result(d) bind (c)
                import :: c_ptr, c_int, c_double
                type(c_ptr), value, intent(in) :: context
                integer(c_int), value, intent(in) :: i
                real(c_double) :: d
            end function
        end interface
        class(vector_double) :: v
        integer(c_int), value, intent(in) :: i
        real(c_double) :: d
        d = vector_at(v%context, i)
    end function

    function at_int(v, i) result(j)
        use, intrinsic :: iso_c_binding, only: c_int
        interface vector_at
            function vector_at_int(context, i) result(j) bind (c)
                import :: c_ptr, c_int
                type(c_ptr), value, intent(in) :: context
                integer(c_int), value, intent(in) :: i
                integer(c_int) :: j
            end function
        end interface
        class(vector_int) :: v
        integer(c_int), value, intent(in) :: i
        integer(c_int) :: j
        j = vector_at(v%context, i)
    end function

end module
