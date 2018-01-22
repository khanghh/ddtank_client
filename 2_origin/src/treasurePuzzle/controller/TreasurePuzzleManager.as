package treasurePuzzle.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import treasurePuzzle.data.TreasurePuzzlePiceData;
   import treasurePuzzle.data.TreasurePuzzleRewardData;
   import treasurePuzzle.model.TreasurePuzzleModel;
   import treasurePuzzle.view.TreasurePuzzleMainView;
   
   public class TreasurePuzzleManager extends EventDispatcher
   {
      
      private static var _instance:TreasurePuzzleManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _isShowIcon:Boolean;
      
      private var _treasurePuzzleView:TreasurePuzzleMainView;
      
      private var _model:TreasurePuzzleModel;
      
      public var currentPuzzle:int;
      
      public function TreasurePuzzleManager()
      {
         super();
      }
      
      public static function get Instance() : TreasurePuzzleManager
      {
         if(_instance == null)
         {
            _instance = new TreasurePuzzleManager();
         }
         return _instance;
      }
      
      public function get isShowIcon() : Boolean
      {
         return _isShowIcon;
      }
      
      public function setup() : void
      {
         _model = new TreasurePuzzleModel();
         SocketManager.Instance.addEventListener("treasurePuzzle_system",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 102)
         {
            case 0:
               openOrclose(_loc3_);
               break;
            case 1:
               enterView(_loc3_);
               break;
            case 2:
               seeReward(_loc3_);
               break;
            case 3:
               getReward(_loc3_);
               break;
            default:
               getReward(_loc3_);
               break;
            default:
               getReward(_loc3_);
               break;
            case 6:
               flushData(_loc3_);
         }
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isShowIcon = param1.readBoolean();
         if(_isShowIcon)
         {
            addEnterIcon();
         }
         else
         {
            disposeEnterIcon();
         }
      }
      
      private function enterView(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc2_:int = param1.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = new TreasurePuzzlePiceData();
            _loc3_.id = param1.readInt();
            _loc3_.hole1Need = param1.readInt();
            _loc3_.hole1Have = param1.readInt();
            _loc3_.hole2Need = param1.readInt();
            _loc3_.hole2Have = param1.readInt();
            _loc3_.hole3Need = param1.readInt();
            _loc3_.hole3Have = param1.readInt();
            _loc3_.hole4Need = param1.readInt();
            _loc3_.hole4Have = param1.readInt();
            _loc3_.hole5Need = param1.readInt();
            _loc3_.hole5Have = param1.readInt();
            _loc3_.hole6Need = param1.readInt();
            _loc3_.hole6Have = param1.readInt();
            _loc3_._canGetReward = param1.readBoolean();
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         _model.dataArr = _loc4_;
         if(loadComplete)
         {
            showTreasurePuzzleMainView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("treasurePuzzle");
         }
      }
      
      private function flushData(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc2_:int = param1.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = new TreasurePuzzlePiceData();
            _loc3_.id = param1.readInt();
            _loc3_.hole1Need = param1.readInt();
            _loc3_.hole1Have = param1.readInt();
            _loc3_.hole2Need = param1.readInt();
            _loc3_.hole2Have = param1.readInt();
            _loc3_.hole3Need = param1.readInt();
            _loc3_.hole3Have = param1.readInt();
            _loc3_.hole4Need = param1.readInt();
            _loc3_.hole4Have = param1.readInt();
            _loc3_.hole5Need = param1.readInt();
            _loc3_.hole5Have = param1.readInt();
            _loc3_.hole6Need = param1.readInt();
            _loc3_.hole6Have = param1.readInt();
            _loc3_._canGetReward = param1.readBoolean();
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         _model.dataArr = _loc4_;
         _treasurePuzzleView.flushRewardBnt();
      }
      
      private function seeReward(param1:PackageIn) : void
      {
         var _loc12_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Boolean = false;
         var _loc2_:* = null;
         var _loc11_:int = 0;
         var _loc8_:* = null;
         var _loc10_:Array = [];
         var _loc5_:int = param1.readInt();
         _loc12_ = 0;
         while(_loc12_ < _loc5_)
         {
            _loc4_ = param1.readInt();
            _loc9_ = 0;
            while(_loc9_ < _model.dataArr.length)
            {
               _loc3_ = _model.dataArr[_loc9_];
               if(_loc4_ == _loc3_.id)
               {
                  _loc7_ = _model.dataArr[_loc9_];
               }
               _loc9_++;
            }
            _loc6_ = param1.readBoolean();
            if(_loc6_)
            {
               _loc7_.isShiwu = true;
            }
            else
            {
               _loc7_.isShiwu = false;
               _loc7_.rewardNum = param1.readInt();
               _loc2_ = [];
               _loc11_ = 0;
               while(_loc11_ < _loc7_.rewardNum)
               {
                  _loc8_ = new TreasurePuzzleRewardData();
                  _loc8_.rewardId = param1.readInt();
                  _loc8_.rewardNum = param1.readInt();
                  _loc2_.push(_loc8_);
                  _loc11_++;
               }
               _loc7_.rewardList = _loc2_;
            }
            _loc12_++;
         }
         _treasurePuzzleView.showHelpView();
      }
      
      private function getReward(param1:PackageIn) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = param1.readBoolean();
         if(_loc3_)
         {
            _loc2_ = param1.readBoolean();
            if(_loc2_)
            {
               _treasurePuzzleView.showShiwuInfoView();
            }
         }
      }
      
      public function addEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("treasurepuzzle",true);
      }
      
      private function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("treasurepuzzle",false);
      }
      
      public function onClickTreasurePuzzleIcon() : void
      {
         SocketManager.Instance.out.treasurePuzzle_enter();
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "treasurePuzzle")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __completeShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "treasurePuzzle")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showTreasurePuzzleMainView();
         }
      }
      
      private function showTreasurePuzzleMainView() : void
      {
         _treasurePuzzleView = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.TreasurePuzzleFrame");
         _treasurePuzzleView.show();
      }
      
      public function get model() : TreasurePuzzleModel
      {
         return this._model;
      }
      
      public function hide() : void
      {
         if(_treasurePuzzleView != null)
         {
            _treasurePuzzleView.dispose();
         }
         _treasurePuzzleView = null;
      }
   }
}
