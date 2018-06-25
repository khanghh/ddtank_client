package gameCommon.view.playerThumbnail{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;      public class BossBloodItem extends Sprite implements Disposeable   {                   private var _totalBlood:Number;            private var _bloodNum:Number;            private var _maskShape:Shape;            private var _HPTxt:FilterFrameText;            private var _bg:Bitmap;            private var _rateTxt:FilterFrameText;            public function BossBloodItem(totalBlood:Number) { super(); }
            public function set bloodNum(value:Number) : void { }
            public function updateBlood(current:Number, max:Number) : void { }
            private function updateView() : void { }
            private function getRate(value1:Number, value2:Number) : int { return 0; }
            public function dispose() : void { }
   }}