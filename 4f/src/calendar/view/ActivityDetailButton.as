package calendar.view{   import com.greensock.TweenMax;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.utils.DisplayUtils;      public class ActivityDetailButton extends BaseButton   {                   private var _state:int = 0;            private var _tweenMax:TweenMax;            public function ActivityDetailButton() { super(); }
            public function set state(state:int) : void { }
            override public function dispose() : void { }
            public function get state() : int { return 0; }
            override public function setFrame(frameIndex:int) : void { }
   }}