package carnivalActivity.view{   import carnivalActivity.RookieRankInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITransformableTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class RookieRankTip extends Sprite implements ITransformableTip, Disposeable   {                   private var rankTitleTxt:FilterFrameText;            private var nickNameTitleTxt:FilterFrameText;            private var fightPowerTitleTxt:FilterFrameText;            private var _bg:ScaleBitmapImage;            private var _tipWidth:int;            private var _tipHeight:int;            private var _txtVec:Vector.<FilterFrameText>;            private var _ruleArray:Array;            private var _data:Array;            private var _itemArr:Array;            public function RookieRankTip() { super(); }
            private function initView() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}