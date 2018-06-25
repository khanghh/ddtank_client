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
      
      private function realTimeUpdataValue(e:PkgEvent) : void
      {
         orderdata.addDayPrestge = e.pkg.readInt();
         orderdata.totalPrestige = e.pkg.readInt();
         orderdata.weekPrestige = e.pkg.readInt();
         e.pkg.readInt();
         RoomManager.Instance.updateBattleSingleRoom();
         if(_battlGroudView && _battlGroudView.parent)
         {
            _battlGroudView.setTxt(orderdata);
         }
      }
      
      private function updataValue(e:PkgEvent) : void
      {
         var bool:Boolean = e.pkg.readBoolean();
         if(!bool)
         {
            return;
         }
         var type:int = e.pkg.readByte();
         if(type == 1)
         {
            orderdata.addDayPrestge = e.pkg.readInt();
            orderdata.totalPrestige = e.pkg.readInt();
            orderdata.fairBattleDayPrestige = e.pkg.readInt();
            orderdata.weekPrestige = e.pkg.readInt();
            e.pkg.readInt();
            RoomManager.Instance.updateBattleSingleRoom();
         }
         else if(type == 2)
         {
            orderdata.rankings = e.pkg.readInt();
         }
         if(_battlGroudView && _battlGroudView.parent)
         {
            _battlGroudView.setTxt(orderdata);
         }
      }
      
      public function getBattleDataByPrestige(prestige:int) : BatlleData
      {
         var i:int = 0;
         if(PlayerManager.Instance.Self.Grade < 20)
         {
            return new BatlleData();
         }
         var len:int = _battleDataList.length;
         for(i = len - 1; i >= 0; )
         {
            if(prestige >= _battleDataList[i].Prestige)
            {
               return _battleDataList[i] as BatlleData;
            }
            i--;
         }
         return new BatlleData();
      }
      
      public function getBattleDataByLevel(level:int) : BatlleData
      {
         var i:int = 0;
         var len:int = _battleDataList.length;
         for(i = 0; i < len; )
         {
            if(level == _battleDataList[i].Level)
            {
               return _battleDataList[i] as BatlleData;
            }
            i++;
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
      
      protected function __onOpenView(event:CEvent) : void
      {
         if(event.data == "battleground")
         {
            initBattleView();
         }
         else if(event.data == "ddtroom")
         {
            addBattleSingleRoom();
         }
      }
      
      protected function playerDataUpDate(event:PkgEvent) : void
      {
         playerBattleData = new PlayerBattleData();
         playerBattleData.Attack = event.pkg.readInt();
         playerBattleData.Defend = event.pkg.readInt();
         playerBattleData.Agility = event.pkg.readInt();
         playerBattleData.Lucky = event.pkg.readInt();
         playerBattleData.Damage = event.pkg.readInt();
         playerBattleData.Guard = event.pkg.readInt();
         playerBattleData.Blood = event.pkg.readInt();
         playerBattleData.Energy = event.pkg.readInt();
         playerBattleData.ID = PlayerManager.Instance.Self.ID;
      }
      
      private function orderData() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("FairBattleRewardTemp.xml"),5);
         loader.analyzer = new BattleGroundAnalyer(completeHander);
      }
      
      private function celeTotalPrestigeData() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("CelebByTotalPrestige.xml"),5);
         loader.analyzer = new CeleTotalPrestigeAnalyer(completeHander2);
      }
      
      public function completeHander(analyzer:BattleGroundAnalyer) : void
      {
         _battleDataList = analyzer.battleDataList;
         celeTotalPrestigeData();
      }
      
      public function completeHander2(analyzer:CeleTotalPrestigeAnalyer) : void
      {
         _battlePresDataList = analyzer.battleDataList;
         sendPkg();
      }
      
      public function getCurrBattlePresData(id:int) : BattlPrestigeData
      {
         var i:int = 0;
         var len:int = _battlePresDataList.length;
         for(i = 0; i < len; )
         {
            if(id == _battlePresDataList[i].ID)
            {
               return _battlePresDataList[i];
            }
            i++;
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
      
      private function __onProgress(event:UIModuleEvent) : void
      {
         if(event.module == "battleground")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function lodaDataTemplate() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FairBatttleWeeklyAwardTemp.xml"),5);
         loader.analyzer = new BattleWeeklyAwardAnalyzer(dataAnalyzer);
         new HelperDataModuleLoad().loadDataModule([loader],loadeDataComplete);
      }
      
      private function dataAnalyzer(e:BattleWeeklyAwardAnalyzer) : void
      {
         awardDataList = e.dataList;
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
      
      private function __onUIModuleComplete(evt:UIModuleEvent) : void
      {
         if(evt.module == "battleground")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            _moduleComplete = true;
            UIModuleSmallLoading.Instance.hide();
            lodaDataTemplate();
         }
         else if(evt.module == "ddtroom")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            _isBattleUILoaded = true;
            UIModuleSmallLoading.Instance.hide();
            GameInSocketOut.sendSingleRoomBegin(3);
         }
      }
      
      private function __onClose(event:Event) : void
      {
         _moduleComplete = false;
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
   }
}
