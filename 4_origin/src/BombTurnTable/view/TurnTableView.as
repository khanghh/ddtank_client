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
      
      public function TurnTableView(param1:BombTurnTableControls)
      {
         _control = param1;
         super();
      }
      
      public function updateView(param1:BombTurnTableInfo) : void
      {
         _curData = param1;
         if(_curData == null)
         {
            return;
         }
         if(_curTurnTable)
         {
            if(_curTurnTable.quality != _curData.quality)
            {
               if(_curTurnTable.quality > _curData.quality)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.lottery.degrade.returnLotteryTicket",ServerConfigManager.instance.getNeedUseLotteryKicket(_curData.quality)),0,true);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.lottery.grade.returnLotteryTicket",ServerConfigManager.instance.getNeedUseLotteryKicket(_curData.quality)),0,true);
               }
               ObjectUtils.disposeObject(_curTurnTable);
               _curTurnTable = null;
            }
            else
            {
               _curTurnTable.clear();
            }
         }
         if(_curTurnTable == null)
         {
            _curTurnTable = BombTurnTableFactory.instance.createTurnTable(_curData.level,_control.curLotteryStatus);
            _curTurnTable.addEventListener("ClickLottery",clickLottery_Handler);
            _curTurnTable.addEventListener("lotteryComplate",lotteryComplate_Handler);
            addChild(_curTurnTable);
         }
         _curTurnTable.updateAwardGood(_curData);
      }
      
      public function updateLotteryTicket(param1:int) : void
      {
         _curTurnTable.updateLotteryTicket(param1);
      }
      
      protected function clickLottery_Handler(param1:TurnTableEvent) : void
      {
         this.dispatchEvent(new TurnTableEvent("ClickLottery",param1.data));
      }
      
      public function startLottery(param1:int) : void
      {
         if(_curTurnTable)
         {
            _curTurnTable.startLottery(param1);
         }
      }
      
      public function updateTurnTableBtnStatus(param1:Boolean) : void
      {
         _curTurnTable.lotteryBtn.updateBtnStatus(param1);
      }
      
      public function lotteryComplate_Handler(param1:TurnTableEvent) : void
      {
         this.dispatchEvent(new TurnTableEvent("lotteryComplate",null));
      }
      
      public function dispose() : void
      {
         if(_curTurnTable)
         {
            _curTurnTable.removeEventListener("ClickLottery",clickLottery_Handler);
            _curTurnTable.removeEventListener("lotteryComplate",lotteryComplate_Handler);
            ObjectUtils.disposeObject(_curTurnTable);
         }
         _curTurnTable = null;
         _control = null;
         _curData = null;
      }
   }
}
