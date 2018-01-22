/**
 * Created by hoanghongkhang on 6/24/17.
 */
package view {
    import flash.display.Sprite;
    import flash.events.Event;

    public class TerminalView extends Sprite{

        private var _width:Number;
        private var _height:Number;

        public function TerminalView() {
            init();
        }

        public function init() : void
        {
            addEventListener(Event.ADDED_TO_STAGE, __addedToStage);
        }

        private function __addedToStage() : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, __addedToStage);
            _width = stage.stageWidth;
            _height = stage.stageHeight;
            graphics.beginFill(0, 0.5);
            graphics.drawRect(0,0,_width,_height);

        }

    }
}
