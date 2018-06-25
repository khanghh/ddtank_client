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
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         switch(int(cmd) - 102)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               enterView(pkg);
               break;
            case 2:
               seeReward(pkg);
               break;
            case 3:
               getReward(pkg);
               break;
            default:
               getReward(pkg);
               break;
            default:
               getReward(pkg);
               break;
            case 6:
               flushData(pkg);
         }
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isShowIcon = pkg.readBoolean();
         if(_isShowIcon)
         {
            addEnterIcon();
         }
         else
         {
            disposeEnterIcon();
         }
      }
      
      private function enterView(pkg:PackageIn) : void
      {
         var i:int = 0;
         var piceData:* = null;
         var modelArr:Array = [];
         var totol:int = pkg.readInt();
         for(i = 0; i < totol; )
         {
            piceData = new TreasurePuzzlePiceData();
            piceData.id = pkg.readInt();
            piceData.hole1Need = pkg.readInt();
            piceData.hole1Have = pkg.readInt();
            piceData.hole2Need = pkg.readInt();
            piceData.hole2Have = pkg.readInt();
            piceData.hole3Need = pkg.readInt();
            piceData.hole3Have = pkg.readInt();
            piceData.hole4Need = pkg.readInt();
            piceData.hole4Have = pkg.readInt();
            piceData.hole5Need = pkg.readInt();
            piceData.hole5Have = pkg.readInt();
            piceData.hole6Need = pkg.readInt();
            piceData.hole6Have = pkg.readInt();
            piceData._canGetReward = pkg.readBoolean();
            modelArr.push(piceData);
            i++;
         }
         _model.dataArr = modelArr;
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
      
      private function flushData(pkg:PackageIn) : void
      {
         var i:int = 0;
         var piceData:* = null;
         var modelArr:Array = [];
         var totol:int = pkg.readInt();
         for(i = 0; i < totol; )
         {
            piceData = new TreasurePuzzlePiceData();
            piceData.id = pkg.readInt();
            piceData.hole1Need = pkg.readInt();
            piceData.hole1Have = pkg.readInt();
            piceData.hole2Need = pkg.readInt();
            piceData.hole2Have = pkg.readInt();
            piceData.hole3Need = pkg.readInt();
            piceData.hole3Have = pkg.readInt();
            piceData.hole4Need = pkg.readInt();
            piceData.hole4Have = pkg.readInt();
            piceData.hole5Need = pkg.readInt();
            piceData.hole5Have = pkg.readInt();
            piceData.hole6Need = pkg.readInt();
            piceData.hole6Have = pkg.readInt();
            piceData._canGetReward = pkg.readBoolean();
            modelArr.push(piceData);
            i++;
         }
         _model.dataArr = modelArr;
         _treasurePuzzleView.flushRewardBnt();
      }
      
      private function seeReward(pkg:PackageIn) : void
      {
         var i:int = 0;
         var id:int = 0;
         var piceData:* = null;
         var j:int = 0;
         var picData2:* = null;
         var isShiwu:Boolean = false;
         var rewardList:* = null;
         var k:int = 0;
         var rewardData:* = null;
         var modelArr:Array = [];
         var totol:int = pkg.readInt();
         for(i = 0; i < totol; )
         {
            id = pkg.readInt();
            for(j = 0; j < _model.dataArr.length; )
            {
               picData2 = _model.dataArr[j];
               if(id == picData2.id)
               {
                  piceData = _model.dataArr[j];
               }
               j++;
            }
            isShiwu = pkg.readBoolean();
            if(isShiwu)
            {
               piceData.isShiwu = true;
            }
            else
            {
               piceData.isShiwu = false;
               piceData.rewardNum = pkg.readInt();
               rewardList = [];
               for(k = 0; k < piceData.rewardNum; )
               {
                  rewardData = new TreasurePuzzleRewardData();
                  rewardData.rewardId = pkg.readInt();
                  rewardData.rewardNum = pkg.readInt();
                  rewardList.push(rewardData);
                  k++;
               }
               piceData.rewardList = rewardList;
            }
            i++;
         }
         _treasurePuzzleView.showHelpView();
      }
      
      private function getReward(pkg:PackageIn) : void
      {
         var isShiwu:Boolean = false;
         var success:Boolean = pkg.readBoolean();
         if(success)
         {
            isShiwu = pkg.readBoolean();
            if(isShiwu)
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
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "treasurePuzzle")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __completeShow(event:UIModuleEvent) : void
      {
         if(event.module == "treasurePuzzle")
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
