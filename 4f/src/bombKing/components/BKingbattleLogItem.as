package bombKing.components
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import bombKing.data.BKingLogInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   
   public class BKingbattleLogItem extends Sprite implements Disposeable
   {
       
      
      private var _infoTxt:FilterFrameText;
      
      private var _logTxt:FilterFrameText;
      
      private var _info:BKingLogInfo;
      
      public function BKingbattleLogItem(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __linkHandler(param1:TextEvent) : void{}
      
      public function get info() : BKingLogInfo{return null;}
      
      public function set info(param1:BKingLogInfo) : void{}
      
      private function getTitle(param1:int) : String{return null;}
      
      private function getResultStr(param1:Boolean) : Array{return null;}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
