package devilTurn
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import devilTurn.analyze.DevilTurnBoxConvertAnalyzer;
   import devilTurn.analyze.DevilTurnGoodsItemAnalyzer;
   import devilTurn.analyze.DevilTurnPointShopAnalyzer;
   import devilTurn.analyze.DevilTurnRankRewardAnalyzer;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnBoxInfo;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.model.DevilTurnRankInfo;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class DevilTurnManager extends EventDispatcher
   {
      
      private static var _instance:DevilTurnManager;
       
      
      public var lotteryRunning:Boolean;
      
      public var activityState:int;
      
      private var _model:DevilTurnModel;
      
      public function DevilTurnManager()
      {
         super();
         _model = new DevilTurnModel();
      }
      
      public static function get instance() : DevilTurnManager
      {
         if(_instance == null)
         {
            _instance = new DevilTurnManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(608,1),__onInit);
      }
      
      public function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(608,2),__onUpdateRankList);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,20),__onUpdateInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,3),__onUpdateJackpot);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,24),__onUpdateBoxList);
      }
      
      public function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,2),__onUpdateRankList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,20),__onUpdateInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,3),__onUpdateJackpot);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,24),__onUpdateBoxList);
      }
      
      private function __onUpdateBoxList(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         _model.clearBoxInfoList();
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new DevilTurnBoxInfo();
            info.id = e.pkg.readInt();
            info.count = e.pkg.readInt();
            info.expireDate = e.pkg.readInt();
            _model.addBoxInfo(info);
            i++;
         }
         dispatchEvent(new DevilTurnEvent("updateboxinfo"));
      }
      
      private function __onUpdateJackpot(e:PkgEvent) : void
      {
         _model.jackpot = e.pkg.readLong();
         dispatchEvent(new DevilTurnEvent("updatejackpot"));
      }
      
      private function __onUpdateInfo(e:PkgEvent) : void
      {
         _model.lotteryCount = e.pkg.readInt();
         _model.myRankScore = e.pkg.readInt();
         _model.beadCount1 = e.pkg.readInt();
         _model.beadCount2 = e.pkg.readInt();
         _model.beadCount3 = e.pkg.readInt();
         _model.beadCount4 = e.pkg.readInt();
         _model.beadCount5 = e.pkg.readInt();
         _model.getGiftProgress = e.pkg.readInt();
         _model.freeTimes = e.pkg.readByte();
         _model.freeDate = e.pkg.readInt();
         dispatchEvent(new DevilTurnEvent("updateinfo"));
      }
      
      private function __onUpdateRankList(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var rankList:Array = [];
         _model.myRank = e.pkg.readInt();
         var len:int = e.pkg.readShort();
         for(i = 0; i < len; )
         {
            info = new DevilTurnRankInfo();
            info.id = e.pkg.readInt();
            info.name = e.pkg.readUTF();
            info.area = e.pkg.readUTF();
            info.score = e.pkg.readInt();
            info.rank = e.pkg.readInt();
            rankList.push(info);
            i++;
         }
         _model.rankList = rankList;
         dispatchEvent(new DevilTurnEvent("updateranklist"));
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createDevilTurnBoxConvertLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createDevilTurnGoodsItemLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createDevilTurnPointShopLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createDevilTurnRankAewardLoader());
         AssetModuleLoader.addModelLoader("devilturn",7);
         AssetModuleLoader.startCodeLoader(onLoadComplete);
      }
      
      private function onLoadComplete() : void
      {
         var frame:Sprite = ClassUtils.CreatInstance("devilTurn.view.DevilTurnMainView");
         LayerManager.Instance.addToLayer(frame,3,true,1);
         SocketManager.Instance.out.sendDevilGetInfo();
      }
      
      public function loadGoodsItemComplete(value:DevilTurnGoodsItemAnalyzer) : void
      {
         _model.goodsItemList = value.data;
      }
      
      public function loadBoxConvertItemComplete(value:DevilTurnBoxConvertAnalyzer) : void
      {
         _model.boxConverList = value.data;
      }
      
      public function loadPointsShopItemComplete(value:DevilTurnPointShopAnalyzer) : void
      {
         _model.pointsShopList = value.data;
      }
      
      public function loadRankAwardItemComplete(value:DevilTurnRankRewardAnalyzer) : void
      {
         _model.rankAwardList = value.data;
      }
      
      private function __onInit(e:CrazyTankSocketEvent) : void
      {
         activityState = e.pkg.readByte();
         if(activityState != 0)
         {
            initActivityDate();
            _model.totalJackpot = ServerConfigManager.instance.devilTurnTotalJackpot;
            HallIconManager.instance.updateSwitchHandler("devilTurn",true);
         }
         else
         {
            dispatchEvent(new DevilTurnEvent("updateActivityState"));
            HallIconManager.instance.updateSwitchHandler("devilTurn",false);
         }
      }
      
      private function initActivityDate() : void
      {
         var beginDate:String = ServerConfigManager.instance.devilTurnBeginDate.split(" ")[0];
         var endDate:String = ServerConfigManager.instance.devilTurnEndDate.split(" ")[0];
         _model.activityDate = beginDate + "~" + endDate;
      }
      
      public function get model() : DevilTurnModel
      {
         return _model;
      }
   }
}
