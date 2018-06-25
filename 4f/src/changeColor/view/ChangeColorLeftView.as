package changeColor.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.ChangeColorModel;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.ColorEditor;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ICharacter;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import road7th.utils.StringHelper;      public class ChangeColorLeftView extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _charaterBack:MovieImage;            private var _charaterBack1:MovieImage;            private var _controlBack:MovieImage;            private var _title:DisplayObject;            private var _charater:ICharacter;            private var _hideHat:SelectedCheckButton;            private var _hideGlass:SelectedCheckButton;            private var _hideSuit:SelectedCheckButton;            private var _hideWing:SelectedCheckButton;            private var _cell:ColorEditCell;            private var _cellBg:Scale9CornerImage;            private var _colorEditor:ColorEditor;            private var _model:ChangeColorModel;            private var _checkBg:MovieImage;            private var _itemChanged:Boolean;            public function ChangeColorLeftView() { super(); }
            public function dispose() : void { }
            public function set model(value:ChangeColorModel) : void { }
            public function reset() : void { }
            public function setCurrentItem(cell:BagCell) : void { }
            private function __cellChangedHandler(evt:Event) : void { }
            private function __hideGalssChange(evt:MouseEvent) : void { }
            private function __hideHatChange(evt:MouseEvent) : void { }
            private function __hideSuitChange(evt:MouseEvent) : void { }
            private function __hideWingChange(evt:MouseEvent) : void { }
            private function __setColor(evt:Event) : void { }
            private function dataUpdate() : void { }
            private function initEvents() : void { }
            private function initView() : void { }
            private function removeEvents() : void { }
            private function restoreCharacter() : void { }
            private function restoreItem() : void { }
            private function savaItemInfo() : void { }
            private function setItemColor(item:InventoryItemInfo, color:String) : void { }
            private function setItemSkin(item:InventoryItemInfo, color:String) : void { }
            public function setInitColor() : void { }
            public function setInitSkinColor() : void { }
            private function checkColorChanged(initColor:String, nowColor:String) : Boolean { return false; }
            protected function __reductiveColor(event:Event) : void { }
            private function updateCharator() : void { }
            private function updateColorPanel() : void { }
   }}