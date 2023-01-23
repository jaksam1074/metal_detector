locales = locales or {}

function getLocalizedText(text, ...)
    local message = nil

    if(locales[config.locale][text]) then
        message = locales[config.locale][text]
    else
        message = locales["en"][text]
    end
    
    if(message) then
        local _, argumentsCount = string.gsub(message, "%%.", "")

        -- If arguments to format in the string are the correct number
        if(argumentsCount == #{...}) then
            return string.format(message, ...)
        else
            print()
            print("^1Argument missing for translation, retranslate it by copy pasting the ^3['" .. text .. "']^1 translation of the ^5LATEST VERSION of ^6locales/en.lua^1 in the file of your language^7")
            print("^3[DEBUG] Arguments passed: " .. json.encode({...}))
            print()
            return text
        end
    else
        print("^1Translation missing: ^3" .. text .. "^7")
        return text
    end
end