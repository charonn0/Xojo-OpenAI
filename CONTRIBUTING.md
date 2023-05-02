# How to contribute to this project

## File a bug report or feature request
If you discover a bug or think of a neat new feature, you can open a new issue. Please describe the bug and how to reproduce it, or your feature idea, as completely as possible.

## Submitting code
You may submit code by making a Pull Request against the `master` branch. Please avoid submitting PR's that include extraneous changes inserted by the IDE.

### License and permissions
By submitting a pull request or otherwise supplying source code to this project you are agreeing to license the source code in perpetuity under the terms of the MIT license, and you are warranting that you have the authority to do so.

### Code Style
When contributing code please make an effort to conform to these guidelines:
1. All code must be compatible with REALstudio 2011r4.3, or use conditional compilation around language features introduced after that version.
    1. Only `Dim` or `Static` may be used to declare a local variable. `Var` is verboten.

1. A subclass implements a superset of the parent class functionality, not a subset. [Refused Bequests](https://sourcemaking.com/refactoring/smells/refused-bequest) are forbidden.

1. Variable, class, and method names should be unabbreviated, correctly-spelled, and given in [PascalCase](https://en.wikipedia.org/wiki/PascalCase). Prefixes and suffixes (e.g. Hungarian notation) are not allowed. Underscores and non-ASCII characters should be avoided.

1. Names of constants should be in CONSTANT_CASE: all uppercase letters, with words separated by underscores. 

1. If a method performs an action then the method name should include the action name; methods themselves should be written such that their entire purpose can be summed up in one or two words (i.e. the method name) plus the names and types of the parameters and return value. This does not mean that names should be phrases describing the method: `CreateOrOpenFileAndMoveToEnd(Path As String)` is bad ; `OpenFile(Path As String, Create As Boolean, Position As Integer)` is good.

1. All classes have at least one Constructor method (which need not be Public.) `Foo.Constructor()` always creates a brand new instance of `Foo`. `Foo.Constructor(Foo)` always creates a new instance of `Foo` that duplicates the characteristics of the instance of `Foo` that is passed as an argument. Any other Constructors create a new instance of `Foo` using the characteristics specified by the arguments.

1. The visibility of any method, variable, constant, etc. shall default to `private`. It can only be promoted to `protected` if you have a reason, and to `public` if your reason is good. `Global` scope requires a damned good reason. Destructor methods are always private.

1. Introspection shall not be used to violate lexical scope, for example modifying a private variable from outside its class. In general do not use Introspection when alternatives exist.

1. If a class has many Constructor methods, you should consider changing some of them into shared methods with more meaningful names. 

1. All variables, etc. should organized in the narrowest possible _logical_ scope. For example, a method that operates on a class should be defined in that class rather than in some "helpers" module.

1.  "Helpers" modules are forbidden except as private submodules (i.e., inaccessible to users.)

1. `Operator_Convert() As PRIMITIVE` is forbidden. "PRIMITIVE" means any type that is not a class, array, structure, or enum.

1. `Operator_Lookup()` is forbidden. 

1. Use standard RB/Xojo capitalization and formatting. Select a block of code in the IDE, right click on it, and then choose "Standardize format".

1. The loop variable in a `For` loop should be declared within the `For` statement unless the variable should exist outside of the loop's scope. 

1. The `IsA` operator shall be used only to determine the type of Variants and WeakRefs. It may not be used to distinguish a subclass from a superclass. The `Is` operator shall be used only to test for `Nil` in an `Operator_Compare` method.

1. The `RaiseEvent` keyword is mandatory, even when not needed to disambiguate an event from a method of the same name.

1. External methods (AKA "declares") should be private members of a module. Inline declares are discouraged.

1. Methods that deallocate a resource should be idempotent, meaning that calling them twice (or more) on the same resource has exactly the same effect as calling them once. This includes `Destructor` methods, as well as any intermediate deallocation methods (e.g. `Close()`).

1. The `AddressOf` operator should be used only to refer to static methods. Use the `WeakAddressOf` operator to refer to virtual methods.

1. Avoid type casting. If you must cast a value then use the `CType` operator to convert it.
