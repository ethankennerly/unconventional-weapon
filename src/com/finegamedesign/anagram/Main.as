package com.finegamedesign.anagram
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;

    public class Main extends Sprite
    {
        public var main:MovieClip;

        public function Main()
        {
            if (stage) {
                init(null);
            }
            else {
                addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
            }
        }

        private function init(event:Event=null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }
    }
}
