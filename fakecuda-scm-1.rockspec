package = "fakecuda"
version = "scm-1"

source = {
   url = "git://github.com/soumith/fakecuda.git"
}

description = {
   summary = "A cuda/cutorch faker to lazily not change your code all the time for CPU",
   detailed = [[
   ]],
   homepage = "https://github.com/soumith/fakecuda",
   license = "BSD"
}

dependencies = {
   "lua >= 5.1",
}

build = {
   type = "builtin",
   modules = {
      ["fakecuda.init"] = "init.lua",
   }      
}
