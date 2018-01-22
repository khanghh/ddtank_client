package bagAndInfo
{
   import bagAndInfo.bag.ring.data.RingDataAnalyzer;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.bag.trailelite.data.TrailEliteModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.view.bossbox.AwardsView;
   import explorerManual.ExplorerManualManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import game.GameManager;
   import road7th.comm.PackageIn;
   
   public class BagAndInfoManager extends EventDispatcher
   {
      
      private static var _instance:BagAndInfoManager;
       
      
      public var RingData:Dictionary;
      
      public var isInBagAndInfoView:Boolean;
      
      public var isUpgradePack:Boolean;
      
      private var _observerDictionary:Dictionary;
      
      public var trialEliteModel:TrailEliteModel;
      
      private var _bagAndGiftFrame:BagAndGiftFrame;
      
      private var _frame:BaseAlerFrame;
      
      private var _type:int = 0;
      
      private var infos:Array;
      
      private var name:String;
      
      private var bagtype:int = 0;
      
      public function BagAndInfoManager(param1:SingletonForce){super();}
      
      public static function get Instance() : BagAndInfoManager{return null;}
      
      public function get isShown() : Boolean{return false;}
      
      public function getBagAndGiftFrame() : BagAndGiftFrame{return null;}
      
      public function setup() : void{}
      
      public function registerOnPreviewFrameCloseHandler(param1:String, param2:Function) : void{}
      
      public function unregisterOnPreviewFrameCloseHandler(param1:String) : void{}
      
      private function _trailEliteHanlder(param1:CrazyTankSocketEvent) : void{}
      
      protected function __openPreviewListFrame(param1:PkgEvent) : void{}
      
      private function explorerManualPrompt(param1:int, param2:String) : void{}
      
      private function mergeInfos(param1:Array) : Array{return null;}
      
      public function showPreviewFrame(param1:String, param2:Array) : BaseAlerFrame{return null;}
      
      private function __frameClose(param1:FrameEvent) : void{}
      
      public function showBagAndInfo(param1:int = 0, param2:String = "", param3:int = 0) : void{}
      
      private function loadModule() : void{}
      
      private function createBagAndGiftFrame() : void{}
      
      public function hideBagAndInfo() : void{}
      
      public function clearReference() : void{}
      
      public function loadRingSystemInfo(param1:RingDataAnalyzer) : void{}
      
      public function getCurrentRingData() : RingSystemData{return null;}
      
      public function getRingData(param1:int) : RingSystemData{return null;}
   }
}

class SingletonForce
{
    
   
   function SingletonForce(){super();}
}

class _DataOnClickOKButton
{
    
   
   public var id:String;
   
   public var func:Function;
   
   function _DataOnClickOKButton(param1:String, param2:Function){super();}
}
