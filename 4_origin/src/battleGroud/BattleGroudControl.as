package battleGroud
{
   import battleGroud.data.BatlleData;
   import battleGroud.data.BattlPrestigeData;
   import battleGroud.data.BattleUpdateData;
   import battleGroud.data.BattleWeeklyAwardAnalyzer;
   import battleGroud.data.PlayerBattleData;
   import battleGroud.view.BattleGroudView;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import room.RoomManager;
   
   public class BattleGroudControl
   {
      
      private static var _instance:BattleGroudControl;
       
      
      private var _battlGroudView:BattleGroudView;
      
      private var _moduleComplete:Boolean;
      
      private var _battleDataList:Array;
      
      public var orderdata:BattleUpdateData;
      
      private var _isBattleUILoaded:Boolean;
      
      private var _battlePresDataList:Vector.<BattlPrestigeData>;
      
      public var playerBattleData:PlayerBattleData;
      
      public var awardDataList:Array;
      
      public function BattleGroudControl()
      {
         super();
         orderdata = new BattleUpdateData();
      }
      
      public static function get Instance() : BattleGroudControl
      {
         if(!_instance)
         {
            _instance = new BattleGroudControl();
         }
         return _instance;
      }
      
      private function realTimeUpdataValue(param1:PkgEvent) : void
      {
         orderdata.addDayPrestge = param1.pkg.readInt();
         orderdata.totalPrestige = param1.pkg.readInt();
         orderdata.weekPrestige = param1.pkg.readInt();
         param1.pkg.readInt();
         RoomManager.Instance.updateBattleSingleRoom();
         if(_battlGroudView && _battlGroudView.parent)
         {
            _battlGroudView.setTxt(orderdata);
         }
      }
      
      private function updataValue(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = param1.pkg.readByte();
         if(_loc3_ == 1)
         {
            orderdata.addDayPrestge = param1.pkg.readInt();
            orderdata.totalPrestige = param1.pkg.readInt();
            orderdata.fairBattleDayPrestige = param1.pkg.readInt();
            orderdata.weekPrestige = param1.pkg.readInt();
            param1.pkg.readInt();
            RoomManager.Instance.updateBattleSingleRoom();
         }
         else if(_loc3_ == 2)
         {
            orderdata.rankings = param1.pkg.readInt();
         }
         if(_battlGroudView && _battlGroudView.parent)
         {
            _battlGroudView.setTxt(orderdata);
         }
      }
      
      public function getBattleDataByPrestige(param1:int) : BatlleData
      {
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.Grade < 20)
         {
            return new BatlleData();
         }
         var _loc2_:int = _battleDataList.length;
         _loc3_ = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if(param1 >= _battleDataList[_loc3_].Prestige)
            {
               return _battleDataList[_loc3_] as BatlleData;
            }
            _loc3_--;
         }
         return new BatlleData();
      }
      
      public function getBattleDataByLevel(param1:int) : BatlleData
      {
         var _loc3_:int = 0;
         var _loc2_:int = _battleDataList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == _battleDataList[_loc3_].Level)
            {
               return _battleDataList[_loc3_] as BatlleData;
            }
            _loc3_++;
         }
         return new BatlleData();
      }
      
      public function setup() : void
      {
         initEvent();
         orderData();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.battleGroundUpdata(1);
         SocketManager.Instance.out.battleGroundUpdata(2);
         SocketManager.Instance.out.battleGroundPlayerUpdata();
      }
      
      private function initEvent() : void
      {
         BattleGroudManager.Instance.addEventListener("battleOpenView",__onOpenView);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,3),updataValue);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,4),realTimeUpdataValue);
         SocketManager.Instance.addEventListener(PkgEvent.format(132,5),playerDataUpDate);
      }
      
      protected function __onOpenView(param1:CEvent) : void
      {
         if(param1.data == "battleground")
         {
            initBattleView();
         }
         else if(param1.data == "ddtroom")
         {
            addBattleSingleRoom();
         }
      }
      
      protected function playerDataUpDate(param1:PkgEvent) : void
      {
         playerBattleData = new PlayerBattleData();
         playerBattleData.Attack = param1.pkg.readInt();
         playerBattleData.Defend = param1.pkg.readInt();
         playerBattleData.Agility = param1.pkg.readInt();
         playerBattleData.Lucky = param1.pkg.readInt();
         playerBattleData.Damage = param1.pkg.readInt();
         playerBattleData.Guard = param1.pkg.readInt();
         playerBattleData.Blood = param1.pkg.readInt();
         playerBattleData.Energy = param1.pkg.readInt();
         playerBattleData.ID = PlayerManager.Instance.Self.ID;
      }
      
      private function orderData() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("FairBattleRewardTemp.xml"),5);
         _loc1_.analyzer = new BattleGroundAnalyer(completeHander);
      }
      
      private function celeTotalPrestigeData() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("CelebByTotalPrestige.xml"),5);
         _loc1_.analyzer = new CeleTotalPrestigeAnalyer(completeHander2);
      }
      
      public function completeHander(param1:BattleGroundAnalyer) : void
      {
         _battleDataList = param1.battleDataList;
         celeTotalPrestigeData();
      }
      
      public function completeHander2(param1:CeleTotalPrestigeAnalyer) : void
      {
         _battlePresDataList = param1.battleDataList;
         sendPkg();
      }
      
      public function getCurrBattlePresData(param1:int) : BattlPrestigeData
      {
         var _loc3_:int = 0;
         var _loc2_:int = _battlePresDataList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == _battlePresDataList[_loc3_].ID)
            {
               return _battlePresDataList[_loc3_];
            }
            _loc3_++;
         }
         return new BattlPrestigeData();
      }
      
      private function loadeDataComplete() : void
      {
         show();
      }
      
      public function initBattleView() : void
      {
         if(_battlGroudView && _battlGroudView.parent)
         {
            hide();
         }
         else if(_moduleComplete)
         {
            lodaDataTemplate();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            UIModuleLoader.Instance.addUIModuleImp("battleground");
         }
      }
      
      public function addBattleSingleRoom() : void
      {
         if(_isBattleUILoaded)
         {
            GameInSocketOut.sendSingleRoomBegin(3);
            return;
         }
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
         UIModuleLoader.Instance.addUIModuleImp("ddtroom");
      }
      
      private function __onProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "battleground")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function lodaDataTemplate() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBatttleWeeklyAwardTemp.xml"),5);
         _loc1_.analyzer = new BattleWeeklyAwardAnalyzer(dataAnalyzer);
         new HelperDataModuleLoad().loadDataModule([_loc1_],loadeDataComplete);
      }
      
      private function dataAnalyzer(param1:BattleWeeklyAwardAnalyzer) : void
      {
         awardDataList = param1.dataList;
      }
      
      public function show() : void
      {
         if(_battlGroudView)
         {
            ObjectUtils.disposeObject(_battlGroudView);
            _battlGroudView = null;
         }
         _battlGroudView = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView");
         LayerManager.Instance.addToLayer(_battlGroudView,3,true,2);
      }
      
      public function hide() : void
      {
         if(_battlGroudView)
         {
            _battlGroudView.dispose();
         }
         _battlGroudView = null;
      }
      
      private function __onUIModuleComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "battleground")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            _moduleComplete = true;
            UIModuleSmallLoading.Instance.hide();
            lodaDataTemplate();
         }
         else if(param1.module == "ddtroom")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            _isBattleUILoaded = true;
            UIModuleSmallLoading.Instance.hide();
            GameInSocketOut.sendSingleRoomBegin(3);
         }
      }
      
      private function __onClose(param1:Event) : void
      {
         _moduleComplete = false;
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
   }
}
