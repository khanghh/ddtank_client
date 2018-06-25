package shop.view{   import baglocked.BaglockedManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopCarItemInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.RoomCharacter;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import shop.ShopController;   import shop.ShopEvent;   import shop.ShopModel;      public class ShopLeftView extends Sprite implements Disposeable   {            public static const SHOW_CART:uint = 1;            public static const SHOW_COLOR:uint = 1;            public static const SHOW_DRESS:uint = 0;            public static const SHOW_WEALTH:uint = 0;            public static const COLOR:uint = 1;            public static const SKIN:uint = 2;            private static const MALE:uint = 1;            private static const FEMALE:uint = 2;                   private var _controller:ShopController;            private var _model:ShopModel;            private var prop:ShopLeftViewPropCollection;            private var _isUsed:Boolean = false;            private var latestRandom:int = 0;            private var _isVisible:Boolean = false;            public function ShopLeftView() { super(); }
            public function adjustBottomView(idx:uint) : void { }
            public function getColorEditorVisble() : Boolean { return false; }
            public function adjustUpperView(idx:uint) : void { }
            public function refreshCharater() : void { }
            public function setup(controller:ShopController, model:ShopModel) : void { }
            private function __addCarEquip(evt:ShopEvent) : void { }
            private function __clearClick(evt:MouseEvent) : void { }
            private function __clearLastClick(evt:MouseEvent) : void { }
            private function clearHighLight() : void { }
            private function __conditionChange(evt:Event) : void { }
            private function __deleteItem(evt:Event) : void { }
            private function __addTempEquip(evt:ShopEvent) : void { }
            private function __fittingSexChanged(event:ShopEvent = null) : void { }
            private function __hideGlassChange(evt:Event) : void { }
            private function __hideHatChange(evt:Event) : void { }
            private function __hideSuitesChange(evt:Event) : void { }
            private function __hideWingClickHandler(event:Event) : void { }
            private function __originClick(evt:MouseEvent) : void { }
            private function __panelBtnClickHandler(event:MouseEvent) : void { }
            private function __propertyChange(evt:PlayerPropertyEvent) : void { }
            private function __removeCarEquip(evt:ShopEvent) : void { }
            private function __selectedColorChanged(event:*) : void { }
            private function __topBtnClick(event:MouseEvent = null) : void { }
            private function __update(evt:ShopEvent) : void { }
            private function __updateColorEditor(e:ShopEvent = null) : void { }
            private function addCarEquip(info:ShopCarItemInfo) : void { }
            private function checkShiner(e:Event = null) : void { }
            private function initEvent() : void { }
            private function __cellClick(evt:MouseEvent) : void { }
            private function __updateCar(e:ShopEvent) : void { }
            private function removeEvents() : void { }
            private function __purchaseClick(evt:MouseEvent) : void { }
            private function askHander(evt:MouseEvent) : void { }
            private function __random(event:MouseEvent) : void { }
            private function __saveFigureClick(evt:MouseEvent) : void { }
            private function __presentClick(evt:MouseEvent) : void { }
            private function __itemInfoChange(evt:Event) : void { }
            private function __removeTempEquip(evt:ShopEvent) : void { }
            private function __selectedEquipChange(evt:ShopEvent) : void { }
            private function setColorLayer(color:int) : void { }
            private function setSkinColor(color:String) : void { }
            protected function __reductiveColor(event:Event) : void { }
            private function _changeColor(event:Event) : void { }
            private function _showLight(event:Event) : void { }
            private function showShine() : void { }
            public function hideLight() : void { }
            private function updateButtons() : void { }
            public function dispose() : void { }
   }}