package mark{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import flash.display.DisplayObjectContainer;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import mark.analyzer.MarkChipAnalyzer;   import mark.analyzer.MarkHammerAnalyzer;   import mark.analyzer.MarkProAnalyzer;   import mark.analyzer.MarkSetAnalyzer;   import mark.analyzer.MarkSuitAnalyzer;   import mark.analyzer.MarkTransferAnalyzer;   import mark.data.MarkBagData;   import mark.data.MarkChipData;   import mark.data.MarkChipTemplateData;   import mark.data.MarkHammerTemplateData;   import mark.data.MarkModel;   import mark.data.MarkProData;   import mark.data.MarkSchemeInfo;   import mark.data.MarkSchemeModel;   import mark.data.MarkTransferTemplateData;   import mark.event.MarkEvent;   import road7th.comm.PackageIn;      public class MarkMgr extends EventDispatcher   {            private static var _inst:MarkMgr = null;                   private var _model:MarkModel;            private var _schemeModel:MarkSchemeModel = null;            private var _markContainer:DisplayObjectContainer = null;            private var _otherContainer:DisplayObjectContainer = null;            private var _treasureRoomContainer:DisplayObjectContainer = null;            private var _alert:BaseAlerFrame = null;            private var _sellAlert:BaseAlerFrame = null;            public var isFarmMark:Boolean = true;            public var treasureRoomLogoIdArr:Array;            public var treasureRoomRewardArr:Array;            public var isFull:Boolean;            public var isOther:Boolean = false;            public var needSave:Boolean = false;            public function MarkMgr(sigle:SingTon) { super(); }
            public static function get inst() : MarkMgr { return null; }
            public function setup() : void { }
            private function __updateChipsInfo(pkg:PkgEvent) : void { }
            public function updateChips(list:Vector.<MarkChipData>) : void { }
            private function __auctionGetMarkTips(e:PkgEvent) : void { }
            public function showMarkView(parent:DisplayObjectContainer, info:PlayerInfo = null) : void { }
            public function showTreasureRoomView() : void { }
            public function setMarkChipTempalte(analyzer:MarkChipAnalyzer) : void { }
            public function setMarkSuitTempalte(analyzer:MarkSuitAnalyzer) : void { }
            public function setMarkProInfo(analyzer:MarkProAnalyzer) : void { }
            public function setMarkSetTempalte(analyzer:MarkSetAnalyzer) : void { }
            public function setMarkHammerTempalte(analyzer:MarkHammerAnalyzer) : void { }
            public function setMarkTransferTempalte(analyzer:MarkTransferAnalyzer) : void { }
            public function showMarkMainFrame() : void { }
            private function disposeBooksAndTreasureRoom() : void { }
            public function removeMarkView() : void { }
            public function chooseEquip(index:int) : void { }
            public function getEquipList() : Array { return null; }
            public function checkTip(catergyId:int, place:int) : Boolean { return false; }
            public function reqOperationStatus(type:int, id:int) : void { }
            public function getHammerData(lv:int, charater:int) : MarkHammerTemplateData { return null; }
            public function getHammerTopLv(charater:int) : int { return 0; }
            public function getTransferData(charater:int, starLv:int) : MarkTransferTemplateData { return null; }
            public function getAttributeAdd(id:int, type:int) : int { return 0; }
            public function getMarkProValue(chip:MarkChipData, type:int) : int { return 0; }
            public function checkMarkOpen(info:PlayerInfo = null) : Boolean { return false; }
            public function get model() : MarkModel { return null; }
            public function submitTransfer() : void { }
            public function submitSell() : void { }
            private function getSellDemand() : int { return 0; }
            private function calculateDemand(id:int) : int { return 0; }
            private function alertHandler(evt:FrameEvent) : void { }
            private function alertSecondHandler(evt:FrameEvent) : void { }
            public function submitHighStarSell() : void { }
            public function sortedProps(props:Dictionary) : Array { return null; }
            public function getEquipProps() : Dictionary { return null; }
            public function calculateEquipProps(place:int) : Dictionary { return null; }
            private function __resSyncOrUpdateChips(pkg:PkgEvent) : void { }
            public function reqSyncOrUpdateChips() : void { }
            public function moveChip(id:int) : void { }
            private function checkChipExist(itemId:int) : Boolean { return false; }
            public function reqSellChips() : void { }
            private function __resHammerChip(pkg:PkgEvent) : void { }
            public function reqHammerChip(cnt:int = 1) : void { }
            private function __resMarkMoney(pkg:PkgEvent) : void { }
            public function reqTransferChip(proKey:int) : void { }
            private function verfyPro(proKey:int) : Boolean { return false; }
            private function __resTransferChip(pkg:PkgEvent) : void { }
            public function reqTransferSubmit(submit:Boolean = true) : void { }
            private function __resTransferSubmit(pkg:PkgEvent) : void { }
            private function __resOperationStatus(pkg:PkgEvent) : void { }
            protected function __onVaultsData(e:PkgEvent) : void { }
            protected function __onVaultsReward(e:PkgEvent) : void { }
            public function get schemeModel() : MarkSchemeModel { return null; }
            public function isCanSellByDebrisID(id:int) : Boolean { return false; }
            public function checkEquipSchemeBagFull(schemeInfo:MarkSchemeInfo) : Boolean { return false; }
            public function reqSaveMarkScheme(schemeID:int) : void { }
            public function reqSwitchEquipScheme(schemeID:int) : void { }
            public function reqAddEquipScheme() : void { }
            public function promptSchemeSave(callFun:Function, params:int = -1) : void { }
            protected function __resEquipScheme(evt:PkgEvent) : void { }
            protected function __resAddEquipScheme(evt:PkgEvent) : void { }
            protected function __resSwitchEquipScheme(evt:PkgEvent) : void { }
            protected function __resSaveScheme(evt:PkgEvent) : void { }
            public function showMark() : void { }
   }}class SingTon{          function SingTon() { super(); }
}