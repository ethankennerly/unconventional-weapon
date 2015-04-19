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
             help: 'TO ADD LETTERS, FIRST USE FEWER LETTERS.  EXAMPLES: "ROD", "RODS", "WORD", "SWORD".'},
            {text: "STARE",
             help: 'A LETTER THAT HITS KNOCKS YOU BACK!  KNOCK THE ROBOT BACK!  EXAMPLE:  "EAT".'},
            {text: "FOR",
             help: 'ROBOTS WITH FEW LETTERS MOVE FAST!'},
            //      0123456789
            {text: "CONFIDENT",
             help: 'BOSS ROBOT WITH MORE LETTERS MOVES SLOW. KNOCKBACK WITH SHORT WORDS. HINT: SURE, CERTAIN'}
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
