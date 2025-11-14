

local Bindable = Instance.new("BindableEvent",script)
local ReturnBindable = Instance.new("BindableEvent",script)
local Process = Instance.new("BindableEvent",script)

local RunService = game:GetService("RunService")

local NUM_OF_ACTORS = 12
local DEFAULT_WORKERS = 3

local Actors = {}

local Finding = false

local function createActors()
    for i = 1,NUM_OF_ACTORS do
        local Actor = script.Actor:Clone()
        Actor.Name = "Actor-"..i
        Actor.Parent = script
        Actor.Main.Disabled = false
        Actors[i] = Actor
        task.delay(.5,function()
            Actor:SendMessage("init",Bindable,ReturnBindable)
        end)
    end
end

local function runTest()
    Finding = true
    local times = {}
    local firstReturned 
    local connection:RBXScriptConnection = ReturnBindable.Event:Connect(function(time)
        table.insert(times,time)
        if firstReturned == nil then
            firstReturned = time
        end
    end)
    task.spawn(function()
        task.wait(1) 
        Bindable:Fire()
    end)

    task.wait(4)

    local count = 0
    for _, time in times do
        if math.abs(time - firstReturned) <= 1/34 then
            count = count + 1
        end
    end
    if count == 0 then
        warn(`No Workers Detected! Using Default Value [{DEFAULT_WORKERS}]`)
        count = DEFAULT_WORKERS
    else
        print("Detected", count,"Workers!")
    end

    script:SetAttribute("Workers",count)
    connection:Disconnect()
    Process:Fire(count)
    Finding = false
    
end

return function()
    if Finding then
        return Process.Event:Wait()
    end
    local Cached = script:GetAttribute("Workers")
    if Cached then
        return Cached
    end
    createActors()
    task.wait(1)
    runTest()
    for i,v in Actors do
        v:Destroy()
    end
    table.clear(Actors)

    return Cached
end
