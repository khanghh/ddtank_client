package playerDress.views{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.events.PkgEvent;   import ddt.manager.DraftManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.RoomCharacter;   import ddt.view.tips.OneLineTip;   import draft.data.DraftModel;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import playerDress.PlayerDressControl;   import playerDress.PlayerDressManager;   import playerDress.components.DressCell;   import playerDress.components.DressModel;   import playerDress.components.DressUtils;   import playerDress.data.DressVo;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;   import trainer.view.NewHandContainer;      public class PlayerDressView extends Sprite implements Disposeable   {            public static const CELLS_LENGTH:uint = 8;            public static const NEED_GOLD:int = 5000;                   private var _BG:ScaleFrameImage;            private var _character:RoomCharacter;            private var _hidePanel:MovieImage;            private var _uploadBtn:SimpleBitmapButton;            private var _saveBtn:SimpleBitmapButton;            private var _selectedBox:ComboBox;            private var _okBtn:SimpleBitmapButton;            private var _okBtnSprite:Sprite;            private var _okBtnTip:OneLineTip;            private var _descTxt:FilterFrameText;            private var _hideSprite:Sprite;            private var _hideHatBtn:SelectedCheckButton;            private var _hideGlassBtn:SelectedCheckButton;            private var _hideSuitBtn:SelectedCheckButton;            private var _hideWingBtn:SelectedCheckButton;            private var _dressCells:Vector.<BagCell>;            private var _helpBtn:BaseButton;            private var _currentModel:DressModel;            private var _currentIndex:int;            private var _comboBoxArr:Array;            private var _self:PlayerInfo;            private var _bodyThings:DictionaryData;            private var _stylePrice:int;            private var _money:int = 100;            private var saveBtnClick:Boolean = false;            public function PlayerDressView() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function updateView() : void { }
            public function updateModel() : void { }
            public function putOnDress(item:InventoryItemInfo) : void { }
            private function initEvent() : void { }
            private function __onAddIsSuccess(e:PkgEvent) : void { }
            protected function __onUpLoadClick(event:MouseEvent) : void { }
            private function onBuyConfirmResponse(e:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            protected function __updateGoods(event:BagEvent) : void { }
            protected function __cellDoubleClick(event:CellEvent) : void { }
            protected function __okBtnClick(event:MouseEvent) : void { }
            private function exchangeProperty() : void { }
            protected function __saveBtnClick(event:MouseEvent) : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function save() : void { }
            private function saveModel() : void { }
            protected function __onListClick(event:ListItemEvent) : void { }
            private function __alertAllBack(event:FrameEvent) : void { }
            private function updateComboBox(obj:*) : void { }
            private function updateHideCheckBox() : void { }
            private function updateCharacter() : void { }
            public function setBtnsStatus() : void { }
            private function canSaveBtnClick() : Boolean { return false; }
            private function canOKBtnClick() : Boolean { return false; }
            private function checkOverDue(item:InventoryItemInfo) : Boolean { return false; }
            private function __hideWingClickHandler(event:Event) : void { }
            private function __hideSuitesChange(event:Event) : void { }
            private function __hideGlassChange(event:Event) : void { }
            private function __hideHatChange(event:Event) : void { }
            private function enableOKBtn(enable:Boolean) : void { }
            protected function __okBtnOverHandler(event:MouseEvent) : void { }
            protected function __okBtnOutHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}