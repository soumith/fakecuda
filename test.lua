require 'torch'
require 'nn'

use_cpu = true
require('fakecuda').init(use_cpu)

a=torch.randn(10)

ac = a:cuda()

b = nn.SpatialConvolution(3,16,5,5)
b:cuda()

cutorch.synchronize()

torch.CudaTensor(10,30,40)
