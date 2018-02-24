package BombTurnTable.view
{
   import BombTurnTable.BombTurnTableControls;
   import BombTurnTable.data.BombTurnTableFactory;
   import BombTurnTable.data.BombTurnTableInfo;
   import BombTurnTable.event.TurnTableEvent;
   import BombTurnTable.view.quality.BaseTurnTable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import flash.display.Sprite;
   
   public class TurnTableView extends Sprite implements Disposeable
   {
       
      
      private var _curTurnTable:BaseTurnTable = null;
      
      private var _curData:BombTurnTableInfo = null;
      
      private var _control:BombTurnTableControls;
      
      public function TurnTableView(param1:BombTurnTableControls){super();}
      
      public function updateView(param1:BombTurnTableInfo) : void{}
      
      public function updateLotteryTicket(param1:int) : void{}
      
      protected function clickLottery_Handler(param1:TurnTableEvent) : void{}
      
      public function startLottery(param1:int) : void{}
      
      public function updateTurnTableBtnStatus(param1:Boolean) : void{}
      
      public function lotteryComplate_Handler(param1:TurnTableEvent) : void{}
      
      public function dispose() : void{}
   }
}
