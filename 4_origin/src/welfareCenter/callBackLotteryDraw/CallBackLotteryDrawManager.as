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
      
      public function CallBackLotteryDrawManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function queryLotteryGoods($type:int) : void
      {
         type = $type;
         SocketManager.Instance.out.refreshCallLotteryDrawInfo(type);
         SocketManager.Instance.out.queryCallLotteryDrawGoods(type);
      }
      
      private function onPackTypeInfo(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         initModel(callBackLotteryDrawModel,pkg);
         initModel(luckeyLotteryDrawModel,pkg);
         var isZeroFresh:Boolean = pkg.readBoolean();
         if(isZeroFresh)
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
      
      private function onTimerTick(evt:TimerEvent) : void
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
         var timeArr:Array = TimeManager.getHHMMSSArr(_firstEnterCdSec);
         if(timeArr)
         {
            HallIconManager.instance.updateSwitchHandler("luckLotteryDraw",luckeyLotteryDrawModel.isOpen,timeArr.join(":"));
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("luckLotteryDraw",luckeyLotteryDrawModel.isOpen,"");
         }
      }
      
      private function onCheckOpenCallBackTimer(evt:TimerEvent) : void
      {
         checkCallBackActiveOpen();
         if(!callBackLotteryDrawModel.isOpen)
         {
            _callBackTimer.removeEventListener("timer",onCheckOpenCallBackTimer);
            _callBackTimer.stop();
            WelfareCenterManager.instance.showMainIcon();
         }
      }
      
      private function onCheckOpenLuckeyTimer(evt:TimerEvent) : void
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
         var nowDateTime:Number = TimeManager.Instance.NowTime();
         if(nowDateTime >= callBackLotteryDrawModel.startTime.time && nowDateTime <= callBackLotteryDrawModel.endTime.time && PlayerManager.Instance.Self.isOld2)
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
         var nowDateTime:Number = TimeManager.Instance.NowTime();
         if(nowDateTime >= luckeyLotteryDrawModel.startTime.time && nowDateTime <= luckeyLotteryDrawModel.endTime.time)
         {
            if(luckeyLotteryDrawModel.phase < luckeyLotteryDrawModel.phaseEndTimeArr.length - 1 || luckeyLotteryDrawModel.phase >= luckeyLotteryDrawModel.phaseEndTimeArr.length - 1 && luckeyLotteryDrawModel.currPhaseHasGetCount < 5)
            {
               luckeyLotteryDrawModel.isOpen = true;
            }
         }
      }
      
      private function initModel(model:LotteryDrawModel, pkg:PackageIn) : void
      {
         var i:int = 0;
         var phaseEndTime:* = null;
         model.startTime = pkg.readDate();
         model.endTime = pkg.readDate();
         model.phase = pkg.readInt();
         model.currPhaseHasGetCount = pkg.readInt();
         model.lastRefreshTime = pkg.readDate();
         model.phaseEndTimeArr = [];
         var phaseEndTimeArrLength:int = pkg.readInt();
         for(i = 0; i < phaseEndTimeArrLength; )
         {
            phaseEndTime = {
               "Order":pkg.readInt(),
               "Time":pkg.readInt()
            };
            model.phaseEndTimeArr.push(phaseEndTime);
            i++;
         }
         if(phaseEndTimeArrLength > 0)
         {
            model.phaseEndTimeArr.sortOn("Order",16);
         }
      }
      
      private function onPackTypeGoods(evt:PkgEvent) : void
      {
         var model:* = null;
         var i:int = 0;
         var index:int = 0;
         var award:* = null;
         var templeteInfo:* = null;
         var inventoryItemInfo:* = null;
         var pkg:PackageIn = evt.pkg;
         var type:int = pkg.readInt();
         if(type == 0)
         {
            model = callBackLotteryDrawModel;
         }
         else
         {
            model = luckeyLotteryDrawModel;
         }
         var awardArr:Array = [];
         var awardArrLength:int = pkg.readInt();
         for(i = 0; i < awardArrLength; )
         {
            index = pkg.readInt();
            pkg.readInt();
            award = {
               "Index":index,
               "LimitCount":pkg.readInt(),
               "TemplateID":pkg.readInt(),
               "Count":pkg.readInt(),
               "VaildDate":pkg.readInt(),
               "Cost":pkg.readInt(),
               "IsCanGet":pkg.readBoolean()
            };
            templeteInfo = ItemManager.Instance.getTemplateById(award["TemplateID"]);
            inventoryItemInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(inventoryItemInfo,templeteInfo);
            inventoryItemInfo.ValidDate = award["ValidDate"];
            inventoryItemInfo.Count = award["Count"];
            inventoryItemInfo.IsBinds = true;
            award["InventoryItemInfo"] = inventoryItemInfo;
            awardArr.push(award);
            i++;
         }
         model.awardArr = awardArr;
         if(model.isOpen)
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
      
      public function onPackTypeBuy(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var type:int = pkg.readInt();
         var index:int = pkg.readInt();
         var IsCanGet:Boolean = pkg.readBoolean();
         var res:* = !IsCanGet;
         var data:Object = {
            "index":index,
            "res":res
         };
         if(type == 0)
         {
            if(res)
            {
               callBackLotteryDrawModel.awardArr[index]["IsCanGet"] = false;
               if(callBackLotteryDrawModel.currPhaseHasGetCount > 1)
               {
                  callBackLotteryDrawModel.currPhaseHasGetCount++;
               }
            }
         }
         else if(type == 1)
         {
            if(res)
            {
               luckeyLotteryDrawModel.awardArr[index]["IsCanGet"] = false;
               if(luckeyLotteryDrawModel.currPhaseHasGetCount > 1)
               {
                  luckeyLotteryDrawModel.currPhaseHasGetCount++;
               }
            }
         }
         dispatchEvent(new CEvent("event_op_back_buy",data));
      }
   }
}
