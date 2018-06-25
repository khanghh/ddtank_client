package store{   import com.greensock.TweenMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.utils.StaticFormula;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class StoreTips extends Sprite implements Disposeable   {            public static const TRANSFER:int = 0;            public static const EMBED:int = 1;            public static const BEGIN_Y:int = 130;            public static const SPACING:String = " ";            public static const SPACINGII:String = " +";            public static const SPACINGIII:String = " ";            public static const Shield:int = 31;                   private var _timer:Timer;            private var _successBit:Bitmap;            private var _failBit:Bitmap;            private var _fiveFailBit:Bitmap;            private var _changeTxtI:FilterFrameText;            private var _changeTxtII:FilterFrameText;            private var _moveSprite:Sprite;            public var isDisplayerTip:Boolean = true;            private var _lastTipString:String = "";            public function StoreTips() { super(); }
            private function init() : void { }
            private function createTween(onComplete:Function = null, completeParam:Array = null) : void { }
            private function showPropertyChange(info:InventoryItemInfo) : String { return null; }
            private function showHoleTip(info:InventoryItemInfo) : String { return null; }
            private function showOpenHoleTip(info:InventoryItemInfo) : String { return null; }
            public function showSuccess(type:int = -1) : void { }
            public function showStrengthSuccess(info:InventoryItemInfo, isShowHoleTip:Boolean) : void { }
            private function strengthTweenComplete(content:String) : void { }
            public function showEmbedSuccess(info:InventoryItemInfo) : void { }
            private function embedTweenComplete() : void { }
            public function showFail() : void { }
            public function showFiveFail() : void { }
            private function __timerComplete(evt:TimerEvent) : void { }
            private function removeTips() : void { }
            public function dispose() : void { }
   }}