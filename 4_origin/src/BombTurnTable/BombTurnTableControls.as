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
      
      private function onShowView(param1:CEvent) : void
      {
         var _loc2_:Boolean = BombTurnTableManager.instance.isValid;
         if(_loc2_)
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
      
      protected function viewData_Handler(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         _curTurnTableInfo = new BombTurnTableInfo();
         _curTurnTableInfo.level = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = new BombTurnTableGoodInfo();
            _loc3_.place = _loc4_.readInt();
            _loc3_.templateId = _loc4_.readInt();
            _loc3_.goodCount = _loc4_.readInt();
            _loc3_.validDate = _loc4_.readInt();
            _loc3_.sex = _loc4_.readInt();
            _loc3_.isReceive = _loc4_.readInt();
            _curTurnTableInfo.goodsInfo.push(_loc3_);
            _loc5_++;
         }
         if(_loc2_ == 8)
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
      
      protected function winningInfo_Handler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_frame && _frame.turnTableView)
         {
            updateBtnState(false);
            _isStart = true;
            _frame.turnTableView.startLottery(_loc2_);
         }
      }
      
      private function lottery_Handler(param1:TurnTableEvent) : void
      {
         switch(int(param1.data))
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         if(_curTurnTableInfo)
         {
            _loc2_ = getLotteryTicket();
            _loc1_ = ServerConfigManager.instance.getNeedUseLotteryKicket(_curTurnTableInfo.quality);
            if(BombTurnTableManager.instance.isValid || _loc2_ < _loc1_)
            {
               if(BombTurnTableManager.instance.isValid)
               {
                  _loc3_ = "ddt.activityTime.exceed";
               }
               else
               {
                  _loc3_ = "ddt.bombTurnTable.ticketLackingMsg";
               }
               _isStart = false;
               isSingleLottery = true;
               if(_frame)
               {
                  _frame.turnTableView.updateTurnTableBtnStatus(false);
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(_loc3_),0,true);
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
      
      private function updateBtnState(param1:Boolean = false) : void
      {
         if(_frame)
         {
            _frame.closeButton.enable = param1;
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
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(!_isStart && (param1.responseCode == 0 || param1.responseCode == 1))
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
      
      private function _turntableEnd_Handler(param1:TurnTableEvent) : void
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
      
      public function getLotteryTicket(param1:int = 12554) : int
      {
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         return _loc2_.getItemCountByTemplateId(param1);
      }
      
      private function _lotteryComplate_Handler(param1:TurnTableEvent) : void
      {
         updateBtnState(true);
         _isStart = false;
         BombTurnTableManager.instance.requestViewData();
      }
      
      private function get isSingleLottery() : Boolean
      {
         return _isSingleLottery;
      }
      
      private function set isSingleLottery(param1:Boolean) : void
      {
         _isSingleLottery = param1;
         _curLotteryStatus = !!param1?1:2;
      }
      
      public function get curLotteryStatus() : int
      {
         return _curLotteryStatus;
      }
   }
}
