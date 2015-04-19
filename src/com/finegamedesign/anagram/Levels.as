package com.finegamedesign.anagram
{
    public class Levels
    {
        internal var index:int = 0;
        /**
         * Some anagrams copied from:
         * http://www.enchantedlearning.com/english/anagram/numberofletters/5letters.shtml
         * Test case:  2015-04-18 Redbeard at The MADE types word.  Got stumped by anagram "ERISIOUS" and "NIOMTENTPO"
         * http://www.cse.unr.edu/~cohen/text.php
         */
        internal var params:Object = [
            {text: "START", 
             help: 'ANAGRAM ATTACK\n\nCLICK HERE. TYPE "START".  PRESS THE SPACE KEY OR ENTER KEY.',
             wordWidthPerSecond: 0.0,
             wordPosition: 0.0},
            {text: "LSEPL", 
             help: 'TO ADVANCE, USE ALL THE LETTERS.  HINT:  "SPELL".  THEN PRESS THE SPACE KEY OR ENTER KEY.'},
            {text: "DWORS", 
             help: 'TO SCORE HIGHER, FIRST USE FEWER LETTERS.  EXAMPLES: "ROD", "RODS", "WORD", "SWORD".'},
            {text: "STARE",
             help: 'A SHORTER WORD KNOCKS THE WORD BACK.  EXAMPLE:  "EAT", "TEAR", "STARE"'},
            {text: "FOR",
             help: 'WORDS WITH FEW LETTERS MOVE FAST!'},
            {text: "EAT"},
            {text: "ART"},
            {text: "SAP"},
            {text: "SATE"},
            {text: "APT"},
            {text: "ARM"},
            {text: "ERA"},
            {text: "POST"},
            {text: "OWN"},
            {text: "PLEA"},
            {text: "BATS"},
            {text: "LEAD"},
            {text: "BEAST", help: 'TO SCORE HIGHER, FIRST ENTER WORDS WITH FEWER LETTERS.  EXAMPLES: "BE", "BATS", "AT".'},
            {text: "DIET"},
            {text: "INKS"},
            {text: "LIVE"},
            {text: "RACES"},
            {text: "KALE"},
            {text: "SNOW"},
            {text: "NEST"},
            {text: "STEAM"},
            {text: "EMIT"},
            {text: "NAME"},
            {text: "SWAY"},
            {text: "PEARS"},
            {text: "SKATE"},
            {text: "BREAD"},
            {text: "CODE"},
            {text: "DIETS"},
            {text: "CRATES"},
            {text: "TERSE"},
            {text: "LAPSE"},
            {text: "PROSE"},
            {text: "SPREAD", help: "TO SCORE HIGHER, FIRST ENTER WORDS WITH FEWER LETTERS. WHEN SATISFIED, ENTER FULL WORD."},
            {text: "SMILE"},
            {text: "ALERT"},
            {text: "BEGIN"},
            {text: "TIMERS"},
            {text: "HEROS"},
            {text: "PETAL"},
            {text: "LITER"},
            {text: "PETALS"},
            {text: "VERSE"},
            {text: "RESIN"},
            {text: "NOTES"},
            {text: "SPARSE"},
            {text: "SHEAR"},
            {text: "SUBTLE"},
            {text: "REWARD"},
            {text: "REPLAYS"},
            {text: "MANTEL"},
            {text: "DESIGN"},
            {text: "LASTED"},
            {text: "RECANTS"},
            {text: "FOREST"},
            {text: "POINTS"},
            {text: "MASTER"},
            {text: "THREADS"},
            {text: "DANGER"},
            {text: "SPRITES"},
            {text: "ARTIST"},
            {text: "TENSOR"},
            {text: "ARIDEST"},
            {text: "LISTEN"},
            {text: "PIRATES"},
            {text: "ALERTED"},
            {text: "ALLERGY"},
            {text: "REDUCES"},
            {text: "MEDICAL"},
            {text: "RAPIDS"},
            {text: "RETARDS"},
            {text: "REALIST"},
            {text: "MEANEST"},
            {text: "ADMIRER"},
            {text: "TRAINERS"},
            {text: "RECOUNTS"},
            {text: "PARROTED"},
            {text: "DESIGNER"},
            {text: "CRATERED"},
            {text: "CALIPERS"},
            {text: "CREATIVE"},
            {text: "ARROGANT"},
            {text: "EMIGRANTS"},
            {text: "AUCTIONED"},
            {text: "CASSEROLE"},
            {text: "UPROARS"},
            {text: "ANTIGEN"},
            {text: "DEDUCTIONS"},
            {text: "INTRODUCES"},
            {text: "PERCUSSION"},
            {text: "CONFIDENT"},
            {text: "HARMONICAS"},
            {text: "OMNIPOTENT"},
            {text: "YOU"},
            {text: "WIN"}
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

        internal function current():int
        {
            return index + 1;
        }

        internal function count():int
        {
            return params.length;
        }
    }
}
