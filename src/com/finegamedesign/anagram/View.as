package com.finegamedesign.anagram
{
    import flash.display.MovieClip;
    import flash.geom.Point;
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
            updateBackspace();
            var presses:Array = model.getPresses(keyMouse.justPressed);
            model.press(presses);
            updateSubmit();
            updatePosition();
            updateLetters(main.word.state, this.model.word);
            updateLetters(main.word.complete, this.model.completes);
            updateLetters(main.input.state, this.model.inputs);
            updateLetters(main.input.output, this.model.outputs);
            updateHud();
        }

        /**
         * Delete or backspace:  Remove last letter.
         */
        private function updateBackspace():void
        {
            if (keyMouse.justPressed("DELETE")
            || keyMouse.justPressed("BACKSPACE"))
            {
                model.backspace();
            }
        }
        /**
         * Press space or enter.  Input word.
         * Word robot approaches.
         *     restructure synchronized animations:
         *         word
         *             complete
         *             state
         *         input
         *             output
         *             state
         */
        private function updateSubmit():void
        {
            if (keyMouse.justPressed("SPACE")
            || keyMouse.justPressed("ENTER"))
            {
                var state:String = model.submit();
                if (state) 
                {
                    main.word.gotoAndPlay(state);
                    main.input.gotoAndPlay(state);
                }
            }
        }

        private function updateHud():void
        {
            main.score.text = model.score.toString();
            main.help.text = model.help.toString();
        }

        private function updatePosition():void
        {
            if (model.mayKnockback())
            {
                updateOutputHitsWord();
            }
            main.input.x = model.inputPosition;
            main.word.x = model.wordPosition;
        }

	    /**
         * Knockback on collision:  global coordinate of right side most visible input greater than word position.
         */
        private function updateOutputHitsWord():void
        {
            var index:int = model.outputs.length - 1;
            var right:String = "letter_" + index;
            var bullet:MovieClip = main.input.output[right];
            var point:Point = new Point(0.0, 0.0);
            var bulletPosition:Point = bullet.localToGlobal(point);
            var target:MovieClip = main.word.state;
            var targetPosition:Point = target.localToGlobal(point);
            if (targetPosition.x <= bulletPosition.x)
            {
                model.onOutputHitsWord();
            }
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
