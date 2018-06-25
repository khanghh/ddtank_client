package campbattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class CampStateHideBtn extends Sprite   {            public static const HIDE_PLAYER:String = "hidePlayer";                   private var _mc:MovieClip;            private var _isHide:Boolean = false;            public function CampStateHideBtn() { super(); }
            private function initView() : void { }
            public function get isHide() : Boolean { return false; }
            private function mouseClickHander(e:MouseEvent) : void { }
            public function turnMC() : void { }
            public function dispose() : void { }
   }}