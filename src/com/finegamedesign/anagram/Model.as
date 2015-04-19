package com.finegamedesign.anagram
{
    public class Model
    {
        internal var letterMax:int = 11;
        internal var inputPosition:Number = 0.0;
        internal var inputs:Array = [];
        /**
         * From letter graphic.
         */
        internal var letterWidth:Number = 42.0;
        internal var help:String;
        internal var outputs:Array = [];
        internal var completes:Array = [];
        internal var text:String;
        internal var word:Array;
        internal var wordPosition:Number = 0.0;
        internal var points:int = 0;
        internal var score:int = 0;
        internal var levels:Levels = new Levels();
        private var available:Array;
        private var repeat:Object = {};
        private var wordHash:Object;

        public function Model()
        {
            wordHash = new Words().init();
            trial(levels.getParams());
        }

        private function shuffle(cards:Array):void
        {
            for (var i:int = cards.length - 1; 1 <= i; i--)
            {
                var r:int = Math.random() * (i + 1);
                var swap:* = cards[r];
                cards[r] = cards[i];
                cards[i] = swap;
            }
        }

        internal function trial(params:Object):void
        {
            help = "";
            wordWidthPerSecond = -0.01;
            for (var key:String in params)
            {
                this[key] = params[key];
            }
            word = text.split("");
            if ("" == help)
            {
                shuffle(word);
                wordWidthPerSecond = // -0.05;
                                     // -0.02;
                                     // -0.01;
                                     // -0.005;
                                     -0.001;
                var power:Number = 2.0;
                var base:Number = Math.max(1, letterMax - text.length);
                wordWidthPerSecond *= Math.pow(base, power);
            }
            available = text.split("");
            repeat = {};
        }

        private var previous:int = 0;

        internal function update(now:int):void
        {
            var seconds:Number = (now - previous) / 1000.0;
            updatePosition(seconds);
            previous = now;
        }

        internal var width:Number = 720;
        private var wordWidthPerSecond:Number;

        private function clampWordPosition():void
        {
            var wordWidth:Number = 150;
            wordPosition = Math.max(-width + wordWidth, Math.min(0, wordPosition));
        }

        private function updatePosition(seconds:Number):void
        {
            wordPosition += (seconds * width * wordWidthPerSecond);
            clampWordPosition();
            //- trace("Model.updatePosition: " + wordPosition);
        }

        private var outputKnockback:Number = 0.0;

        internal function mayKnockback():Boolean
        {
            return 0 < outputKnockback && 1 <= outputs.length;
        }

        /**
         * Clamp word to appear on screen.  Test case:  2015-04-18 Complete word.  See next word slide in.
         */
        private function prepareKnockback(length:int, complete:Boolean):void
        {
            var perLength:Number = 0.1;
            outputKnockback = perLength * width * length;
            if (complete) {
                outputKnockback *= 3;
            }
            clampWordPosition();
        }

        internal function onOutputHitsWord():void
        {
            if (mayKnockback())
            {
                wordPosition += outputKnockback;
                shuffle(word);
                outputKnockback = 0;
            }
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
        internal function press(presses:Array):void
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

        internal function backspace():void
        {
            if (1 <= inputs.length)
            {
                available.push(inputs.pop());
            }
        }

        internal var state:String;

        /**
         * @return animation state.
         *      "submit" or "complete":  Word shoots. Test case:  2015-04-18 Anders sees word is a weapon.
         *      "submit":  Shuffle letters.  Test case:  2015-04-18 Jennifer wants to shuffle.  Irregular arrangement of letters.  Jennifer feels uncomfortable.
         */
        internal function submit():String
        {
            var submission:String = inputs.join("");
            var accepted:Boolean = false;
            state = "wrong";
            if (2 <= submission.length)
            {
                if (submission in wordHash)
                {
                    if (submission in repeat)
                    {
                        state = "repeat";
                    }
                    else
                    {
                        repeat[submission] = true;
                        accepted = true;
                        scoreUp(submission);
                        var complete:Boolean = text.length == submission.length;
                        prepareKnockback(submission.length, complete);
                        if (complete)
                        {
                            completes = word.concat();
                            trial(levels.up());
                            state = "complete";
                        }
                        else 
                        {
                            state = "submit";
                        }
                    }
                }
                outputs = inputs.concat();
            }
            // trace("Model.submit: " + submission + ". Accepted " + accepted);
            inputs.length = 0;
            available = word.concat();
            return state;
        }

        private function scoreUp(submission:String):void
        {
            points = submission.length;
            score += points;
        }

        internal function cheatLevelUp():void
        {
            trial(levels.up());
        }
    }
}
