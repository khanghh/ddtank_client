package welfareCenter.callBackLotteryDraw
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.LuckeyLotteryDrawIcon;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import welfareCenter.WelfareCenterManager;
   
   public class CallBackLotteryDrawManager extends CoreManager
   {
      
      public static const TYPE_CALLBACK:int = 0;
      
      public static const TYPE_LUCKEY:int = 1;
      
      public static const EACH_PHASE_CARD_NUM:int = 5;
      
      public static const EVENT_OPEN_FRAME:String = "event_open_frame";
      
      public static const EVENT_ZERO_FRESH:String = "event_zero_fresh";
      
      public static const EVENT_INFO_CHANGE:String = "event_info_change";
      
      public static const EVENT_OP_BACK_BUY:String = "event_op_back_buy";
      
      public static const CLICK_CARD_OPEN_ITEM:String = "click_card_open_item";
      
      public static const CLICK_CARD_OPEN_PLAY_OVER:String = "click_card_open_play_over";
      
      public static var _firstEnterCdSec:int;
      
      private static var _instance:CallBackLotteryDrawManager;
       
      
      public var callBackLotteryDrawModel:LotteryDrawModel;
      
      public var luckeyLotteryDrawModel:LotteryDrawModel;
      
      public var type:int;
      
      private var _callBackTimer:Timer;
      
      private var _luckeyTimer:Timer;
      
      private var _timer:Timer;
      
      private var _luckeyLotteryDrawIcon:LuckeyLotteryDrawIcon;
      
      public function CallBackLotteryDrawManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _instance = this;
         callBackLotteryDrawModel = new LotteryDrawModel();
         luckeyLotteryDrawModel = new LotteryDrawModel();
      }
      
      public static function get instance() : CallBackLotteryDrawManager
      {
         if(_instance == null)
         {
            _instance = new CallBackLotteryDrawManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(343,8),onPackTypeInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,9),onPackTypeGoods);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,4),onPackTypeBuy);
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["welfareCenter"],function():void
         {
            queryLotteryGoods(type);
         });
      }
      
      public function queryLotteryGoods(param1:int) : void
      {
         type = param1;
         SocketManager.Instance.out.refreshCallLotteryDrawInfo(type);
         SocketManager.Instance.out.queryCallLotteryDrawGoods(type);
      }
      
      private function onPackTypeInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         initModel(callBackLotteryDrawModel,_loc2_);
         initModel(luckeyLotteryDrawModel,_loc2_);
         var _loc3_:Boolean = _loc2_.readBoolean();
         if(_loc3_)
         {
            dispatchEvent(new Event("event_zero_fresh"));
         }
         checkCallBackActiveOpen();
         checkLuckeyActiveOpen();
         checkLuckIconAndShowIcon();
         WelfareCenterManager.instance.showMainIcon();
         if(callBackLotteryDrawModel.isOpen)
         {
            if(_callBackTimer)
            {
               _callBackTimer.reset();
            }
            else
            {
               _callBackTimer = new Timer(1000,2147483647);
            }
            _callBackTimer.start();
            _callBackTimer.addEventListener("timer",onCheckOpenCallBackTimer);
         }
         if(luckeyLotteryDrawModel.isOpen)
         {
            if(_luckeyTimer)
            {
               _luckeyTimer.reset();
            }
            else
            {
               _luckeyTimer = new Timer(1000,2147483647);
            }
            _luckeyTimer.start();
            _luckeyTimer.addEventListener("timer",onCheckOpenLuckeyTimer);
         }
         dispatchEvent(new Event("event_info_change"));
      }
      
      public function checkLuckIconAndShowIcon() : void
      {
         _firstEnterCdSec = CallBackLotteryDrawManager.instance.getLuckeyLeftSec();
         if(_firstEnterCdSec > 0)
         {
            _timer = new Timer(1000,_firstEnterCdSec);
            _timer.addEventListener("timer",onTimerTick);
            _timer.start();
         }
         else
         {
            _firstEnterCdSec = 0;
            HallIconManager.instance.updateSwitchHandler("luckLotteryDraw",luckeyLotteryDrawModel.isOpen);
         }
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         _firstEnterCdSec = CallBackLotteryDrawManager.instance.getLuckeyLeftSec();
         _firstEnterCdSec = Number(_firstEnterCdSec) - 1;
         if(_firstEnterCdSec <= 0)
         {
            _firstEnterCdSec = 0;
            _timer.stop();
            _timer.removeEventListener("timer",onTimerTick);
         }
         updateLeftTimeTf();
      }
      
      private function updateLeftTimeTf() : void
      {
         var _loc1_:Array = TimeManager.getHHMMSSArr(_firstEnterCdSec);
         if(_loc1_)
         {
            HallIconManager.instance.updateSwitchHandler("luckLotteryDraw",luckeyLotteryDrawModel.isOpen,_loc1_.join(":"));
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("luckLotteryDraw",luckeyLotteryDrawModel.isOpen,"");
         }
      }
      
      private function onCheckOpenCallBackTimer(param1:TimerEvent) : void
      {
         checkCallBackActiveOpen();
         if(!callBackLotteryDrawModel.isOpen)
         {
            _callBackTimer.removeEventListener("timer",onCheckOpenCallBackTimer);
            _callBackTimer.stop();
            WelfareCenterManager.instance.showMainIcon();
         }
      }
      
      private function onCheckOpenLuckeyTimer(param1:TimerEvent) : void
      {
         checkLuckeyActiveOpen();
         if(!luckeyLotteryDrawModel.isOpen)
         {
            _luckeyTimer.removeEventListener("timer",onCheckOpenLuckeyTimer);
            _luckeyTimer.stop();
            WelfareCenterManager.instance.showMainIcon();
         }
      }
      
      public function checkCallBackActiveOpen() : void
      {
         WelfareCenterManager.instance.checkShineIcon();
         callBackLotteryDrawModel.isOpen = false;
         var _loc1_:Number = TimeManager.Instance.NowTime();
         if(_loc1_ >= callBackLotteryDrawModel.startTime.time && _loc1_ <= callBackLotteryDrawModel.endTime.time && PlayerManager.Instance.Self.isOld2)
         {
            if(callBackLotteryDrawModel.phase < callBackLotteryDrawModel.phaseEndTimeArr.length - 1 || callBackLotteryDrawModel.phase >= callBackLotteryDrawModel.phaseEndTimeArr.length - 1 && callBackLotteryDrawModel.currPhaseHasGetCount < 5)
            {
               callBackLotteryDrawModel.isOpen = true;
            }
         }
      }
      
      public function checkLuckeyActiveOpen() : void
      {
         luckeyLotteryDrawModel.isOpen = false;
         var _loc1_:Number = TimeManager.Instance.NowTime();
         if(_loc1_ >= luckeyLotteryDrawModel.startTime.time && _loc1_ <= luckeyLotteryDrawModel.endTime.time)
         {
            if(luckeyLotteryDrawModel.phase < luckeyLotteryDrawModel.phaseEndTimeArr.length - 1 || luckeyLotteryDrawModel.phase >= luckeyLotteryDrawModel.phaseEndTimeArr.length - 1 && luckeyLotteryDrawModel.currPhaseHasGetCount < 5)
            {
               luckeyLotteryDrawModel.isOpen = true;
            }
         }
      }
      
      private function initModel(param1:LotteryDrawModel, param2:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         param1.startTime = param2.readDate();
         param1.endTime = param2.readDate();
         param1.phase = param2.readInt();
         param1.currPhaseHasGetCount = param2.readInt();
         param1.lastRefreshTime = param2.readDate();
         param1.phaseEndTimeArr = [];
         var _loc3_:int = param2.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = {
               "Order":param2.readInt(),
               "Time":param2.readInt()
            };
            param1.phaseEndTimeArr.push(_loc4_);
            _loc5_++;
         }
         if(_loc3_ > 0)
         {
            param1.phaseEndTimeArr.sortOn("Order",16);
         }
      }
      
      private function onPackTypeGoods(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc11_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc9_:int = _loc7_.readInt();
         if(_loc9_ == 0)
         {
            _loc3_ = callBackLotteryDrawModel;
         }
         else
         {
            _loc3_ = luckeyLotteryDrawModel;
         }
         var _loc8_:Array = [];
         var _loc10_:int = _loc7_.readInt();
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            _loc2_ = _loc7_.readInt();
            _loc7_.readInt();
            _loc6_ = {
               "Index":_loc2_,
               "LimitCount":_loc7_.readInt(),
               "TemplateID":_loc7_.readInt(),
               "Count":_loc7_.readInt(),
               "VaildDate":_loc7_.readInt(),
               "Cost":_loc7_.readInt(),
               "IsCanGet":_loc7_.readBoolean()
            };
            _loc5_ = ItemManager.Instance.getTemplateById(_loc6_["TemplateID"]);
            _loc4_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc4_,_loc5_);
            _loc4_.ValidDate = _loc6_["ValidDate"];
            _loc4_.Count = _loc6_["Count"];
            _loc4_.IsBinds = true;
            _loc6_["InventoryItemInfo"] = _loc4_;
            _loc8_.push(_loc6_);
            _loc11_++;
         }
         _loc3_.awardArr = _loc8_;
         if(_loc3_.isOpen)
         {
            dispatchEvent(new Event("event_open_frame"));
         }
      }
      
      public function getCallBackLeftSec() : int
      {
         if(callBackLotteryDrawModel.phase != 0 && callBackLotteryDrawModel.currPhaseHasGetCount == 0)
         {
            return 0;
         }
         if(callBackLotteryDrawModel.phase < callBackLotteryDrawModel.phaseEndTimeArr.length)
         {
            return (callBackLotteryDrawModel.lastRefreshTime.time + callBackLotteryDrawModel.phaseEndTimeArr[callBackLotteryDrawModel.phase].Time * 1000 - TimeManager.Instance.Now().time) / 1000;
         }
         return 0;
      }
      
      public function getLuckeyLeftSec() : int
      {
         if(luckeyLotteryDrawModel.phase != 0 && luckeyLotteryDrawModel.currPhaseHasGetCount == 0)
         {
            return 0;
         }
         if(luckeyLotteryDrawModel.phase < luckeyLotteryDrawModel.phaseEndTimeArr.length)
         {
            return (luckeyLotteryDrawModel.lastRefreshTime.time + luckeyLotteryDrawModel.phaseEndTimeArr[luckeyLotteryDrawModel.phase].Time * 1000 - TimeManager.Instance.Now().time) / 1000;
         }
         return 0;
      }
      
      public function onPackTypeBuy(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc7_:int = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         var _loc6_:Boolean = _loc5_.readBoolean();
         var _loc2_:* = !_loc6_;
         var _loc4_:Object = {
            "index":_loc3_,
            "res":_loc2_
         };
         if(_loc7_ == 0)
         {
            if(_loc2_)
            {
               callBackLotteryDrawModel.awardArr[_loc3_]["IsCanGet"] = false;
               if(callBackLotteryDrawModel.currPhaseHasGetCount > 1)
               {
                  callBackLotteryDrawModel.currPhaseHasGetCount++;
               }
            }
         }
         else if(_loc7_ == 1)
         {
            if(_loc2_)
            {
               luckeyLotteryDrawModel.awardArr[_loc3_]["IsCanGet"] = false;
               if(luckeyLotteryDrawModel.currPhaseHasGetCount > 1)
               {
                  luckeyLotteryDrawModel.currPhaseHasGetCount++;
               }
            }
         }
         dispatchEvent(new CEvent("event_op_back_buy",_loc4_));
      }
   }
}
