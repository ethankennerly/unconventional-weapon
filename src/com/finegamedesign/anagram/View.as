package com.finegamedesign.anagram
{
    import flash.display.MovieClip;
    import org.flixel.system.input.KeyMouse;

    public class View
    {
        private var keyMouse:KeyMouse;
        private var main:MovieClip;
        private var model:Model;

        public function View(model:Model, main:MovieClip)
        {
            this.model = model;
            this.main = main;
            this.keyMouse = new KeyMouse();
            this.keyMouse.listen(this.main.stage);
        }

        internal function update():void
        {
            keyMouse.update();
            updateLetters(main.word, this.model.word);
            var presses:Array = justPresses(this.model.available);
            model.press(presses);
            updateLetters(main.input, this.model.inputs);
        }

        private function justPresses(word:Array):Array
        {
            var presses:Array = [];
            var letters:Object = {};
            for (var i:int = 0; i < word.length; i++) 
            {
                var letter:String = word[i];
                if (letter in letters)
                {
                    continue;
                }
                else
                {
                    letters[letter] = true;
                }
                var justPressed:Boolean = keyMouse.justPressed(letter);
                if (justPressed) 
                {
                    presses.push(letter);
                }
            }
            return presses;
        }

        private function updateLetters(parent:MovieClip, letters:Array):void
        {
            var max:int = this.model.letterMax;
            for (var i:int = 0; i < max; i++)
            {
                var name:String = "letter_" + i;
                if (null != parent[name])
                {
                    var visible:Boolean =  i < letters.length;
                    parent[name].visible = visible;
                    if (visible) {
                        parent[name].txt.text = letters[i];
                    }
                }
            }
        }
    }
}
