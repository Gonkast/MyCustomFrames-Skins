-- ==========================================================================
-- Skin "Murloc" para MyCustomFrames.
-- Addon PROPIO (carpeta MyCustomFrames_Murloc) -- pedido del usuario
-- 2026-07-25: "quisiera que en los subelementos del addon si salgan las skins
-- instaladas, por si se quiere apagar algunas". El nombre de carpeta
-- `MyCustomFrames_<Skin>` es lo que hace que WoW la anide como sub-elemento de
-- MyCustomFrames en la lista de AddOns, con su propio checkbox e icono.
-- Se intento meter todas las skins en UN solo addon (con subcarpetas) para
-- tener un repo unico, pero eso pierde los checkboxes: WoW lee UN .toc por
-- carpeta = un solo checkbox. El repo unico se logra igual, versionando la
-- carpeta AddOns\ con un .gitignore que solo deja pasar las MyCustomFrames_*.
--
-- Este archivo NO comparte el `ns` de MyCustomFrames -- cada addon tiene el
-- suyo, privado -- por eso se registra via la funcion GLOBAL
-- _G.MCF_RegisterSkin que expone core.lua del addon principal.
-- `## RequiredDeps: MyCustomFrames` en el .toc garantiza que cargue DESPUES,
-- asi esa funcion global ya existe.
--
-- **CONTRATO (ver SkinResolve en core.lua): esta carpeta Assets\ DEBE traer
-- las 23 texturas de la lista blanca `SKINNABLE` + el MasqueSkin\ completo.**
-- No hay fallback por archivo: lo que este en la lista y falte aca se
-- renderiza INVISIBLE (no se puede detectar si un archivo existe -- SetTexture
-- devuelve true igual). Cualquier textura del addon que NO este en esa lista
-- sale siempre del Assets\ del addon principal, sin importar que haya aca.
-- ==========================================================================
local BASE = "Interface\\AddOns\\MyCustomFrames_Murloc\\Assets\\"

-- 3er argumento (2026-07-23): nombre EXACTO del skin de Masque que esta skin
-- registra mas abajo (SKIN_NAME) -- asi ns.ApplyMasqueSkinAll (MasqueSkin.lua
-- del addon principal) sabe a que skin de Masque cambiar Bartender4 cuando el
-- usuario elige "Murloc" en el dropdown de Skins.
if _G.MCF_RegisterSkin then
    _G.MCF_RegisterSkin("Murloc", BASE, "Murloc")
end

-- ==========================================================================
-- Skin de Masque propio de esta skin (pedido del usuario: "que la skin
-- traiga su propia masque skin tambien"). Mismo patron/estructura que
-- MasqueSkin.lua del addon principal ("Azerite HEX"), con otro nombre y
-- apuntando a los assets de ESTE addon -- si los archivos todavia no
-- existen en Assets\MasqueSkin\, Masque simplemente no los encuentra (sin
-- crashear); se pueden agregar despues sin tocar este archivo.
-- ==========================================================================
local MA = BASE .. "MasqueSkin\\"
local function mpath(name) return MA .. name .. ".tga" end

local SKIN_NAME = "Murloc"
local mod = 1.5
local function scale(contentSize, sourceTextureSize)
    sourceTextureSize = sourceTextureSize or contentSize
    return sourceTextureSize / contentSize * 36 * mod
end

local function RegisterMasqueSkin()
    local MSQ = LibStub and LibStub("Masque", true)
    if not MSQ then return false end

    MSQ:AddSkin(SKIN_NAME, {
        API_VERSION = 110210,
        Shape       = "Circle",

        Description = "Murloc reskin, bundled with MyCustomFrames_Murloc.",
        Version     = "1.0",
        Authors     = { "Gonkast" },

        Normal = {
            Width = scale(256, 256), Height = scale(256, 256),
            Texture = mpath("actionbutton-border"), EmptyTexture = mpath("actionbutton-border"),
            TexCoords = { 0, 1, 0, 1 }, Color = { 1, 1, 1, 1 }, EmptyColor = { 1, 1, 1, 1 },
        },
        Border = {
            Width = scale(256, 256), Height = scale(256, 256),
            TexCoords = { 0, 1, 0, 1 }, BlendMode = "BLEND", Color = { 1, 1, 1, 1 },
            Texture = mpath("actionbutton-border"),
        },
        Highlight = {
            Width = scale(256, 256), Height = scale(256, 256),
            TexCoords = { 0, 1, 0, 1 }, BlendMode = "ADD", Color = { 1, 1, 1, 0.25 },
            Texture = mpath("actionbutton-border"),
        },
        Backdrop = {
            Width = scale(256, 256), Height = scale(256, 256),
            TexCoords = { 0, 1, 0, 1 }, Color = { 1, 1, 1, 1 },
            Texture = mpath("actionbutton-backdrop"),
        },
        Checked = {
            Width = scale(256, 256), Height = scale(256, 256),
            TexCoords = { 0, 1, 0, 1 }, BlendMode = "BLEND", Color = { 1, 1, 1, 1 },
            Texture = mpath("actionbutton-border"),
        },
        Icon = {
            Width = scale(64, 42), Height = scale(64, 42),
            Mask = mpath("actionbutton_circular_mask"), TexCoords = { 0, 1, 0, 1 },
        },
        Flash = {
            Width = scale(64, 42), Height = scale(64, 42),
            Color = { 0.7, 0, 0, 0.3 }, Texture = mpath("actionbutton-pushed"),
        },
        Pushed = {
            Width = scale(32, 32), Height = scale(32, 32),
            Color = { 1, 1, 1, 0.15 }, Texture = mpath("actionbutton-pushed"),
        },
        Gloss = {
            Width = scale(256, 256), Height = scale(256, 256),
            TexCoords = { 0, 1, 0, 1 }, BlendMode = "BLEND", Color = { 1, 1, 1, 1 },
            Texture = mpath("actionbutton-glow-white"),
        },
        Cooldown = {
            Width = 54, Height = 54, Color = { 0, 0, 0, 0.7 }, Texture = mpath("actionbutton-pushed"),
        },
        ChargeCooldown = { Width = 34, Height = 34 },
        AutoCast = { Width = 32, Height = 32, OffsetX = 1, OffsetY = -1 },
        AutoCastable = {
            Width = 62, Height = 62, OffsetX = 1, OffsetY = 0,
            Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
        },
        Disabled = { Hide = true },
        Name = { Hide = true },
        Count = { Width = 36, Height = 12, OffsetX = -22, OffsetY = 0 },
        HotKey = { Width = 25, Height = 12, OffsetX = -22, OffsetY = 0 },
        Duration = { Width = 36, Height = 12, OffsetX = 0, OffsetY = 0 },
    }, true)
    return true
end

-- Registro inmediato en file-load (mismo motivo que MasqueSkin.lua del addon
-- principal: tiene que estar ANTES de que Bartender4/etc armen sus grupos).
RegisterMasqueSkin()
