package com.finegamedesign.anagram
{
    import flash.display.MovieClip;

    public class View
    {
        private var main:MovieClip;
        private var model:Model;

        public function View(model:Model, main:MovieClip)
        {
            this.model = model;
            this.main = main;
        }

        internal function update():void
        {
            updateLetters(main.input, this.model.inputs);
            updateLetters(main.word, this.model.word);
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
