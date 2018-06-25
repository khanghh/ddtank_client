package devilTurn.view{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import devilTurn.DevilTurnManager;   import devilTurn.control.DevilTurnControl;   import devilTurn.model.DevilTurnGoodsItem;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import road7th.data.DictionaryData;      public class DevilTurnLotteryView extends Sprite implements Disposeable   {                   private var _cellList:Vector.<DevilTurnCell>;            private var _indexList:DictionaryData;            private var _shine:Bitmap;            private var _treasureView:DevilTurnTreasureView;            private var _lotteryControl:DevilTurnControl;            private var _result:Array;            public function DevilTurnLotteryView(view:DevilTurnTreasureView) { super(); }
            public function get isRunning() : Boolean { return false; }
            private function init() : void { }
            private function initEvent() : void { }
            private function __onSacrifice(e:PkgEvent) : void { }
            private function __onTurnComplete(e:Event) : void { }
            private function closeCall() : void { }
            private function removeEvent() : void { }
            private function getCellBg() : Shape { return null; }
            public function dispose() : void { }
   }}