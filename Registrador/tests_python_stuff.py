# test_python_suff.py


import sys

def switch_lambdas(value):
    {
        'x': lambda: (
            print("opción x")
            ),
        'y': lambda: (
            print("opción y")
        ),
        'z': lambda: (
            print("opción z")
        )
    }.get( value, lambda: print("default") )()

def switch_return(value):
    return {
        'x': "opción x",
        'y': "opción y",
        'z': "opción z"
    }.get( value, "default" ) # default

if __name__ == "__main__":
    
    char = '0'
    
    switch_lambdas(char)
    print( switch_return(char) )

    # """
    # This program takes 3 command line arg forms:

    # 1.
    # -affirm *name*

    # 2.
    # -hello *name*

    # 3.
    # -n *number* *name*
    # """
    # # standard - load "args" list with cmd-line-args
    # args = sys.argv[1:]

    # if len(args) == 2 and args[0] == '-x':
    #     print("x " + args[1])

    # if len(args) == 2 and args[0] == '-y':
    #     print("y " + args[1])

    # if len(args) == 2 and args[0] == '-default':
    #     print("print by default. " + args[1])


