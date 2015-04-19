package com.finegamedesign.anagram
{
    public class Levels
    {
        internal var index:int = 0;
        /**
         * Some anagrams copied from:
         * http://www.enchantedlearning.com/english/anagram/numberofletters/5letters.shtml
         */
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
            {text: "BEAST"},
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
            {text: "CODE"},
            {text: "SKATE"},
            {text: "BREAD"},
            {text: "DIETS"},
            {text: "CRATES"},
            {text: "TERSE"},
            {text: "LAPSE"},
            {text: "PROSE"},
            {text: "SPREAD"},
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
            {text: "ARIDEST"},
            {text: "PIRATES"},
            {text: "ALERTED"},
            {text: "ALLERGY"},
            {text: "REDUCES"},
            {text: "MEDICAL"},
            {text: "RETARDS"},
            {text: "REALIST"},
            {text: "TRAINERS"},
            {text: "RECOUNTS"},
            {text: "PARROTED"},
            {text: "DESIGNER"},
            {text: "CRATERED"},
            {text: "CALIPERS"},
            {text: "ARROGANT"},
            {text: "EMIGRANTS"},
            {text: "AUCTIONED"},
            {text: "CASSEROLE"},
            {text: "DISCOUNTER"},
            {text: "DEDUCTIONS"},
            {text: "PERCUSSION"},
            {text: "CONFIDENT"},
            {text: "HARMONICAS"}
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
