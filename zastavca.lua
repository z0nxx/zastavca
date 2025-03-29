local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Создание ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false

-- Основной Frame (400x400)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, -0.5, -200)  -- Начинает за пределами экрана
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 31, 35)  -- Темный фон
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

-- Белый контур
local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = mainFrame
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(255, 255, 255)

-- Скругленные углы
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Надпись "z0nxx hub" (центрирована)
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 100)
title.Position = UDim2.new(0, 0, 0, 100)  -- Чуть ниже
title.BackgroundTransparency = 1
title.Text = "z0nxx hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 72
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Center  -- Центрируем текст

-- Надпись "V 2" (центрирована)
local versionLabel = Instance.new("TextLabel")
versionLabel.Parent = mainFrame
versionLabel.Size = UDim2.new(1, 0, 0, 50)
versionLabel.Position = UDim2.new(0, 0, 0, 200)  -- Ниже "z0nxx hub"
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "V 2"
versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
versionLabel.Font = Enum.Font.GothamBlack
versionLabel.TextSize = 36
versionLabel.TextStrokeTransparency = 0.8
versionLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
versionLabel.TextXAlignment = Enum.TextXAlignment.Center  -- Центрируем текст

-- Анимация переливания цвета для обеих надписей
local function animateLabels()
    while true do
        for i = 0, 1, 0.01 do
            local color = Color3.fromRGB(255 * i, 255 * i, 255 * i)
            title.TextColor3 = color
            versionLabel.TextColor3 = color
            wait(0.01)
        end
        for i = 1, 0, -0.01 do
            local color = Color3.fromRGB(255 * i, 255 * i, 255 * i)
            title.TextColor3 = color
            versionLabel.TextColor3 = color
            wait(0.01)
        end
    end
end
spawn(animateLabels)

-- Кнопка "Run Script"
local runButton = Instance.new("TextButton")
runButton.Parent = mainFrame
runButton.Size = UDim2.new(0, 150, 0, 50)
runButton.Position = UDim2.new(0.5, -75, 0, 300)
runButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
runButton.Text = "Run Script"
runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
runButton.Font = Enum.Font.SourceSansBold
runButton.TextSize = 24
runButton.BorderSizePixel = 0
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = runButton

-- Текст загрузки
local progressLabel = Instance.new("TextLabel")
progressLabel.Parent = mainFrame
progressLabel.Size = UDim2.new(1, 0, 0, 50)
progressLabel.Position = UDim2.new(0, 0, 0, 250)  -- Ниже
progressLabel.BackgroundTransparency = 1
progressLabel.Text = ""
progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
progressLabel.Font = Enum.Font.SourceSans
progressLabel.TextSize = 32
progressLabel.TextXAlignment = Enum.TextXAlignment.Center
progressLabel.Visible = false

-- Надпись "Access" (перемещена ниже)
local accessLabel = Instance.new("TextLabel")
accessLabel.Parent = mainFrame
accessLabel.Size = UDim2.new(1, 0, 0, 100)
accessLabel.Position = UDim2.new(0, 0, 0, 250)  -- Ещё ниже, чем было
accessLabel.BackgroundTransparency = 1
accessLabel.Text = "Access"
accessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
accessLabel.Font = Enum.Font.GothamBlack
accessLabel.TextSize = 64
accessLabel.TextXAlignment = Enum.TextXAlignment.Center
accessLabel.Visible = false

-- Анимация появления GUI
local function showGUI()
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local frameTween = TweenService:Create(mainFrame, tweenInfo, {
        Position = UDim2.new(0.5, -200, 0.5, -200)
    })
    frameTween:Play()
end
showGUI()

-- Обработка нажатия на кнопку
runButton.MouseButton1Click:Connect(function()
    runButton.Visible = false
    progressLabel.Visible = true
    
    -- Анимация загрузки
    local totalTime = 5
    local steps = 100
    local stepTime = totalTime / steps
    for i = 0, steps do
        local percent = math.floor((i / steps) * 100)
        local filled = math.floor((i / steps) * 10)
        local empty = 10 - filled
        local progressText = string.rep("⬛", filled) .. string.rep("⬜", empty) .. " " .. percent .. "%"
        progressLabel.Text = progressText
        wait(stepTime)
    end
    
    -- Исчезновение прогресса
    local progressFade = TweenService:Create(progressLabel, TweenInfo.new(0.5), {TextTransparency = 1})
    progressFade:Play()
    progressFade.Completed:Connect(function()
        progressLabel.Visible = false
        accessLabel.Visible = true
        -- Появление "Access"
        local accessFade = TweenService:Create(accessLabel, TweenInfo.new(0.5), {TextTransparency = 0})
        accessFade:Play()
        wait(1)
        
        -- Закрытие GUI
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local frameTween = TweenService:Create(mainFrame, tweenInfo, {
            Position = UDim2.new(0.5, -200, 1.5, 0)
        })
        frameTween:Play()
        frameTween.Completed:Connect(function()
            screenGui:Destroy()
            -- Запуск скрипта отправки сообщений
            local messages = {
                "✅ z0nxx hub ✅",
                "✅ z0nxx hub ✅",
                "✅ z0nxx hub ✅",
                "✅ z0nxx hub ✅",
                "✅ z0nxx hub ✅"
            }
            local function sendMessage(message)
                if game:GetService('TextChatService').ChatVersion == Enum.ChatVersion.LegacyChatService then
                    local chatEvents = game:GetService('ReplicatedStorage'):WaitForChild('DefaultChatSystemChatEvents')
                    local sayMessage = chatEvents:WaitForChild('SayMessageRequest')
                    sayMessage:FireServer(message, 'All')
                else
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
                end
            end
            for i, msg in pairs(messages) do
                sendMessage(msg)
                print("Отправлено: " .. msg)
                wait(0.5)
            end
        end)
    end)
end)
