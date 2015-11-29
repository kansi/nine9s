import os
import sys

VSN_OLD = "0.1.0"
VSN_NEW = "0.2.0"


print("Upgrading from ", VSN_OLD, " to ", VSN_NEW, "(press enter to continue) ", end="")
input()

os.system("cp apps/nine9s/src/nine9s.appup.src  _build/default/lib/nine9s/ebin/nine9s.appup")
input()

# build the new release
os.system("rebar3 compile")
os.system("rebar3 release")

# generate relup w.r.t to the previous release
os.system("rebar3 relup -n nine9s -v " + VSN_NEW + " -u " + VSN_OLD)

# genereate tar file of the new release
os.system("rebar3 tar -n nine9s -v " + VSN_NEW)

# move the generated tar file to destination folder
os.system("mv _build/default/rel/nine9s/nine9s-" +
          VSN_NEW + ".tar.gz _build/default/rel/nine9s/releases/" + VSN_NEW +"/nine9s.tar.gz")

# upgrade to the new release
os.system("_build/default/rel/nine9s/bin/nine9s-" + VSN_OLD + " upgrade " + VSN_NEW)

