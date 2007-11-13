using System;

public class LinkedTest 
{
  public static void Main() {
    LinkedList ll = new LinkedList();

    ll.insertAtHead(new LinkableInteger(1));
    ll.insertAtHead(new LinkableInteger(2));
    ll.insertAtHead(new LinkableInteger(3));
    ll.insertAtHead(new LinkableInteger(4));
    ll.insertAtTail(new LinkableInteger(5));
    ll.insertAtTail(new LinkableInteger(6));

    Console.WriteLine(ll.removeFromHead());
    Console.WriteLine(ll.removeFromTail());
    ll.remove(new LinkableInteger(2));

    for(Linkable l = ll.Head; l != null; l = l.Next)
      Console.WriteLine(l);
  }
}

interface Linkable 
{
  Linkable Next { get; set; }
}

class LinkedList 
{
  Linkable head;

  public Linkable Head { get { return head; } }

  public void insertAtHead(Linkable node) {
    node.Next = head;
    head = node;
  }

  public void insertAtTail(Linkable node) {
    if (head == null) head = node;
    else {
      Linkable p, q;
      for(p = head; (q = p.Next) != null; p = q);
      p.Next = node;
    }
  }

  public Linkable removeFromHead() {
    Linkable node = head;

    if (node != null) {
      head = node.Next;
      node.Next = null;
    }
    return node;
  }

  public Linkable removeFromTail() {
    if (head == null) return null;
    Linkable p = head, q = null, next = head.Next;
    if (next == null) {
      head = null;
      return p;
    }
    while((next = p.Next) != null) {
      q = p;
      p = next;
    }
    q.Next = null;
    return p;
  }

  public void remove(Linkable node) {
    if (head == null) return;
    if (node.Equals(head)) {
      head = head.Next;
      return;
    }
    Linkable p = head, q = null;
    while((q = p.Next) != null) {
      if (node.Equals(q)) {
	p.Next = q.Next;
	return;
      }
      p = q;
    }
  }
} // end of LinkedList

class LinkableInteger : Linkable 
{
  int i;
  Linkable next;

  public LinkableInteger(int i) { this.i = i; }

  public Linkable Next { 
    get { return next; } 
    set { next = value; } }

  public new string ToString() { return i + ""; }
  public new bool Equals(object o) {
    if (this == o) return true;
    if (!(o is LinkableInteger)) return false;
    if (((LinkableInteger)o).i == this.i) return true;
    return false;
  }
} // end of LinkableInteger


////////////////////////////////////////////////////////

class Circle
{
  double r = 1.0;
  static double pi = 3.14159;
  public double Radius      { get {return r; } }

  public Circle()           { this.r = 1.0; }
  public Circle(double r)   { this.r = r; }
  public double Area()      { return pi * r * r; }
  public double Perimeter() { return 2 * pi * r; }
}

class LinkableCircle : Circle, Linkable 
{
  LinkableCircle (double r):base(r)  {}

  Linkable next;
  public Linkable Next { 
    get { return next; }
    set { next = value; } 
  }
}
