## Limit Execution Time

Sweet. This makes things much easier.

This is what works:
```python
@fork(timeout=5)
def timed_rank(E):
  return E.rank()

E = EllipticCurve([ -1/36, -1/36, 0, -1, 1 ])
timed_rank(E)
# 'NO DATA (timed out)'
```

----

I've tried a bunch of different methods for trying to limit the amount of time sage takes to calculate the rank of an elliptic curve. This is an example that takes a long time to compute:

    E = EllipticCurve([ -1/36, -1/36, 0, -1, 1 ])
    E.rank()

I've tried suggestions from

 - [stackoverflow post 1](http://stackoverflow.com/a/366763/3161979)
 - [stackoverflow post 2](http://stackoverflow.com/a/601168/3161979)
 - [filosophy blog post](https://www.filosophy.org/post/32/python_function_execution_deadlines__in_simple_examples/)

So I posted around looking for advice.

....

[William Stein responded to me on the sage-nt google group!](https://groups.google.com/forum/#!topic/sage-nt/rjurh63gV2k)

His response:

> Use either "alarm" or "fork", both of which are built into Sage.
We've had to properly solve exactly the problems you've run into a
decade ago already (with many iterations since), and make those
solutions work in the context of the very complicated Sage library
(which involves C libraries, external processes, etc.).

> Type "alarm?" or "fork?" or google the sagemath docs.

> \-\-
> William (http://wstein.org)

He went on to say that the `@fork` solution is much more reliable, because it creates a separate thread which cannot be interfered with.

> If you can use fork, it will be vastly more robust, due to how it
works.   Under the hood it makes an exact copy of your running
process, does the work in the copy process, then gets the output (as a
string via pickle), and kills that subprocess.  There is (basically)
no possibility of memory leaks, and even segfaults or other horrible
behavior will not kill your parent process.   The drawback is that it
can take slightly longer to run, only output that is relatively small
and pickleable can be returned, and pexpect interfaces lose their
state.

> William

Sweeeeeet. I wish I knew more about how the `@fork` decorator worked, and it could be useful to dig into the [parallel functionality in sage](http://doc.sagemath.org/pdf/en/reference/parallel/parallel.pdf), but for now I'm very happy with what I've got.
