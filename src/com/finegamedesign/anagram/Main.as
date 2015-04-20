package com.finegamedesign.anagram
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.getTimer;

    import org.flixel.plugin.photonstorm.API.FlxKongregate;
    import com.newgrounds.API;

    public class Main extends Sprite
    {
        private var controller:Controller;
        private var model:Model;
        private var view:View;

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
            model = new Model();
            // model.onComplete = onComplete;
            controller = new Controller();
            view = new View(model, main);
            main.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
            include "../../../../newgrounds_connect.as"
        }

        private function update(e:Event):void
        {
            var now:int = getTimer();
            model.update(now);
            controller.update();
            view.update();
        }

        private function onComplete():void
        {
            API.postScore("Score", model.score);
            FlxKongregate.api.stats.submit("Score", model.score);
        }
    }
}
