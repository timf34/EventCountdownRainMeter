-- countdown.lua

-- Declare targetDate as a global variable within the Lua script
local targetDate = nil

function Initialize()
    -- Fetch the TargetDate from global variables
    local targetDateStr = SKIN:GetVariable("TargetDate")

    -- Log the raw target date string
    print("Raw TargetDate: " .. (targetDateStr or "nil"))

    -- Verify that TargetDate is fetched correctly
    if not targetDateStr then
        print("Error: TargetDate variable is not defined!")
        targetDate = nil
        return
    end

    -- Extract components from the TargetDate string
    local year, month, day, hour, min, sec = string.match(targetDateStr, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

    -- Verify extraction
    if not year or not month or not day or not hour or not min or not sec then
        print("Error: TargetDate format invalid! Expected format: YYYY-MM-DD HH:MM:SS")
        targetDate = nil
        return
    end

    -- Convert to time object
    targetDate = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    })

    -- Log initialized target date
    if targetDate then
        print("Target Date Initialized: " .. os.date("%Y-%m-%d %H:%M:%S", targetDate))
    else
        print("Error: Failed to initialize target date!")
    end
end

function Update()
    if not targetDate then
        print("Error: targetDate is nil!")
        return 0, 0, 0
    end

    local currentTime = os.time()
    local difference = targetDate - currentTime

    -- Log current time and difference
    print("Current Time: " .. os.date("%Y-%m-%d %H:%M:%S", currentTime))
    print("Time Difference: " .. difference .. " seconds")

    if difference < 0 then
        return 0, 0, 0
    end

    local days = math.floor(difference / (24 * 60 * 60))
    difference = difference % (24 * 60 * 60)

    local hours = math.floor(difference / (60 * 60))
    difference = difference % (60 * 60)

    local minutes = math.floor(difference / 60)

    return days, hours, minutes
end

function GetDays()
    local days, _, _ = Update()
    return days
end

function GetHours()
    local _, hours, _ = Update()
    return hours
end

function GetMinutes()
    local _, _, minutes = Update()
    return minutes
end
