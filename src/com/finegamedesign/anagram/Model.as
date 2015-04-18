package com.finegamedesign.anagram
{
    public class Model
    {
        internal var letterMax:int = 10;
        internal var available:Array = "START".split("");
        internal var inputs:Array = [];
        internal var word:Array = "START".split("");

        internal function update():void
        {
        }

        internal function press(presses:Array)
        {
            var letters:Object = {};
            for (var i:int = 0; i < presses.length; i++) 
            {
                var letter:String = presses[i];
                if (letter in letters)
                {
                    continue;
                }
                else
                {
                    letters[letter] = true;
                }
                var index:int = available.indexOf(letter);
                if (0 <= index)
                {
                    available.splice(index, 1);
                    inputs.push(letter);
                }
            }
        }
    }
}
