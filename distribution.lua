if not getgenv()._loadedSA then
    if game.PlaceId ~= 11423467063 then
        game.StarterGui:SetCore("SendNotification", {
            Title = "WRONG PLACE";
            Text = "EXECUTE AT THE BOSSFIGHT";
            Duration = 5;
        })
        return
    end

    getgenv()._loadedSA = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/n3987frejhw098h324/SAstuff/refs/heads/main/tspmo33.lua"))()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "ALREADY LOADED";
        Text = "DO NOT EXECUTE MORE THAN ONCE";
        Duration = 5;
    })
end
