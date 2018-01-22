package sevenDayTarget.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import sevenDayTarget.model.NewPlayerRewardInfo;
   import sevenDayTarget.model.NewPlayerRewardModel;
   import sevenDayTarget.view.NewPlayerRewardMainView;
   
   public class NewPlayerRewardManager extends EventDispatcher
   {
      
      private static var _instance:NewPlayerRewardManager;
       
      
      private var _isShowIcon:Boolean;
      
      private var _model:NewPlayerRewardModel;
      
      public function NewPlayerRewardManager()
      {
         super();
      }
      
      public static function get Instance() : NewPlayerRewardManager
      {
         if(_instance == null)
         {
            _instance = new NewPlayerRewardManager();
         }
         return _instance;
      }
      
      public function get isShowIcon() : Boolean
      {
         return _isShowIcon;
      }
      
      public function setup() : void
      {
         _model = new NewPlayerRewardModel();
         SocketManager.Instance.addEventListener("sevenDayTarget_newplayerReward",pkgHandler);
      }
      
      public function get model() : NewPlayerRewardModel
      {
         return this._model;
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 96)
         {
            case 0:
               openOrclose(_loc3_);
               break;
            case 1:
               enterView(_loc3_);
               break;
            case 2:
               updateView(_loc3_);
         }
      }
      
      private function updateView(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:Boolean = param1.readBoolean();
         if(_loc4_)
         {
            _loc3_ = param1.readInt();
            _loc2_ = param1.readBoolean();
            updateQuestionInfoArr(_loc3_,_loc4_,_loc2_);
         }
      }
      
      private function updateQuestionInfoArr(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _model.chongzhiInfoArr.length)
         {
            _loc4_ = _model.chongzhiInfoArr[_loc7_];
            if(_loc4_.questId == param1)
            {
               _loc4_.getRewarded = param2;
               _loc4_.finished = param3;
               return;
            }
            _loc7_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _model.xiaofeiInfoArr.length)
         {
            _loc4_ = _model.xiaofeiInfoArr[_loc5_];
            if(_loc4_.questId == param1)
            {
               _loc4_.getRewarded = param2;
               _loc4_.finished = param3;
               return;
            }
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _model.hunliInfoArr.length)
         {
            _loc4_ = _model.hunliInfoArr[_loc6_];
            if(_loc4_.questId == param1)
            {
               _loc4_.getRewarded = param2;
               _loc4_.finished = param3;
               return;
            }
            _loc6_++;
         }
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isShowIcon = param1.readBoolean();
         NewSevenDayAndNewPlayerManager.Instance.newPlayerOpen = _isShowIcon;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openUpdate"));
      }
      
      public function enterView(param1:PackageIn) : void
      {
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         _loc10_ = 0;
         while(_loc10_ < 3)
         {
            _loc9_ = [];
            _loc2_ = param1.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc8_ = new NewPlayerRewardInfo();
               _loc8_.questId = param1.readInt();
               _loc8_.num = param1.readInt();
               if(_loc10_ == 0)
               {
                  _loc8_.bgType = NewPlayerRewardMainView.CHONGZHI;
               }
               else if(_loc10_ == 1)
               {
                  _loc8_.bgType = NewPlayerRewardMainView.XIAOFEI;
               }
               else if(_loc10_ == 2)
               {
                  _loc8_.bgType = NewPlayerRewardMainView.HUNLI;
               }
               _loc8_.finished = param1.readBoolean();
               _loc8_.getRewarded = param1.readBoolean();
               _loc4_ = param1.readInt();
               _loc3_ = [];
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.ItemID = param1.readInt();
                  _loc5_.Count = param1.readInt();
                  _loc3_.push(_loc5_);
                  _loc7_++;
               }
               _loc8_.rewardArr = _loc3_;
               _loc9_.push(_loc8_);
               _loc6_++;
            }
            if(_loc10_ == 0)
            {
               _model.chongzhiInfoArr = _loc9_;
            }
            else if(_loc10_ == 1)
            {
               _model.xiaofeiInfoArr = _loc9_;
            }
            else if(_loc10_ == 2)
            {
               _model.hunliInfoArr = _loc9_;
            }
            _loc10_++;
         }
         if(SevenDayTargetManager.loadComplete)
         {
            showNewPlayerRewardMainView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("sevenDayTarget");
         }
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
         if(param1.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __completeShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
            UIModuleSmallLoading.Instance.hide();
            SevenDayTargetManager.loadComplete = true;
            showNewPlayerRewardMainView();
         }
      }
      
      private function showNewPlayerRewardMainView() : void
      {
         NewSevenDayAndNewPlayerManager.Instance.newPlayerMainViewPreOk = true;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openSevenDayMainView"));
      }
   }
}
