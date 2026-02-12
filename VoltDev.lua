-- GitHub Multi Script Executor
-- Executa múltiplos scripts do GitHub simultaneamente

local HttpService = game:GetService("HttpService")

-- Lista de URLs do GitHub Raw para executar
local githubUrls = {
    "https://raw.githubusercontent.com/dhon20640-coder/Volt/refs/heads/main/VoltHub.md",
    -- Adicione mais URLs aqui:
    -- "https://raw.githubusercontent.com/dhon20640-coder/DevVolt/refs/heads/main/Status.lua",
}

-- Função para baixar e executar um script
local function executeGitHubScript(url)
    spawn(function()
        local success, result = pcall(function()
            local response = game:HttpGet(url)
            return response
        end)
        
        if success then
            local executeSuccess, executeError = pcall(function()
                loadstring(result)()
            end)
            
            if executeSuccess then
                print("[✓] Script executado com sucesso: " .. url)
            else
                warn("[✗] Erro ao executar script de " .. url .. ": " .. tostring(executeError))
            end
        else
            warn("[✗] Erro ao baixar script de " .. url .. ": " .. tostring(result))
        end
    end)
end

-- Executa todos os scripts da lista
print("=== GitHub Multi Executor ===")
print("Executando " .. #githubUrls .. " script(s)...")

for i, url in ipairs(githubUrls) do
    print("[" .. i .. "] Carregando: " .. url)
    executeGitHubScript(url)
    task.wait(0.1) -- Pequeno delay entre execuções para evitar rate limit
end

print("=== Todos os scripts foram iniciados ===")
