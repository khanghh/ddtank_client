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
      
      public function oneDegreeToTwoDegree(str:String, row:int, col:int) : Array
      {
         var j:int = 0;
         var i:int = 0;
         var oneDegree:Array = str.split(",");
         var k:int = 0;
         var twoDegree:Array = [];
         for(j = 0; j < col; )
         {
            twoDegree[j] = [];
            for(i = 0; i < row; )
            {
               twoDegree[j][i] = int(oneDegree[k]);
               k++;
               i++;
            }
            j++;
         }
         return twoDegree;
      }
      
      public function setup() : void
      {
         initEvents();
      }
      
      public function getUpdateData(bool:Boolean) : UpdateStarData
      {
         var nextLevel:int = 0;
         var i:int = 0;
         var len:int = _manager.upDateStarList.length;
         if(bool)
         {
            nextLevel = _manager.level + 1;
         }
         else
         {
            nextLevel = _manager.level;
         }
         for(i = 0; i < len; )
         {
            if(nextLevel == _manager.upDateStarList[i].StarID)
            {
               return _manager.upDateStarList[i];
            }
            i++;
         }
         return null;
      }
      
      public function getPayData() : SearchGoodsData
      {
         var i:int = 0;
         var len:int = _manager.payMoneyList.length;
         for(i = 0; i < len; )
         {
            if(_manager.currPayLevel == _manager.payMoneyList[i].Number)
            {
               return _manager.payMoneyList[i];
            }
            i++;
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
      
      protected function mapOverHandler(e:BuriedEvent) : void
      {
         e = e;
         callBack = function(item:int, index:int, arr:Array):Boolean
         {
            if(item == reachTimes)
            {
               idx = index;
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
      
      public function requireGainRewards(index:int) : void
      {
         _curGainBoxIndex = index;
         SocketManager.Instance.out.sendSearchGoodsGainRewards(index);
      }
      
      protected function onGainRewards(e:PkgEvent) : void
      {
         var bytes:ByteArray = e.pkg;
         var isSuc:Boolean = bytes.readBoolean();
         _manager.stateRewardsGained = bytes.readInt();
         _manager.timesReachEnd = bytes.readInt();
         _frame.updatePlayGainedAnimation(_curGainBoxIndex);
      }
      
      private function playerRollDiceHander(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _manager.num = e.pkg.readInt();
         _manager.timesBuyDice = e.pkg.readInt();
         var type:int = e.pkg.readInt();
         _manager.nowPosition = e.pkg.readInt();
         if(_manager.nowPosition == 35)
         {
            _manager.isOver = true;
         }
         if(_manager.nowPosition == 0)
         {
            dispatchEvent(new BuriedEvent("updatabtnstats"));
         }
         _manager.limit = _manager.num - _manager.pay_count;
         switch(int(type) - 1)
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
      
      private function playerUpgradeLevelEnterHander(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _manager.level = pkg.readInt();
         _frame.updataStarLevel(_manager.level);
      }
      
      protected function __onOpenView(event:BuriedEvent) : void
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
      
      private function openShopView(e:BuriedEvent) : void
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
      
      protected function frameEvent(event:FrameEvent) : void
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
      
      public function showTransactionFrame(str:String, payFun:Function = null, clickFun:Function = null, target:Sprite = null) : void
      {
         _transactionsFrame = ComponentFactory.Instance.creatComponentByStylename("ddtBuried.views.TransactionsDiceFrame");
         _transactionsFrame.setTxt(str);
         _transactionsFrame.buyFunction = payFun;
         _transactionsFrame.clickFunction = clickFun;
         _transactionsFrame.target = target;
         LayerManager.Instance.addToLayer(_transactionsFrame,3,true,2);
      }
      
      public function get curGainBoxIndex() : int
      {
         return _curGainBoxIndex;
      }
   }
}
