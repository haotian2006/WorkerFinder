--!optimize 2
-- put this under the actor and make sure its disabled
 
local Actor:Actor = script.Parent

Actor:BindToMessage("init", function(bindable:BindableEvent,returnBindable:BindableEvent)
    returnBindable = returnBindable

    bindable.Event:Connect(function()
        game:GetService("RunService").RenderStepped:Wait()
        task.desynchronize()
        debug.profilebegin("FindCores")
        local called = os.clock()
        while os.clock() - called < 1/30 do
            
        end
        returnBindable:Fire(called)
        debug.profileend()
    end)
    
end)





