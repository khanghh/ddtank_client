package petsBag.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import pet.data.PetInfo;      public class PetHappyBar extends Component implements Disposeable   {            public static const petPercentArray:Array = ["0%","60%","80%","100%"];            public static const fullHappyValue:int = 10000;                   private var SPACE:int = 2;            private var COUNT:int = 3;            private var _bgImgVec:Vector.<Bitmap>;            private var _heartImgVec:Vector.<Bitmap>;            private var _info:PetInfo;            private var _lv:Bitmap;            private var _lvTxt:FilterFrameText;            public function PetHappyBar() { super(); }
            public function get info() : PetInfo { return null; }
            public function set info(value:PetInfo) : void { }
            private function gapWidth() : Number { return 0; }
            private function initView() : void { }
            private function set happyStatus(type:int) : void { }
            private function update(count:int) : void { }
            private function remove() : void { }
            override public function dispose() : void { }
   }}