package petsBag.view{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import pet.data.PetInfo;   import petsBag.PetsBagManager;   import petsBag.view.item.PetBigItem;   import petsBag.view.item.PetWashBoneGrade;   import petsBag.view.item.PetWashBoneProItem;   import petsBag.view.item.StarBar;   import road7th.data.DictionaryData;      public class PetWashBoneView extends Sprite implements Disposeable   {            private static const LOCK_COUNT:int = 4;                   protected var _bg:Bitmap;            private var _starBar:StarBar;            private var _petBigItem:PetBigItem;            private var _petName:FilterFrameText;            private var _lv:Bitmap;            private var _lvTxt:FilterFrameText;            private var _petGrade:PetWashBoneGrade;            private var _goodCell:BagCell;            private var _proGrowTxt:FilterFrameText;            private var _proMaxTxt:FilterFrameText;            private var _descTxt:FilterFrameText;            private var _curPetInfo:PetInfo;            private var _proItems:Array;            private var _proVBox:VBox;            private var _washBoneBtn:BaseButton;            private var prosArr:Array;            private var _confirmFrame:BaseAlerFrame;            private var _haveWashBoneCount:int;            private var _gradeArr:Array;            public function PetWashBoneView() { super(); }
            protected function initView() : void { }
            private function __updateCostCount(evt:CEvent) : void { }
            private function updateCellCount() : void { }
            private function __washBoneHandler(evt:MouseEvent) : void { }
            protected function __onSelectCheckClick(e:MouseEvent) : void { }
            private function __onAlertFrame(e:FrameEvent) : void { }
            private function updatePetPro(evt:CEvent) : void { }
            protected function __updateBag(event:BagEvent) : void { }
            private function updateData() : void { }
            private function sendWashBone() : void { }
            private function getProLockState() : Array { return null; }
            private function get goodCountEnough() : Boolean { return false; }
            private function get getWashBoneCount() : int { return 0; }
            private function get getProLockCount() : int { return 0; }
            private function get getProLockCost() : int { return 0; }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}