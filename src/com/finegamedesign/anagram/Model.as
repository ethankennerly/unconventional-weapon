package com.finegamedesign.anagram
{
    public class Model
    {
        internal var letterMax:int = 10;
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
                                     -0.002;
                                     // -0.001;
                var power:Number = 
                                   // 1.5;
                                   // 1.75;
                                   2.0;
                var base:Number = Math.max(1, letterMax - text.length);
                wordWidthPerSecond *= Math.pow(base, power);
            }
            available = text.split("");
            selects = word.concat();
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
            var wordWidth:Number = 160;
            var min:Number = -width + wordWidth;
            if (wordPosition <= min)
            {
                help = "GAME OVER!  TO SKIP ANY WORD, PRESS THE PAGEUP KEY.  TO GO BACK A WORD, PRESS THE PAGEDOWN KEY.";
            }
            wordPosition = Math.max(min, Math.min(0, wordPosition));
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
            var perLength:Number = 
                                   0.03;
                                   // 0.05;
                                   // 0.1;
            outputKnockback = perLength * width * length;
            if (complete) {
                outputKnockback *= 3;
            }
            clampWordPosition();
        }

        internal function onOutputHitsWord():Boolean
        {
            var enabled:Boolean = mayKnockback();
            if (enabled)
            {
                wordPosition += outputKnockback;
                shuffle(word);
                selects = word.concat();
                for (var i:int = 0; i < inputs.length; i++)
                {
                    var letter:String = inputs[i];
                    var selected:int = selects.indexOf(letter);
                    if (0 <= selected)
                    {
                        selects[selected] = letter.toLowerCase();
                    }
                }
                outputKnockback = 0;
            }
            return enabled;
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
         * If letter not available, disable typing it.
         * @return array of word indexes.
         */
        internal function press(presses:Array):Array
        {
            var letters:Object = {};
            var selectsNow:Array = [];
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
                    var selected:int = selects.indexOf(letter);
                    if (0 <= selected)
                    {
                        selectsNow.push(selected);
                        selects[selected] = letter.toLowerCase();
                    }
                }
            }
            return selectsNow;
        }

        private var selects:Array;

        internal function backspace():Array
        {
            var selectsNow:Array = [];
            if (1 <= inputs.length)
            {
                var letter:String = inputs.pop();
                available.push(letter);
                var selected:int = selects.lastIndexOf(letter.toLowerCase());
                if (0 <= selected)
                {
                    selectsNow.push(selected);
                    selects[selected] = letter;
                }
            }
            return selectsNow;
        }

        internal var state:String;
        internal var helpState:String;

        /**
         * @return animation state.
         *      "submit" or "complete":  Word shoots. Test case:  2015-04-18 Anders sees word is a weapon.
         *      "submit":  Shuffle letters.  Test case:  2015-04-18 Jennifer wants to shuffle.  Irregular arrangement of letters.  Jennifer feels uncomfortable.
         * Test case:  2015-04-19 Backspace. Deselect. Submit. Type. Select.
         */
        internal function submit():String
        {
            var submission:String = inputs.join("");
            var accepted:Boolean = false;
            state = "wrong";
            if (1 <= submission.length)
            {
                if (submission in wordHash)
                {
                    if (submission in repeat)
                    {
                        state = "repeat";
                        if (levels.index <= 50 && "" == help)
                        {
                            help = "YOU CAN ONLY ENTER EACH SHORTER WORD ONCE.";
                            helpState = "repeat";
                        }
                    }
                    else
                    {
                        if ("repeat" == helpState)
                        {
                            helpState = "";
                            help = "";
                        }
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
            selects = word.concat();
            return state;
        }

        private function scoreUp(submission:String):void
        {
            points = submission.length;
            score += points;
        }

        internal function cheatLevelUp(add:int):void
        {
            trial(levels.up(add));
            wordPosition = 0.0;
        }
    }
}
