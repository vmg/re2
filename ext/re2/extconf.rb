# re2 (http://github.com/mudge/re2)
# Ruby bindings to re2, an "efficient, principled regular expression library"
#
# Copyright (c) 2010-2012, Paul Mucur (http://mudge.name)
# Released under the BSD Licence, please see LICENSE.txt

require 'mkmf'

def sys(cmd)
  puts " -- #{cmd}"
  unless ret = xsystem(cmd)
    raise "ERROR: '#{cmd}' failed"
  end
  ret
end

if !(MAKE = find_executable('gmake') || find_executable('make'))
  abort "ERROR: GNU make is required to build re2."
end

CWD = File.expand_path(File.dirname(__FILE__))
RE2_DIR = File.join(CWD, '..', '..', 'vendor', 're2')

Dir.chdir(RE2_DIR) do
  sys("CXXFLAGS=\"-Wall -O3 -g -pthread -fPIC\" #{MAKE} obj/libre2.a")
end

$DEFLIBPATH.unshift("#{RE2_DIR}/obj")
$INCFLAGS << " -I#{RE2_DIR}"
$CFLAGS << " -Wall -Wextra -funroll-loops -fPIC"
$defs.push("-DHAVE_ENDPOS_ARGUMENT")

have_library("stdc++")
have_header("stdint.h")
have_func("rb_str_sublen")

unless have_library 're2'
  abort "ERROR: Failed to build re2"
end

create_makefile("re2")
