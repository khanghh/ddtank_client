package mark
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mark.analyzer.MarkChipAnalyzer;
   import mark.analyzer.MarkHammerAnalyzer;
   import mark.analyzer.MarkProAnalyzer;
   import mark.analyzer.MarkSetAnalyzer;
   import mark.analyzer.MarkSuitAnalyzer;
   import mark.analyzer.MarkTransferAnalyzer;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkHammerTemplateData;
   import mark.data.MarkModel;
   import mark.data.MarkProData;
   import mark.data.MarkTransferTemplateData;
   import mark.event.MarkEvent;
   import road7th.comm.PackageIn;
   
   public class MarkMgr extends EventDispatcher
   {
      
      private static var _inst:MarkMgr = null;
       
      
      private var _model:MarkModel;
      
      private var _markContainer:DisplayObjectContainer = null;
      
      private var _otherContainer:DisplayObjectContainer = null;
      
      private var _treasureRoomContainer:DisplayObjectContainer = null;
      
      private var _alert:BaseAlerFrame = null;
      
      private var _sellAlert:BaseAlerFrame = null;
      
      public var isFarmMark:Boolean = true;
      
      public var treasureRoomLogoIdArr:Array;
      
      public var treasureRoomRewardArr:Array;
      
      public var isFull:Boolean;
      
      public var isOther:Boolean = false;
      
      public function MarkMgr(param1:SingTon){super();}
      
      public static function get inst() : MarkMgr{return null;}
      
      public function setup() : void{}
      
      private function __updateChipsInfo(param1:PkgEvent) : void{}
      
      public function updateChips(param1:Vector.<MarkChipData>) : void{}
      
      private function __auctionGetMarkTips(param1:PkgEvent) : void{}
      
      public function showMarkView(param1:DisplayObjectContainer, param2:PlayerInfo = null) : void{}
      
      public function showTreasureRoomView() : void{}
      
      public function setMarkChipTempalte(param1:MarkChipAnalyzer) : void{}
      
      public function setMarkSuitTempalte(param1:MarkSuitAnalyzer) : void{}
      
      public function setMarkProInfo(param1:MarkProAnalyzer) : void{}
      
      public function setMarkSetTempalte(param1:MarkSetAnalyzer) : void{}
      
      public function setMarkHammerTempalte(param1:MarkHammerAnalyzer) : void{}
      
      public function setMarkTransferTempalte(param1:MarkTransferAnalyzer) : void{}
      
      public function showMarkMainFrame() : void{}
      
      private function disposeBooksAndTreasureRoom() : void{}
      
      public function removeMarkView() : void{}
      
      public function chooseEquip(param1:int) : void{}
      
      public function getEquipList() : Array{return null;}
      
      public function checkTip(param1:int, param2:int) : Boolean{return false;}
      
      public function reqOperationStatus(param1:int, param2:int) : void{}
      
      public function getHammerData(param1:int, param2:int) : MarkHammerTemplateData{return null;}
      
      public function getHammerTopLv(param1:int) : int{return 0;}
      
      public function getTransferData(param1:int, param2:int) : MarkTransferTemplateData{return null;}
      
      public function getAttributeAdd(param1:int, param2:int) : int{return 0;}
      
      public function getMarkProValue(param1:MarkChipData, param2:int) : int{return 0;}
      
      public function checkMarkOpen(param1:PlayerInfo = null) : Boolean{return false;}
      
      public function get model() : MarkModel{return null;}
      
      public function submitTransfer() : void{}
      
      public function submitSell() : void{}
      
      private function getSellDemand() : int{return 0;}
      
      private function calculateDemand(param1:int) : int{return 0;}
      
      private function alertHandler(param1:FrameEvent) : void{}
      
      private function alertSecondHandler(param1:FrameEvent) : void{}
      
      public function submitHighStarSell() : void{}
      
      public function sortedProps(param1:Dictionary) : Array{return null;}
      
      public function getEquipProps() : Dictionary{return null;}
      
      public function calculateEquipProps(param1:int) : Dictionary{return null;}
      
      private function __resSyncOrUpdateChips(param1:PkgEvent) : void{}
      
      public function reqSyncOrUpdateChips() : void{}
      
      public function moveChip(param1:int) : void{}
      
      private function checkChipExist(param1:int) : Boolean{return false;}
      
      public function reqSellChips() : void{}
      
      private function __resHammerChip(param1:PkgEvent) : void{}
      
      public function reqHammerChip(param1:int = 1) : void{}
      
      private function __resMarkMoney(param1:PkgEvent) : void{}
      
      public function reqTransferChip(param1:int) : void{}
      
      private function verfyPro(param1:int) : Boolean{return false;}
      
      private function __resTransferChip(param1:PkgEvent) : void{}
      
      public function reqTransferSubmit(param1:Boolean = true) : void{}
      
      private function __resTransferSubmit(param1:PkgEvent) : void{}
      
      private function __resOperationStatus(param1:PkgEvent) : void{}
      
      protected function __onVaultsData(param1:PkgEvent) : void{}
      
      protected function __onVaultsReward(param1:PkgEvent) : void{}
      
      public function showMark() : void{}
   }
}

class SingTon
{
    
   
   function SingTon(){super();}
}
