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
            var presses:Array = model.getPresses(keyMouse.justPressed);
            model.press(presses);
            updateSubmit();
            updateLetters(main.word, this.model.word);
            updateLetters(main.input, this.model.inputs);
            updateHud();
        }

        /**
         * TODO: Press space or enter.  Input word.
         */
        private function updateSubmit():void
        {
            if (keyMouse.justPressed("SPACE")
            || keyMouse.justPressed("ENTER"))
            {
                model.submit();
            }
        }

        private function updateHud():void
        {
            main.score.text = model.score.toString();
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
