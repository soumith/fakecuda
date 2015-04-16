require 'torch'

local fake = {}

function fake.init(cpu)
   if not cpu then return end
   rawset(torch.getmetatable('torch.DoubleTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.FloatTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.ByteTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.CharTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.IntTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.ShortTensor'), 'cuda', function() end)
   rawset(torch.getmetatable('torch.LongTensor'), 'cuda', function() end)
   do
      local c = torch.class('torch.CudaTensor')
      function c:__init()
	 print('WARNING: fakecuda does not recommend that you to specify: ' .. 
		  'x = torch.CudaTensor().' ..
		  'The side-effects are not easy to solve with fakecuda, and you have to put a' ..
		  ' manual guard around this')
	 return self
      end
   end
   do
      local ft = torch.getmetatable('torch.FloatTensor')
      local c = torch.getmetatable('torch.CudaTensor')
      for k,v in pairs(ft) do
	 -- horrible hacks with possibly bad side-effects.
	 -- however, ever entering this code means you read the warning generated above.
	 if k:sub(1,1) ~= '_' then
	    c[k] = v
	 end
      end
   end
   local ok = pcall(require, 'cutorch')
   if not ok then
      cutorch = {} -- yes, actually setting it to global, that's how cutorch loads.
      cutorch.__index = function() return function() end end
      setmetatable(cutorch, cutorch)
   end
   local ok = pcall(require, 'nn')
   if ok then
      rawset(torch.getmetatable('nn.Module'), 'cuda', function() end)
   end
end


return fake
