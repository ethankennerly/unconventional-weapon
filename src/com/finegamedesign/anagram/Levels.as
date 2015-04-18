package com.finegamedesign.anagram
{
    public class Levels
    {
        internal var index:int = 0;
        internal var params:Object = [
            {text: "START", 
             help: 'ANAGRAM ADVENTURE\nTYPE "START".  THEN PRESS THE SPACE KEY OR ENTER KEY.'},
            {text: "LSEPL", 
             help: 'TO DESTROY THE ROBOT, USE ALL THE LETTERS.  HINT:  "SPELL".  THEN PRESS THE SPACE KEY OR ENTER KEY.'},
            {text: "DWORS", 
             help: 'TO ADD LETTERS, FIRST USE FEWER LETTERS.  EXAMPLES: "ROD", "RODS", "WORD", "SWORD".'}

        ];

        internal function getParams():Object
        {
            return params[index];
        }

        internal function up():Object
        {
            index = (index + 1) % params.length;
            return getParams();
        }
    }
}
