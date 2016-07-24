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
        private var shootSound:ShootSound = new ShootSound();
        private var selectSound:SelectSound = new SelectSound();
        private var explosionSound:ExplosionSound = new ExplosionSound();
        private var explosionBigSound:ExplosionBigSound = new ExplosionBigSound();

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
            updateCheat();
            updateBackspace();
            var presses:Array = model.getPresses(keyMouse.justPressed);
            updateSelect(model.press(presses), true);
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
                updateSelect(model.backspace(), false);
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
                if (null != state) 
                {
                    main.word.gotoAndPlay(state);
                    main.input.gotoAndPlay(state);
                    shootSound.play();
                }
                resetSelect();
            }
        }

        private function resetSelect():void
        {
            var parent:MovieClip = main.word.state;
            var max:int = model.letterMax;
            for (var index:int = 0; index < max; index++)
            {
                var name:String = "letter_" + index;
                parent[name].gotoAndPlay("none");
            }
        }

        /**
         * Each selected letter in word plays animation "selected".
Select, submit: Anders sees reticle and sword. Test case:  2015-04-18 Anders sees word is a weapon.
         */
        private function updateSelect(selects:Array, selected:Boolean):void
        {
            var parent:MovieClip = main.word.state;
            var state:String = selected ? "selected" : "none";
            for (var s:int = 0; s < selects.length; s++)
            {
                var index:int = selects[s];
                var name:String = "letter_" + index;
                parent[name].gotoAndPlay(state);
                selectSound.play();
            }
        }

        /**
         * Press PAGE UP:  Cheat to next word.
         */
        private function updateCheat():void
        {
            if (keyMouse.justPressed("PAGEUP"))
            {
                model.cheatLevelUp(1);
                selectSound.play();
            }
            else if (keyMouse.justPressed("PAGEDOWN"))
            {
                model.cheatLevelUp(-1);
                selectSound.play();
            }
        }

        private function updateHud():void
        {
            main.score.text = model.score.toString();
            main.level.text = model.levels.current().toString();
            main.levelMax.text = model.levels.count().toString();
            main.help.text = model.help.toString();
        }

        private function updatePosition():void
        {
            if (model.mayKnockback())
            {
                updateOutputHitsWord();
            }
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
                if (model.onOutputHitsWord()) 
                {
                    target.gotoAndPlay("hit");
                    main.word.complete.gotoAndPlay("hit");
                    explosionBigSound.play();
                }
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
