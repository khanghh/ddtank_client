package bombKing.components{   import bombKing.BombKingControl;   import bombKing.BombKingManager;   import bombKing.data.BKingLogInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import flash.display.Sprite;   import flash.events.TextEvent;      public class BKingbattleLogItem extends Sprite implements Disposeable   {                   private var _infoTxt:FilterFrameText;            private var _logTxt:FilterFrameText;            private var _info:BKingLogInfo;            public function BKingbattleLogItem() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __linkHandler(event:TextEvent) : void { }
            public function get info() : BKingLogInfo { return null; }
            public function set info(info:BKingLogInfo) : void { }
            private function getTitle(stage:int) : String { return null; }
            private function getResultStr(result:Boolean) : Array { return null; }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}