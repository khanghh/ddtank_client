package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import shop.ShopController;
   import shop.ShopEvent;
   import shop.ShopModel;
   
   public class ShopLeftView extends Sprite implements Disposeable
   {
      
      public static const SHOW_CART:uint = 1;
      
      public static const SHOW_COLOR:uint = 1;
      
      public static const SHOW_DRESS:uint = 0;
      
      public static const SHOW_WEALTH:uint = 0;
      
      public static const COLOR:uint = 1;
      
      public static const SKIN:uint = 2;
      
      private static const MALE:uint = 1;
      
      private static const FEMALE:uint = 2;
       
      
      private var _controller:ShopController;
      
      private var _model:ShopModel;
      
      private var prop:ShopLeftViewPropCollection;
      
      private var _isUsed:Boolean = false;
      
      private var latestRandom:int = 0;
      
      private var _isVisible:Boolean = false;
      
      public function ShopLeftView(){super();}
      
      public function adjustBottomView(param1:uint) : void{}
      
      public function getColorEditorVisble() : Boolean{return false;}
      
      public function adjustUpperView(param1:uint) : void{}
      
      public function refreshCharater() : void{}
      
      public function setup(param1:ShopController, param2:ShopModel) : void{}
      
      private function __addCarEquip(param1:ShopEvent) : void{}
      
      private function __clearClick(param1:MouseEvent) : void{}
      
      private function __clearLastClick(param1:MouseEvent) : void{}
      
      private function clearHighLight() : void{}
      
      private function __conditionChange(param1:Event) : void{}
      
      private function __deleteItem(param1:Event) : void{}
      
      private function __addTempEquip(param1:ShopEvent) : void{}
      
      private function __fittingSexChanged(param1:ShopEvent = null) : void{}
      
      private function __hideGlassChange(param1:Event) : void{}
      
      private function __hideHatChange(param1:Event) : void{}
      
      private function __hideSuitesChange(param1:Event) : void{}
      
      private function __hideWingClickHandler(param1:Event) : void{}
      
      private function __originClick(param1:MouseEvent) : void{}
      
      private function __panelBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function __removeCarEquip(param1:ShopEvent) : void{}
      
      private function __selectedColorChanged(param1:*) : void{}
      
      private function __topBtnClick(param1:MouseEvent = null) : void{}
      
      private function __update(param1:ShopEvent) : void{}
      
      private function __updateColorEditor(param1:ShopEvent = null) : void{}
      
      private function addCarEquip(param1:ShopCarItemInfo) : void{}
      
      private function checkShiner(param1:Event = null) : void{}
      
      private function initEvent() : void{}
      
      private function __cellClick(param1:MouseEvent) : void{}
      
      private function __updateCar(param1:ShopEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __purchaseClick(param1:MouseEvent) : void{}
      
      private function askHander(param1:MouseEvent) : void{}
      
      private function __random(param1:MouseEvent) : void{}
      
      private function __saveFigureClick(param1:MouseEvent) : void{}
      
      private function __presentClick(param1:MouseEvent) : void{}
      
      private function __itemInfoChange(param1:Event) : void{}
      
      private function __removeTempEquip(param1:ShopEvent) : void{}
      
      private function __selectedEquipChange(param1:ShopEvent) : void{}
      
      private function setColorLayer(param1:int) : void{}
      
      private function setSkinColor(param1:String) : void{}
      
      protected function __reductiveColor(param1:Event) : void{}
      
      private function _changeColor(param1:Event) : void{}
      
      private function _showLight(param1:Event) : void{}
      
      private function showShine() : void{}
      
      public function hideLight() : void{}
      
      private function updateButtons() : void{}
      
      public function dispose() : void{}
   }
}
