package farm.viewx.helper{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.modelx.FieldVO;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class HelperItem extends Sprite   {                   private var _itemBG:ScaleFrameImage;            private var _fieldVO:FieldVO;            private var _fieldIndex:FilterFrameText;            private var _SeedTxt:FilterFrameText;            private var _SeedNumTxt:FilterFrameText;            private var _FertilizerTxt:FilterFrameText;            private var _FertilizerNumTxt:FilterFrameText;            private var _cbxSeed:ComboBox;            private var _cbxFertilizer:ComboBox;            private var _btnIsAuto:BaseButton;            private var _light:Scale9CornerImage;            private var _seedInfos:Dictionary;            private var _fertilizerInfos:Dictionary;            private var _txtIsAutoArray:Array;            private var _selectTipMsg:String;            public var _isAutoFunction:Function;            private var _btnState:Boolean;            private var _currentFrame:int;            private var _index:int;            private var _isSelected:Boolean;            private var _state:int;            private var _findNumState:Function;            private var _helperSetView:HelperSetView;            public function HelperItem() { super(); }
            public function initView(state:int = 0) : void { }
            public function set index(value:int) : void { }
            private function initEvent() : void { }
            private function __cbxSeedChange(evt:ListItemEvent) : void { }
            private function __fertilizerChange(evt:ListItemEvent) : void { }
            private function __mouseOverHandler(evt:MouseEvent) : void { }
            private function __mouseOutHandler(evt:MouseEvent) : void { }
            public function isSelelct(b:Boolean) : void { }
            public function getCellValue() : * { return null; }
            public function set btnState(value:Boolean) : void { }
            public function get btnState() : Boolean { return false; }
            public function get currentFertilizer() : String { return null; }
            public function get currentFertilizerNum() : int { return 0; }
            public function get currentSeed() : String { return null; }
            public function get currentSeedNum() : int { return 0; }
            public function get currentfindIndex() : int { return 0; }
            public function get currentFieldID() : int { return 0; }
            public function setCellValue(value:*) : void { }
            private function setDropListClickable(pIsClickable:Boolean) : void { }
            private function setSeedPanelData() : void { }
            private function setFertilizerPanelData() : void { }
            private function __seedCheck() : Boolean { return false; }
            public function set findNumState(value:Function) : void { }
            private function __seedItemClickCheck() : Boolean { return false; }
            private function __fertilizerItemClickCheck() : Boolean { return false; }
            private function __isAutoClick(event:MouseEvent) : void { }
            private function __helperSetViewSelect(info:Object) : void { }
            public function get getSetViewItemData() : Object { return null; }
            public function get getItemData() : Object { return null; }
            public function onKeyStart() : Boolean { return false; }
            public function onKeyStop() : Boolean { return false; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}