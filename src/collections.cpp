#include <vector>


extern "C" {
    struct vector_context_s;
    typedef struct vector_context_s vector_context_t;

    vector_context_t *vector_init();
    void vector_clear(vector_context_t *context);

    void vector_push_double(vector_context_t *context, const double d);
    void vector_push_int(vector_context_t *context, const int i);

    double vector_pop_double(vector_context_t *context);
    int vector_pop_int(vector_context_t *context);

    double vector_at_double(const vector_context_t *context, const int i);
    int vector_at_int(const vector_context_t *context, const int i);
}


#define AS_TYPE(Type, Obj) reinterpret_cast<Type *>(Obj)
#define AS_CTYPE(Type, Obj) reinterpret_cast<const Type *>(Obj)


class Vector
{
    public:

        Vector();
        ~Vector();

        void push_double(const double d);
        void push_int(const int i);

        double pop_double();
        int pop_int();

        double at_double(const int i) const;
        int at_int(const int i) const;

    private:

        Vector(const Vector &rhs);            // not implemented
        Vector &operator=(const Vector &rhs); // not implemented

        std::vector<double> v_double;
        std::vector<int> v_int;
};


vector_context_t *vector_init()
{
    return AS_TYPE(vector_context_t, new Vector());
}
Vector::Vector()
{
}


void vector_clear(vector_context_t *context)
{
    if (!context) return;
    delete AS_TYPE(Vector, context);
}
Vector::~Vector()
{
    v_double.clear();
    v_int.clear();
}


void vector_push_double(vector_context_t *context, const double d)
{
    return AS_TYPE(Vector, context)->push_double(d);
}
void Vector::push_double(const double d)
{
    v_double.push_back(d);
}


void vector_push_int(vector_context_t *context, const int i)
{
    return AS_TYPE(Vector, context)->push_int(i);
}
void Vector::push_int(const int i)
{
    v_int.push_back(i);
}


double vector_pop_double(vector_context_t *context)
{
    return AS_TYPE(Vector, context)->pop_double();
}
double Vector::pop_double()
{
    double t = v_double.back();
    v_double.pop_back();
    return t;
}


int vector_pop_int(vector_context_t *context)
{
    return AS_TYPE(Vector, context)->pop_int();
}
int Vector::pop_int()
{
    int t = v_int.back();
    v_int.pop_back();
    return t;
}


double vector_at_double(const vector_context_t *context, const int i)
{
    return AS_CTYPE(Vector, context)->at_double(i);
}
double Vector::at_double(const int i) const
{
    return v_double.at(i - 1);
}


int vector_at_int(const vector_context_t *context, const int i)
{
    return AS_CTYPE(Vector, context)->at_int(i);
}
int Vector::at_int(const int i) const
{
    return v_int.at(i - 1);
}
