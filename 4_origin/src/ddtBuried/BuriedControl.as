package ddtBuried
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.data.SearchGoodsData;
   import ddtBuried.data.UpdateStarData;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.map.MapArrays;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import labyrinth.LabyrinthControl;
   import road7th.comm.PackageIn;
   import treasureHunting.views.TransactionsDiceFrame;
   
   public class BuriedControl extends EventDispatcher
   {
      
      public static const MAP1:int = 1;
      
      public static const MAP2:int = 2;
      
      public static const MAP3:int = 3;
      
      private static var _instance:BuriedControl;
       
      
      public var mapArrays:MapArrays;
      
      private var _frame:BuriedFrame;
      
      private var _transactionsFrame:TransactionsDiceFrame;
      
      private var _shopframe:BuriedShopFrame;
      
      private var _curGainBoxIndex:int;
      
      public var reachEndRewardsIDs:Array;
      
      private var _manager:BuriedManager;
      
      public function BuriedControl()
      {
         super();
         mapArrays = new MapArrays();
         _manager = BuriedManager.Instance;
      }
      
      public static function get Instance() : BuriedControl
      {
         if(!BuriedControl._instance)
         {
            BuriedControl._instance = new BuriedControl();
         }
         return BuriedControl._instance;
      }
      
      public function getTakeCardPay() : String
      {
         return _manager.takeCardPayList[3 - _manager.takeCardLimit];
      }
      
      public function oneDegreeToTwoDegree(param1:String, param2:int, param3:int) : Array
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Array = param1.split(",");
         var _loc7_:int = 0;
         var _loc5_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < param3)
         {
            _loc5_[_loc6_] = [];
            _loc8_ = 0;
            while(_loc8_ < param2)
            {
               _loc5_[_loc6_][_loc8_] = int(_loc4_[_loc7_]);
               _loc7_++;
               _loc8_++;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function setup() : void
      {
         initEvents();
      }
      
      public function getUpdateData(param1:Boolean) : UpdateStarData
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = _manager.upDateStarList.length;
         if(param1)
         {
            _loc2_ = _manager.level + 1;
         }
         else
         {
            _loc2_ = _manager.level;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_ == _manager.upDateStarList[_loc4_].StarID)
            {
               return _manager.upDateStarList[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getPayData() : SearchGoodsData
      {
         var _loc2_:int = 0;
         var _loc1_:int = _manager.payMoneyList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_manager.currPayLevel == _manager.payMoneyList[_loc2_].Number)
            {
               return _manager.payMoneyList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(98,6),onGainRewards);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,17),playerRollDiceHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,18),playerUpgradeLevelEnterHander);
         BuriedControl.Instance.addEventListener("labyrith_over",openShopView);
         BuriedControl.Instance.addEventListener("mapover",mapOverHandler);
         BuriedManager.Instance.addEventListener("buriedOpenView",__onOpenView);
      }
      
      protected function mapOverHandler(param1:BuriedEvent) : void
      {
         e = param1;
         callBack = function(param1:int, param2:int, param3:Array):Boolean
         {
            if(param1 == reachTimes)
            {
               idx = param2;
               return true;
            }
            return false;
         };
         var reachTimes:int = _manager.timesReachEnd + 1;
         if(_manager.boxNeedTimesList.some(callBack,null))
         {
            _frame.updateShowGetRewardBoxAnimation(idx);
         }
      }
      
      public function requireGainRewards(param1:int) : void
      {
         _curGainBoxIndex = param1;
         SocketManager.Instance.out.sendSearchGoodsGainRewards(param1);
      }
      
      protected function onGainRewards(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _manager.stateRewardsGained = _loc2_.readInt();
         _manager.timesReachEnd = _loc2_.readInt();
         _frame.updatePlayGainedAnimation(_curGainBoxIndex);
      }
      
      private function playerRollDiceHander(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _manager.num = param1.pkg.readInt();
         _manager.timesBuyDice = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         _manager.nowPosition = param1.pkg.readInt();
         if(_manager.nowPosition == 35)
         {
            _manager.isOver = true;
         }
         if(_manager.nowPosition == 0)
         {
            dispatchEvent(new BuriedEvent("updatabtnstats"));
         }
         _manager.limit = _manager.num - _manager.pay_count;
         switch(int(_loc3_) - 1)
         {
            case 0:
               _frame.setCrFrame("one");
               break;
            case 1:
               _frame.setCrFrame("two");
               break;
            case 2:
               _frame.setCrFrame("three");
               break;
            case 3:
               _frame.setCrFrame("four");
               break;
            case 4:
               _frame.setCrFrame("five");
               break;
            case 5:
               _frame.setCrFrame("six");
         }
         _frame.play();
         if(_manager.limit <= 0)
         {
            _manager.currPayLevel = _manager.pay_count - _manager.num + 1;
            _frame.upDataBtn();
            _frame.setTxt(_manager.num.toString(),true);
            return;
         }
         _manager.currPayLevel = -1;
         _frame.setTxt(_manager.limit.toString(),true);
      }
      
      private function playerUpgradeLevelEnterHander(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _manager.level = _loc2_.readInt();
         _frame.updataStarLevel(_manager.level);
      }
      
      protected function __onOpenView(param1:BuriedEvent) : void
      {
         createActivityFrame();
         initFrames();
      }
      
      protected function createActivityFrame() : void
      {
         reachEndRewardsIDs = ServerConfigManager.instance.searchGoodsRewardID;
         _manager.boxNeedTimesList = ServerConfigManager.instance.searchGoodsRewardTimes;
         _manager.maxTimesCanGainRewards = _manager.boxNeedTimesList[_manager.boxNeedTimesList.length - 1];
         initFrames();
      }
      
      private function initFrames() : void
      {
         dispose();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtBuried.BuriedFrame");
         _frame.addDiceView(_manager.mapID);
         _frame.setTxt(_manager.limit.toString(),true);
         if(_manager.currPayLevel >= 0)
         {
            _frame.upDataBtn();
            _frame.setTxt(_manager.num.toString(),true);
         }
         _frame.addRewardsProgressBar();
         _frame.updateProgressBar();
         _manager.isOpening = true;
         _frame.setStarList(_manager.level);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function openShopView(param1:BuriedEvent) : void
      {
         if(!_frame)
         {
            return;
         }
         _shopframe = ComponentFactory.Instance.creatComponentByStylename("ddtburied.view.labyrinthShopFrame");
         _shopframe.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(_shopframe,3,true,1);
      }
      
      public function openshopHander() : void
      {
         if(LabyrinthControl.Instance.UILoadComplete)
         {
            _shopframe = ComponentFactory.Instance.creatComponentByStylename("ddtburied.view.labyrinthShopFrame");
            _shopframe.addEventListener("response",frameEvent);
            LayerManager.Instance.addToLayer(_shopframe,3,true,1);
         }
         else
         {
            LabyrinthControl.Instance.loadUIModule();
         }
      }
      
      protected function frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _shopframe.dispose();
      }
      
      public function dispose() : void
      {
         if(_frame && _frame.parent)
         {
            _frame.dispose();
         }
         if(_shopframe && _shopframe.parent)
         {
            _shopframe.dispose();
         }
         if(_shopframe && _shopframe.parent)
         {
            _shopframe.dispose();
         }
         if(_transactionsFrame && _transactionsFrame.parent)
         {
            _transactionsFrame.dispose();
         }
         _frame = null;
         _shopframe = null;
         _transactionsFrame = null;
      }
      
      public function showTransactionFrame(param1:String, param2:Function = null, param3:Function = null, param4:Sprite = null) : void
      {
         _transactionsFrame = ComponentFactory.Instance.creatComponentByStylename("ddtBuried.views.TransactionsDiceFrame");
         _transactionsFrame.setTxt(param1);
         _transactionsFrame.buyFunction = param2;
         _transactionsFrame.clickFunction = param3;
         _transactionsFrame.target = param4;
         LayerManager.Instance.addToLayer(_transactionsFrame,3,true,2);
      }
      
      public function get curGainBoxIndex() : int
      {
         return _curGainBoxIndex;
      }
   }
}
