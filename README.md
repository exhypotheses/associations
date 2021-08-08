<br>

**Focus**: This repository explores _strength of association statistics_ for data science, machine learning, etc., questions 
focused on classification.  More notes upcoming.

<br>

### Required Items

Most probably an input YAML that includes:
* The URL of a CSV data file whose fields will be assessed.
* The R data type of each field in the CSV file.
* The URL of a JSON file that outlines the characteristics of the CSV file data fields; more details 
  within section [The Structure of the JSON File](#the-structure-of-the-json-file).

<br>

### The Structure of the JSON File 

This section outlines the structure of the JSON file that outlines the characteristics of the data file whose fields will be 
assessed.  Starting off with

```
dictionary = []
```

The overarching JSON object literal structure is

```shell
dictionary.append({'source': 'file name including extension',
    'properties': {'target': <the list of the target field/s>,
     'numeric': <the list of numeric fields>,      
     'categoricalFields': <the list of categorical fields>,
     'binaryCF': <the list of binary categorical fields>, 
     'polytomousCF':  <the dictionary of polytomous categorical fields>
    }})
```

Wherein a list has the form:

```shell
['item', 'item', ...]
```

Whereas, the structure of the dictionary of polytomous categorical fields is:

```shell
{
  'fieldName': <list of unique elements>, 
  'fieldName': <list of unique elements>, 
  'fieldName': <list of unique elements>, ... 
}
```

<br>

### Reference

**Notes**

* Edit the help file skeletons in 'man', possibly combining help files
  for multiple functions.
* Edit the exports in 'NAMESPACE', and add necessary imports.
* Put any C/C++/Fortran code in 'src'.
* If you have compiled code, add a useDynLib() directive to
  'NAMESPACE'.
* Run R CMD build to build the package tarball.
* Run R CMD check to check the package tarball.

Read "Writing R Extensions" for more information.

<br>
<br>
<br>
<br>