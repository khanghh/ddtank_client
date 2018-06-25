package superWinner.view.smallAwards{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;      public class SuperWinnerSmallAward extends Sprite implements Disposeable   {                   private var _type:uint;            private var _awardNumTxt:FilterFrameText;            public function SuperWinnerSmallAward($type:uint) { super(); }
            private function init() : void { }
            public function set awardNum(val:uint) : void { }
            public function get awardType() : uint { return null; }
            public function dispose() : void { }
   }}