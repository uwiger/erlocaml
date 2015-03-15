We've been using Erlang in commercial products for over 10 years now, and it's taken about that long to get into a position where we're considered a viable player for mission-critical product development. In order to get there, we've also been extolling the virtues of functional programming in general, and often cited Ocaml as an example of how you don't have to sacrifice low-level performance.

We feel that the ongoing paradigm shift towards multicore architectures is really helping our cause. There is much discussion about how to get all those legacy apps to work and scale on new hardware, and the advantages of functional/declarative programming are becoming more obvious.

Erlang is very strong in the area of concurrency, distribution and fault-tolerance, but fairly weak when sequential performance is of the essence (especially number crunching). When Erlang performance isn't enough, we usually jump into C-routines linked into the Erlang runtime, with all the problems associated with that. Often, instead of risking system integrity, we live with the performance we can get out of Erlang. It would be nice if we could present Ocaml as a safe (and productive!) driver environment for things like parsing text-based protocols, numerically intensive tasks, and complex sequential algorithms.

I've noticed that there have been some discussions about concurrency in Ocaml. From an Ocaml perspective, this binding could be a way to use Ocaml in distributed systems, where Erlang is used as a "systems glue" for supervision, load balancing, replication, etc.

Idea:

I'd like to explore the idea of running an Ocaml runtime in Erlang's memory space. Both languages are garbage-collected, and Erlang's linked-in driver interface allows for "drivers" that use their own threads. We could target only the multi-processor variant of Erlang, where this sort of cooperation becomes slightly easier.

For a looser connection, Erlang's distribution protocol is documented, and allows for "C-nodes" (non-Erlang nodes) to connect to an Erlang cluster over TCP. One could actually start with talking via regular pipes, using a common serialization format, and then gradually making a tighter and tigher connection.

I will make no false promises, like "if we do this, Ericsson will use it". I have no money to offer anyone, and we who have started looking at this on the erlang side have fairly little time to spend on it. Business as usual, in other words: no time, no money - just an idea that might be fun to explore.

/Ulf Wiger