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
      
      private function __onUpdateBoxList(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _model.clearBoxInfoList();
         var _loc2_:int = param1.pkg.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new DevilTurnBoxInfo();
            _loc3_.id = param1.pkg.readInt();
            _loc3_.count = param1.pkg.readInt();
            _loc3_.expireDate = param1.pkg.readInt();
            _model.addBoxInfo(_loc3_);
            _loc4_++;
         }
         dispatchEvent(new DevilTurnEvent("updateboxinfo"));
      }
      
      private function __onUpdateJackpot(param1:PkgEvent) : void
      {
         _model.jackpot = param1.pkg.readLong();
         dispatchEvent(new DevilTurnEvent("updatejackpot"));
      }
      
      private function __onUpdateInfo(param1:PkgEvent) : void
      {
         _model.lotteryCount = param1.pkg.readInt();
         _model.myRankScore = param1.pkg.readInt();
         _model.beadCount1 = param1.pkg.readInt();
         _model.beadCount2 = param1.pkg.readInt();
         _model.beadCount3 = param1.pkg.readInt();
         _model.beadCount4 = param1.pkg.readInt();
         _model.beadCount5 = param1.pkg.readInt();
         _model.getGiftProgress = param1.pkg.readInt();
         _model.freeTimes = param1.pkg.readByte();
         _model.freeDate = param1.pkg.readInt();
         dispatchEvent(new DevilTurnEvent("updateinfo"));
      }
      
      private function __onUpdateRankList(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Array = [];
         _model.myRank = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new DevilTurnRankInfo();
            _loc4_.id = param1.pkg.readInt();
            _loc4_.name = param1.pkg.readUTF();
            _loc4_.area = param1.pkg.readUTF();
            _loc4_.score = param1.pkg.readInt();
            _loc4_.rank = param1.pkg.readInt();
            _loc2_.push(_loc4_);
            _loc5_++;
         }
         _model.rankList = _loc2_;
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
         var _loc1_:Sprite = ClassUtils.CreatInstance("devilTurn.view.DevilTurnMainView");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         SocketManager.Instance.out.sendDevilGetInfo();
      }
      
      public function loadGoodsItemComplete(param1:DevilTurnGoodsItemAnalyzer) : void
      {
         _model.goodsItemList = param1.data;
      }
      
      public function loadBoxConvertItemComplete(param1:DevilTurnBoxConvertAnalyzer) : void
      {
         _model.boxConverList = param1.data;
      }
      
      public function loadPointsShopItemComplete(param1:DevilTurnPointShopAnalyzer) : void
      {
         _model.pointsShopList = param1.data;
      }
      
      public function loadRankAwardItemComplete(param1:DevilTurnRankRewardAnalyzer) : void
      {
         _model.rankAwardList = param1.data;
      }
      
      private function __onInit(param1:CrazyTankSocketEvent) : void
      {
         activityState = param1.pkg.readByte();
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
         var _loc2_:String = ServerConfigManager.instance.devilTurnBeginDate.split(" ")[0];
         var _loc1_:String = ServerConfigManager.instance.devilTurnEndDate.split(" ")[0];
         _model.activityDate = _loc2_ + "~" + _loc1_;
      }
      
      public function get model() : DevilTurnModel
      {
         return _model;
      }
   }
}
