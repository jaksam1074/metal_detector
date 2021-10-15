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
            print("^1Argument missing for ^3'" .. text .. "'^1 translation, you should retranslate that string^7")
            return text
        end
    else
        print("^1Translation missing: ^3" .. text .. "^7")
        return text
    end
end