package consortionBattle.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import consortionBattle.event.ConsBatEvent;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import flash.events.Event;   import road7th.comm.PackageIn;      public class ConsBatChatView extends Sprite implements Disposeable   {                   private var _cellList:Array;            private var _dataList:Array;            public function ConsBatChatView() { super(); }
            private function initView() : void { }
            private function guardCompleteHandler(event:Event) : void { }
            private function disappearCompleteHandler(event:Event) : void { }
            private function changeCellIndex(cell:ConsBatChatViewCell) : void { }
            private function getTxtStr(data:Object) : String { return null; }
            private function initEvent() : void { }
            private function getMessageHandler(event:ConsBatEvent) : void { }
            private function setCellTxt() : void { }
            public function dispose() : void { }
   }}