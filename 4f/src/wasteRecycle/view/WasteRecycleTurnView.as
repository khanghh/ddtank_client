package wasteRecycle.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Timer;   import wasteRecycle.WasteRecycleController;      public class WasteRecycleTurnView extends Sprite implements Disposeable   {                   private var _list:Vector.<WasteRecycleTurnItem>;            private var _timer:Timer;            private var _playLabel:Array;            private var _str:String;            private var _playCount:int;            public function WasteRecycleTurnView() { super(); }
            private function init() : void { }
            public function playAction(type:int, str:String) : void { }
            private function setPlayLabel(type:int) : void { }
            private function __onTimer(e:Event) : void { }
            private function __onPlayComplete(e:Event) : void { }
            private function __onShineComplete(e:Event) : void { }
            public function dispose() : void { }
   }}