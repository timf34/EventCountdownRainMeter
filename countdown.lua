-- Hardcoded target date
local targetDate = os.time({
    year = 2025,
    month = 3,
    day = 15,
    hour = 0,
    min = 0,
    sec = 0
})

function Initialize()
    print("Target Date Initialized: " .. os.date("%Y-%m-%d %H:%M:%S", targetDate))
end

function Update()
    local currentTime = os.time()
    local difference = targetDate - currentTime
    
    if difference < 0 then
        return "Countdown finished!"
    end

    local days = math.floor(difference / (24 * 60 * 60))
    difference = difference % (24 * 60 * 60)

    local hours = math.floor(difference / (60 * 60))
    difference = difference % (60 * 60)

    local minutes = math.floor(difference / 60)
    
    -- Return the formatted string directly
    return "Days: " .. days .. ", Hours: " .. hours .. ", Minutes: " .. minutes
end