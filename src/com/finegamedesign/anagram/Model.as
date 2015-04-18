package com.finegamedesign.anagram
{
    public class Model
    {
        internal var letterMax:int = 10;
        internal var inputs:Array = [];
        private var available:Array = "START".split("");
        internal var word:Array = "START".split("");
        private var dictionary:Object = {
            "AT": true,
            "START": true
        };
        private var used:Object = {};
        internal var points:int = 0;
        internal var score:int = 0;

        internal function update():void
        {
        }

        /**
         * @param   justPressed     Filter signature justPressed(letter):Boolean.
         */
        internal function getPresses(justPressed:Function):Array
        {
            var presses:Array = [];
            var letters:Object = {};
            for (var i:int = 0; i < available.length; i++) 
            {
                var letter:String = available[i];
                if (letter in letters)
                {
                    continue;
                }
                else
                {
                    letters[letter] = true;
                }
                if (justPressed(letter)) 
                {
                    presses.push(letter);
                }
            }
            return presses;
        }

        /**
         * If letter not avaiable, disable typing it.
         */
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

        internal function submit():Boolean
        {
            var submission:String = inputs.join("");
            var accepted:Boolean = false;
            if (submission in dictionary)
            {
                if (submission in used)
                {
                }
                else
                {
                    used[submission] = true;
                    accepted = true;
                    scoreUp(submission);
                }
            }
            trace("Model.submit: " + submission + ". Accepted " + accepted);
            inputs.length = 0;
            available = word.concat();
            return accepted;
        }

        private function scoreUp(submission:String):void
        {
            points = submission.length;
            score += points;
        }
    }
}
