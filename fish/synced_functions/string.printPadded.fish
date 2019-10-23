# Defined in /home/tstauber/.config/fish/greeter.fish @ line 6
function string.printPadded --argument width pref_color prefix key_color key padding_color padding_char value_color value suffix_color suffix
	set_color $pref_color; echo -en $prefix
    set_color $key_color; echo -en $key
    set_color $padding_color; echo -en (string repeat --count (math \( $width-(string.sumLengths $prefix $key $value $suffix) \) / (string length "$padding_char")) $padding_char )
    set_color $value_color; echo -en $value
    set_color $suffix_color; echo -en $suffix
end
