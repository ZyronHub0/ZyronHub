--! ============================================================================================================
--! TELA DE CARREGAMENTO CINEMATOGRÁFICA (VERSÃO SEM PULSO)
--! made by: aakirajs & draken13br --! MODIFICADO
--! ============================================================================================================

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- Variáveis Locais
local player = Players.LocalPlayer

-- 1. SETUP DA INTERFACE E ÁUDIO
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "SLoader_Cinematic_Final"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- Efeitos Sonoros
local soundLetterPop = Instance.new("Sound", screenGui)
soundLetterPop.SoundId = "rbxassetid://3623733749"
soundLetterPop.Volume = 0.8

local soundSuccess = Instance.new("Sound", screenGui)
soundSuccess.SoundId = "rbxassetid://17692186009"
soundSuccess.Volume = 0.7

-- Efeito de Blur
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0

-- Frame principal
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

-- Fundo
local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 1
bg.ClipsDescendants = true
bg.ZIndex = 0

-- EFEITO DE POEIRA CÓSMICA
local cosmicDustFrame = Instance.new("Frame", bg)
cosmicDustFrame.Size = UDim2.new(1, 0, 1, 0)
cosmicDustFrame.BackgroundTransparency = 1

-- Texto de Status de Carregamento
local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0.65, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
statusLabel.TextSize = 18
statusLabel.TextTransparency = 1

--! NOVO: Texto de Créditos
local creditsLabel = Instance.new("TextLabel", frame)
creditsLabel.Name = "CreditsLabel"
creditsLabel.AnchorPoint = Vector2.new(0.5, 1)
creditsLabel.Size = UDim2.new(1, 0, 0, 30)
creditsLabel.Position = UDim2.new(0.5, 0, 0.98, 0) -- Posição na parte inferior
creditsLabel.BackgroundTransparency = 1
creditsLabel.Font = Enum.Font.SourceSans
creditsLabel.RichText = true
creditsLabel.Text = 'made by: <font color="#FADF70">aakirajs & KiNight</font>'
creditsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
creditsLabel.TextSize = 16
creditsLabel.TextTransparency = 1
--! FIM DA ADIÇÃO

-- 2. LÓGICA DE ANIMAÇÃO
local word = "ZyronHub"
local letters = {}
local isAnimating = true

-- Função para animar o fundo
local function animateCosmicDust()
    for i = 1, 15 do
        task.spawn(function()
            if not isAnimating then return end
            local dust = Instance.new("ImageLabel", cosmicDustFrame)
            dust.Image = "rbxassetid://9133519848"
            dust.ImageColor3 = Color3.fromRGB(150, 180, 255)
            dust.ImageTransparency = 1
            dust.BackgroundTransparency = 1
            dust.ScaleType = Enum.ScaleType.Fit
            local size = math.random(10, 25)
            dust.Size = UDim2.fromOffset(size, size)
            dust.Position = UDim2.new(math.random(), 0, math.random(), 0)
            
            while isAnimating do
                local startPos = UDim2.new(math.random(), 0, 1.1, 0)
                local endPos = UDim2.new(startPos.X.Scale + (math.random(-20, 20)/100), 0, -0.1, 0)
                dust.Position = startPos
                
                local duration = math.random(8, 15)
                local fadeIn = TweenService:Create(dust, TweenInfo.new(duration/2, Enum.EasingStyle.Sine), {ImageTransparency = 0.8})
                local fadeOut = TweenService:Create(dust, TweenInfo.new(duration/2, Enum.EasingStyle.Sine), {ImageTransparency = 1})
                
                TweenService:Create(dust, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position = endPos}):Play()
                fadeIn:Play()
                if fadeIn.Completed then fadeIn.Completed:Wait() end
                if not isAnimating then break end
                fadeOut:Play()
                if fadeOut.Completed then fadeOut.Completed:Wait() end
            end
            if dust and dust.Parent then dust:Destroy() end
        end)
    end
end

-- Função de Animação de Entrada
local function animateIn()
    task.spawn(animateCosmicDust)
    TweenService:Create(blur, TweenInfo.new(1.5), {Size = 24}):Play()
    TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(creditsLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play() --! NOVO: Animação de entrada dos créditos

    for i = 1, #word do
        task.delay(i * 0.15, function()
            if not isAnimating then return end
            
            local char = word:sub(i, i)
            local label = Instance.new("TextLabel", frame)
            label.Text = char
            label.Font = Enum.Font.GothamBlack
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextTransparency = 1
            label.TextSize = 30
            label.Size = UDim2.new(0, 80, 0, 80)
            label.AnchorPoint = Vector2.new(0.5, 0.5)
            
            local endPosition = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 85, 0.5, 0)
            local startPosition = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 85, 0.35, 0)
            
            label.Position = startPosition
            label.Rotation = -20
            label.BackgroundTransparency = 1
            
            local gradient = Instance.new("UIGradient", label)
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 160))
            })
            gradient.Rotation = 90
            
            table.insert(letters, label)
            
            soundLetterPop.PlaybackSpeed = math.random(90, 105) / 100
            soundLetterPop:Play()
            
            local inTweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
            TweenService:Create(label, inTweenInfo, {
                TextTransparency = 0,
                TextSize = 70,
                Position = endPosition,
                Rotation = 0
            }):Play()
        end)
    end
end

-- Função para mostrar o status de carregamento (VERSÃO ATUALIZADA)
local function showLoadingStatus()
    local messages = {
        "Conectando ao servidor...",
        "Injetando scripts...",
        "Carregando assets do mapa...",
        "Verificando integridade...",
        "Preparando o ambiente...",
        "Compilando shaders...",
        "Sincronizando dados...",
        "Finalizando..."
    }
    
    local totalDuration = 7 -- Duração total do ciclo de mensagens
    local startTime = tick()

    local tweenInfo = TweenInfo.new(0.5)
    TweenService:Create(statusLabel, tweenInfo, {TextTransparency = 0}):Play()

    while tick() - startTime < totalDuration do
        if not isAnimating then break end
        
        local elapsedTime = tick() - startTime
        local percentage = math.min(99, math.floor((elapsedTime / totalDuration) * 100))
        local randomMessage = messages[math.random(1, #messages)]
        
        statusLabel.Text = string.format("[%d%%] %s", percentage, randomMessage)
        
        task.wait(0.1) -- Quão rápido o texto pisca
    end
    
    if isAnimating then
        statusLabel.Text = "[100%] Concluído!"
        soundSuccess:Play() -- Toca o som de sucesso
        task.wait(0.5) -- Deixa a mensagem final por um momento
    end

    TweenService:Create(statusLabel, tweenInfo, {TextTransparency = 1}):Play()
end

-- Função de Animação de Saída
local function animateOut()
    isAnimating = false

    local outTweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local blurOutTween = TweenService:Create(blur, outTweenInfo, {Size = 0})
    
    TweenService:Create(bg, outTweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(creditsLabel, outTweenInfo, {TextTransparency = 1}):Play() --! NOVO: Animação de saída dos créditos
    
    for i, label in ipairs(letters) do
        task.delay(i * 0.15, function()
            local letterOutTweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            local flyOutPosition = UDim2.new(0.5, label.Position.X.Offset, 0.6, 0)
            local tween = TweenService:Create(label, letterOutTweenInfo, {
                Position = flyOutPosition,
                TextTransparency = 1,
                Rotation = 20
            })
            tween:Play()
        end)
    end
    
    blurOutTween:Play()
    
    local totalExitAnimationTime = (#letters * 0.15) + 1.2
    task.wait(totalExitAnimationTime)
    
    task.wait(0.2)
    
    screenGui:Destroy()
    blur:Destroy()
end

-- 3. EXECUÇÃO PRINCIPAL
animateIn()

-- Espera a animação de entrada terminar
local totalEntryAnimationTime = (#word * 0.15) + 1.2
task.wait(totalEntryAnimationTime)

-- Inicia as mensagens de status (esta função agora controla a espera de 7 segundos)
showLoadingStatus()

-- A animação de saída é chamada após a conclusão de showLoadingStatus
animateOut()

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

local Window = WindUI:CreateWindow({
    Title = "ZyronHub",
    Icon = "rbxassetid://115617028181174",
    Author = "Created Whith ❤",
    Folder = "ZyronHub",
    Size = UDim2.fromOffset(700, 500),
    Theme = "Dark",
    HideSearchBar = false,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            WindUI:Notify({
                Title = "User Profile",
                Content = "User profile clicked!",
                Duration = 3
            })
        end
    },
    SideBarWidth = 220,
    ScrollBarEnabled = true
})

Window:DisableTopbarButtons({"Minimize"})

WindUI:Popup({
    Title = gradient("ZyronHub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "rbxassetid://115617028181174",
    Content = "Welcome to Zyron Hub",
    Buttons = {
        {
            Title = "Get Started",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotaoImagemGui"
screenGui.Parent = playerGui

local button = Instance.new("ImageButton")
button.Name = "Button"
button.Size = UDim2.new(0, 50, 0, 50) 
button.Position = UDim2.new(0.25, 0, 0.1, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Image = "rbxassetid://115617028181174"
button.ScaleType = Enum.ScaleType.Fit
button.Visible = false
button.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

local function minimizeWindow()
    Window:Close()
    button.Visible = true
end

local function restoreWindow()
    Window:Open()
    button.Visible = false
end

button.MouseButton1Click:Connect(function()
    restoreWindow()
end)

Window:CreateTopbarButton("minimize", "minus", function()
    minimizeWindow()
end, 1)


Window:Tag({
    Title = "v1.6.4",
    Color = Color3.fromHex("#30ff6a")
})
Window:Tag({
    Title = "Script Hub",
    --Color = Color3.fromHex("#30ff6a")
})
--sections
local Tabs = {
    Main = Window:Section({ Title = "Main", Opened = true }),
    Utilities = Window:Section({ Title = "Utilities", Opened = true }),
    Settings = Window:Section({ Title = "Settings", Opened = true }),
    footerSection = Window:Section({ Title = "ZyronHub " .. WindUI.Version })
}
--tabs
local TabHandles = {
    FirstGame = Tabs.Main:Tab({ Title = "FirstGame", Icon = "layout-grid" }),
    Config = Tabs.Settings:Tab({ Title = "Configuration", Icon = "settings" }), -- lucide e o segundo
    Antiafk = Tabs.Utilities:Tab({ Title = "Anti Afk", Icon = "settings" }),
    Universalkeyboard = Tabs.Utilities:Tab({ Title = "Universal Keyboard", Icon = "settings" }),
    Admincmd = Tabs.Utilities:Tab({ Title = "Admin Cmd", Icon = "settings" }),
    UNCcheck = Tabs.Utilities:Tab({ Title = "Unc Check", Icon = "settings" })
}
--fistgame
TabHandles.FirstGame:Paragraph({
    Title = "Script",
    Desc = "Click execute to run script",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.FirstGame:Divider()

TabHandles.FirstGame:Button({
    Title = "Execute",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "ZyronHub",
            Content = "script executed successfully!",
            Icon = "bell", 
            Duration = 3
        })
    end
})

--config
TabHandles.Config:Paragraph({
    Title = "Customize Interface",
    Desc = "Personalize your experience",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.Config:Dropdown({
    Title = "Select Theme",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "Theme Applied",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.Config:Slider({
    Title = "Transparency",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

TabHandles.Config:Toggle({
    Title = "Enable Dark Mode",
    Desc = "Use dark color scheme",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Dark" or "Light")
        themeDropdown:Select(state and "Dark" or "Light")
    end
})

TabHandles.Config:Paragraph({
    Title = "Join Discord",
    Desc = "discord.gg/z8vWYVVyfv",
    Image = "heart",
    ImageSize = 20,
    Color = "Grey",
    Buttons = {
        {
            Title = "Copy Link",
            Icon = "copy",
            Variant = "Tertiary",
            Callback = function()
                setclipboard("https://discord.gg/z8vWYVVyfv")
                WindUI:Notify({
                    Title = "Copied!",
                    Content = "Discord link copied to clipboard",
                    Duration = 2
                })
            end
        }
    }
})

--antiafk
TabHandles.Antiafk:Paragraph({
    Title = "Script",
    Desc = "Click execute to run script",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.Antiafk:Divider()

TabHandles.Antiafk:Button({
    Title = "Execute",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "ZyronHub",
            Content = "script executed successfully!",
            Icon = "bell",
            Duration = 3
        })
            loadstring(game:HttpGet("https://pastebin.com/raw/TRCYuX46",true))()
    end
})
--Universal Keyboard
TabHandles.Universalkeyboard:Paragraph({
    Title = "Script",
    Desc = "Click execute to run script",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.Universalkeyboard:Divider()

TabHandles.Universalkeyboard:Button({
    Title = "Execute",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "ZyronHub",
            Content = "script executed successfully!",
            Icon = "bell",
            Duration = 3
        })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end
})
--AdminCMD
TabHandles.Admincmd:Paragraph({
    Title = "Script",
    Desc = "Click execute to run script",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.Admincmd:Divider()

TabHandles.Admincmd:Button({
    Title = "Execute",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "ZyronHub",
            Content = "script executed successfully!",
            Icon = "bell",
            Duration = 3
        })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source",true))()
    end
})
--UNCcheck
TabHandles.UNCcheck:Paragraph({
    Title = "Script",
    Desc = "Click execute to run script",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.UNCcheck:Divider()

TabHandles.UNCcheck:Button({
    Title = "Execute",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "ZyronHub",
            Content = "script executed successfully!",
            Icon = "bell",
            Duration = 3
        })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/main/UNCCheckEnv.lua", true))()
    end
})


--button
Window:OnClose(function()
    print("Window closed")
end)

Window:OnDestroy(function()
    print("Window destroyed")
end)