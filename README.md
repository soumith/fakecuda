#fakecuda

***A convenient package for the lazy torch programmer to leave all your :cuda() calls as-is when running on CPU.***

###Usage:
```lua
require('fakecuda').init(true) -- true is for using fakecuda, false or no-argument wont initialize fakecuda.
```

###Installation:
```bash
luarocks install https://raw.githubusercontent.com/soumith/fakecuda/master/fakecuda-scm-1.rockspec
```

###Example:

Let's say your code is sprinkled all over like this:
```lua
require 'torch'
require 'nn'

use_cpu = true
require('fakecuda').init(use_cpu)

a=torch.randn(10)

ac = a:cuda()

b = nn.SpatialConvolution(3,16,5,5)
b:cuda()

cutorch.synchronize()
```


These are all nicely ignored with fakecuda.

The only thing that has to be tread carefully is if you have calls like:
```lua
a=torch.CudaTensor(3,4)
```

explicitly initializing a torch.CudaTensor is in murky territory where side-effects are not easy to ignore.