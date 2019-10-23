# Defined in - @ line 2
function toggleHamster
	if [ (hamster current) = "No activity" ]
        hamster start various@Sonova
    else
        hamster stop
    end
end
