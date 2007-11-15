using System;
using System.Collections;

public class Person
{
  public Person(string fName, string lName)
  { this.firstName = fName;
    this.lastName = lName;
  }

  public string firstName, lastName;

  public override string ToString()
  { return firstName + " " + lastName; }
}

public class People : IEnumerable, IEnumerator
{
  private Person[] _people;

  public People(Person[] pArray)
  { _people = new Person[pArray.Length];
    for (int i = 0; i < pArray.Length; i++)
    { _people[i] = pArray[i]; }
  }

  // 实现 IEnumerable, 返回 IEnumerator
  public IEnumerator GetEnumerator()
  {   return this;  }

  // 实现 IEnumerator
  int position = -1;

  public bool MoveNext()
  { position++;
    return (position < _people.Length);
  }

  public void Reset()
  { position = -1;  }

  public object Current    // 返回当前的对象
  { get {
      try  {  return _people[position];  }
      catch (IndexOutOfRangeException)
      {  throw new InvalidOperationException();  }
    }
  }
}

class App
{
  static void Main()
  {
    Person[] peopleArray = new Person[3]
      {
	new Person("John", "Smith"),
	new Person("Jim", "Johnson"),
	new Person("Sue", "Rabon"),
      };

    People peopleList = new People(peopleArray);
    foreach (Person p in peopleList)
      Console.WriteLine(p);
  }
}
