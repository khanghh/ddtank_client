package bagAndInfo.ddtKingGrade{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import road7th.utils.MovieClipWrapper;      public class DDTKingGradeSelectedButton extends SelectedButton   {                   private var _text:FilterFrameText;            private var _actionStyle:String;            private var _level:int = 0;            private var _cost:int = 0;            public function DDTKingGradeSelectedButton() { super(); }
            public function set actionStyle(value:String) : void { }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function setFrame(frameIndex:int) : void { }
            public function playAction() : void { }
            public function set level(value:int) : void { }
            public function get level() : int { return 0; }
            public function set cost(value:int) : void { }
            public function get cost() : int { return 0; }
            override public function dispose() : void { }
   }}