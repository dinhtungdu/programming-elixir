defmodule MyString do
    def is_printable([head|tail]) when head in 32..255 do
        is_printable(tail)
    end
    def is_printable([head|_tail]) when head not in 32..255 do
        false
    end
    def is_printable(_) do
        true
    end
    
    def anagram?(word1, word2) 
end