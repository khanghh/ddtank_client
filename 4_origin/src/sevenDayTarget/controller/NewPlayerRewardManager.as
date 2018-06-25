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
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         switch(int(cmd) - 96)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               enterView(pkg);
               break;
            case 2:
               updateView(pkg);
         }
      }
      
      private function updateView(pkg:PackageIn) : void
      {
         var questionID:int = 0;
         var isComplete:Boolean = false;
         var success:Boolean = pkg.readBoolean();
         if(success)
         {
            questionID = pkg.readInt();
            isComplete = pkg.readBoolean();
            updateQuestionInfoArr(questionID,success,isComplete);
         }
      }
      
      private function updateQuestionInfoArr(questionID:int, success:Boolean, isComplete:Boolean) : void
      {
         var questionInfo:* = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         for(i = 0; i < _model.chongzhiInfoArr.length; )
         {
            questionInfo = _model.chongzhiInfoArr[i];
            if(questionInfo.questId == questionID)
            {
               questionInfo.getRewarded = success;
               questionInfo.finished = isComplete;
               return;
            }
            i++;
         }
         for(j = 0; j < _model.xiaofeiInfoArr.length; )
         {
            questionInfo = _model.xiaofeiInfoArr[j];
            if(questionInfo.questId == questionID)
            {
               questionInfo.getRewarded = success;
               questionInfo.finished = isComplete;
               return;
            }
            j++;
         }
         for(k = 0; k < _model.hunliInfoArr.length; )
         {
            questionInfo = _model.hunliInfoArr[k];
            if(questionInfo.questId == questionID)
            {
               questionInfo.getRewarded = success;
               questionInfo.finished = isComplete;
               return;
            }
            k++;
         }
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isShowIcon = pkg.readBoolean();
         NewSevenDayAndNewPlayerManager.Instance.newPlayerOpen = _isShowIcon;
         NewSevenDayAndNewPlayerManager.Instance.dispatchEvent(new Event("openUpdate"));
      }
      
      public function enterView(pkg:PackageIn) : void
      {
         var i:int = 0;
         var newArr:* = null;
         var count:int = 0;
         var j:int = 0;
         var info:* = null;
         var rewardNum:int = 0;
         var arr:* = null;
         var k:int = 0;
         var itemInfo:* = null;
         for(i = 0; i < 3; )
         {
            newArr = [];
            count = pkg.readInt();
            for(j = 0; j < count; )
            {
               info = new NewPlayerRewardInfo();
               info.questId = pkg.readInt();
               info.num = pkg.readInt();
               if(i == 0)
               {
                  info.bgType = NewPlayerRewardMainView.CHONGZHI;
               }
               else if(i == 1)
               {
                  info.bgType = NewPlayerRewardMainView.XIAOFEI;
               }
               else if(i == 2)
               {
                  info.bgType = NewPlayerRewardMainView.HUNLI;
               }
               info.finished = pkg.readBoolean();
               info.getRewarded = pkg.readBoolean();
               rewardNum = pkg.readInt();
               arr = [];
               for(k = 0; k < rewardNum; )
               {
                  itemInfo = new InventoryItemInfo();
                  itemInfo.ItemID = pkg.readInt();
                  itemInfo.Count = pkg.readInt();
                  arr.push(itemInfo);
                  k++;
               }
               info.rewardArr = arr;
               newArr.push(info);
               j++;
            }
            if(i == 0)
            {
               _model.chongzhiInfoArr = newArr;
            }
            else if(i == 1)
            {
               _model.xiaofeiInfoArr = newArr;
            }
            else if(i == 2)
            {
               _model.hunliInfoArr = newArr;
            }
            i++;
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
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "sevenDayTarget")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __completeShow(event:UIModuleEvent) : void
      {
         if(event.module == "sevenDayTarget")
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
