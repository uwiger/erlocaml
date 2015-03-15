# Introduction #

Ocamerl is an attempt to implement an Erlang node completely in Ocaml:
  * offer a simple mapping of basic Erlang term in Ocaml;
  * maintains connection to EPMD;
  * maintains connections with other Erlang nodes;
  * enable to send/receive Erlang messages from processes on any nodes using the "Erlang external term format";


# Build #

Use a standard Makefile to run _ocamlbuild_.

Require:
  * ocaml 3.10.2
  * ocamlfind/findlib 1.2.1
  * [OUnit 1.0.2](http://www.xs4all.nl/~mmzeeman/ocaml) (optional)

Known to run on:
  * GNU/Linux Ubuntu 7.10, 8.04


# Examples #
  * the ex folder contains few ocaml node examples; those are used by shell script in test folder.
  * some info can be found [on this blog](http://khigia.wordpress.com/category/erlocaml)
  * [eocarve](http://github.com/khigia/eocarve/tree/master) is a project using ocamerl to interface a seamcarving library