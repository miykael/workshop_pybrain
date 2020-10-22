say "Python Basics"

say "Python is a high-level language"
show "Python is a high-level language"
run "text='hello world'"
run "print(text)"
run "'world' in text"

say "Modules & Help"
show "Modules & Help"
run "import numpy as np
np.mean?"
run "q"

say "Variable assignment and variable type"
show "Variable assignment and variable type"
run "text = 'Frankfurt'  # Type string"
run "number1 = 5         # Type integer"
run "number2 = 5.0       # Type float"
run "number1 == number2  # Type boolean"

say "Important: Indexing beginns at '0'"
show "Important: Indexing beginns at '0'"
run "my_list = ['one', 'two', 'three', 'four']"
run "my_list[1]"
run "my_list[0]"

say "Strings and list slicing"
show "Strings and list slicing"
run "'Hello World'[6::2]"

say "Lists, Tuples, Dictionaries"
show "Lists, Tuples, Dictionaries"
run "a_list = [1, 3, 5, 7, 10]  # content can be changed"
run "a_list[0] = -99"
run "a_list"
run "a_tuple = (1, 3, 5, 7, 10) # content cannot be changed"
run "a_tuple[0] = -99"
run "a_dict = {'name': 'michael',
          'hobbies': ['chocolat', 'programming', 24]}
"
run "a_dict['hobbies'][1]"

say "List comprehension"
show "List comprehension"
run "[i**2 for i in range(5)]"

say "Indentation, Functions & Control Flow"
show "Indentation, Functions & Control Flow"
run "\"\"\"
def square_positive_odd_number(number):
    if number % 2 != 0 and number > 0:
        answer = 'The square of your number is: '
        answer += str(number**2)
    elif number < 0:
        answer = 'Your number is negative'
    else:
        answer = 'Your number is positive but even'
    return answer
\"\"\""
run "square_positive_odd_number(11)"
run "square_positive_odd_number(16)"

say "Loops (for & while) and breaks"
show "Loops (for & while) and breaks"
run "\"\"\"
for i in range(-5, 20):
    response = square_positive_odd_number(i)
    print(i, response)
    if i >= 10:
      break
\"\"\""
