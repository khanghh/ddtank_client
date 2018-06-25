package BombTurnTable
{
   import BombTurnTable.data.BombTurnTableGoodInfo;
   import BombTurnTable.data.BombTurnTableInfo;
   import BombTurnTable.event.TurnTableEvent;
   import BombTurnTable.view.BombTurnTableFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class BombTurnTableControls extends EventDispatcher
   {
      
      private static var _instance:BombTurnTableControls;
       
      
      private var _manager:BombTurnTableManager;
      
      private var _frame:BombTurnTableFrame;
      
      private var _curTurnTableInfo:BombTurnTableInfo;
      
      private var _isStart:Boolean = false;
      
      private var _isSingleLottery:Boolean = true;
      
      private var _curLotteryStatus:int = 1;
      
      public function BombTurnTableControls()
      {
         super();
      }
      
      public static function get instance() : BombTurnTableControls
      {
         if(!_instance)
         {
            _instance = new BombTurnTableControls();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _curTurnTableInfo = new BombTurnTableInfo();
         BombTurnTableManager.instance.addEventListener("TurnTableOpenView",onShowView);
      }
      
      private function onShowView(evt:CEvent) : void
      {
         var isValid:Boolean = BombTurnTableManager.instance.isValid;
         if(isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.activityTime.exceed"));
            return;
         }
         _isStart = false;
         isSingleLottery = true;
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _frame = ComponentFactory.Instance.creat("bombTurnTable.bombTurnTableFrame",[this]);
         if(_frame)
         {
            LayerManager.Instance.addToLayer(_frame,3,true,1);
            addEvents();
            BombTurnTableManager.instance.requestViewData();
         }
      }
      
      protected function viewData_Handler(evt:PkgEvent) : void
      {
         var temGoodInfo:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         _curTurnTableInfo = new BombTurnTableInfo();
         _curTurnTableInfo.level = pkg.readInt();
         var turnTableCount:int = pkg.readInt();
         for(i = 0; i < turnTableCount; )
         {
            temGoodInfo = new BombTurnTableGoodInfo();
            temGoodInfo.place = pkg.readInt();
            temGoodInfo.templateId = pkg.readInt();
            temGoodInfo.goodCount = pkg.readInt();
            temGoodInfo.validDate = pkg.readInt();
            temGoodInfo.sex = pkg.readInt();
            temGoodInfo.isReceive = pkg.readInt();
            _curTurnTableInfo.goodsInfo.push(temGoodInfo);
            i++;
         }
         if(turnTableCount == 8)
         {
            dispatchEvent(new TurnTableEvent("updateTurntableData",_curTurnTableInfo));
            if(!_isSingleLottery)
            {
               myDelayedFunction();
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.dataErrorMsg"));
         }
      }
      
      public function myDelayedFunction() : void
      {
         if(!_isSingleLottery && !_isStart && checkLotteryCondition())
         {
            sendStartLottery();
         }
      }
      
      protected function winningInfo_Handler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var index:int = pkg.readInt();
         if(_frame && _frame.turnTableView)
         {
            updateBtnState(false);
            _isStart = true;
            _frame.turnTableView.startLottery(index);
         }
      }
      
      private function lottery_Handler(evt:TurnTableEvent) : void
      {
         switch(int(int(evt.data)))
         {
            case 0:
               isSingleLottery = true;
               if(_frame)
               {
                  _frame.turnTableView.updateTurnTableBtnStatus(false);
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.lottery.stopContinuonsLottery"),0,true);
               break;
            case 1:
               if(_isStart)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.lotteryProcessingMsg"));
               }
               else if(checkLotteryCondition())
               {
                  isSingleLottery = true;
                  sendStartLottery();
               }
               break;
            case 2:
               if(checkLotteryCondition())
               {
                  isSingleLottery = false;
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bombTurnTable.lottery.openContinuonsLottery"),0,true);
                  if(_frame)
                  {
                     _frame.turnTableView.updateTurnTableBtnStatus(true);
                  }
                  if(!_isStart)
                  {
                     sendStartLottery();
                  }
               }
         }
      }
      
      private function checkLotteryCondition() : Boolean
      {
         var haveTicket:int = 0;
         var needTicket:int = 0;
         var temStr:* = null;
         if(_curTurnTableInfo)
         {
            haveTicket = getLotteryTicket();
            needTicket = ServerConfigManager.instance.getNeedUseLotteryKicket(_curTurnTableInfo.quality);
            if(BombTurnTableManager.instance.isValid || haveTicket < needTicket)
            {
               if(BombTurnTableManager.instance.isValid)
               {
                  temStr = "ddt.activityTime.exceed";
               }
               else
               {
                  temStr = "ddt.bombTurnTable.ticketLackingMsg";
               }
               _isStart = false;
               isSingleLottery = true;
               if(_frame)
               {
                  _frame.turnTableView.updateTurnTableBtnStatus(false);
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(temStr),0,true);
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function sendStartLottery() : void
      {
         BombTurnTableManager.instance.sendStartLottery();
      }
      
      private function updateBtnState(value:Boolean = false) : void
      {
         if(_frame)
         {
            _frame.closeButton.enable = value;
         }
      }
      
      private function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,53),viewData_Handler);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,54),winningInfo_Handler);
         BombTurnTableManager.instance.addEventListener("TurnTableEnd",_turntableEnd_Handler);
         if(_frame)
         {
            _frame.turnTableView.addEventListener("ClickLottery",lottery_Handler);
         }
         if(_frame)
         {
            _frame.addEventListener("response",__responseHandler);
         }
         if(_frame)
         {
            _frame.turnTableView.addEventListener("lotteryComplate",_lotteryComplate_Handler);
         }
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(329,53),viewData_Handler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(329,54),winningInfo_Handler);
         BombTurnTableManager.instance.removeEventListener("TurnTableEnd",_turntableEnd_Handler);
         if(_frame)
         {
            _frame.turnTableView.removeEventListener("ClickLottery",lottery_Handler);
         }
         if(_frame)
         {
            _frame.removeEventListener("response",__responseHandler);
         }
         if(_frame)
         {
            _frame.turnTableView.removeEventListener("lotteryComplate",_lotteryComplate_Handler);
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(!_isStart && (evt.responseCode == 0 || evt.responseCode == 1))
         {
            SoundManager.instance.playButtonSound();
            if(_frame)
            {
               removeEvents();
               ObjectUtils.disposeObject(_frame);
               _frame = null;
            }
         }
      }
      
      private function _turntableEnd_Handler(evt:TurnTableEvent) : void
      {
         if(curLotteryStatus == 2)
         {
            isSingleLottery = true;
            _isStart = false;
            updateBtnState(true);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.activityTime.exceed"));
            if(_frame)
            {
               _frame.turnTableView.updateTurnTableBtnStatus(false);
            }
         }
      }
      
      public function getLotteryTicket(id:int = 12554) : int
      {
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         return bagInfo.getItemCountByTemplateId(id);
      }
      
      private function _lotteryComplate_Handler(evt:TurnTableEvent) : void
      {
         updateBtnState(true);
         _isStart = false;
         BombTurnTableManager.instance.requestViewData();
      }
      
      private function get isSingleLottery() : Boolean
      {
         return _isSingleLottery;
      }
      
      private function set isSingleLottery(value:Boolean) : void
      {
         _isSingleLottery = value;
         _curLotteryStatus = !!value?1:2;
      }
      
      public function get curLotteryStatus() : int
      {
         return _curLotteryStatus;
      }
   }
}
