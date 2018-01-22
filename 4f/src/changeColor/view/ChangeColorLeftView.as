package changeColor.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChangeColorModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.ColorEditor;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import road7th.utils.StringHelper;
   
   public class ChangeColorLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _charaterBack:MovieImage;
      
      private var _charaterBack1:MovieImage;
      
      private var _controlBack:MovieImage;
      
      private var _title:DisplayObject;
      
      private var _charater:ICharacter;
      
      private var _hideHat:SelectedCheckButton;
      
      private var _hideGlass:SelectedCheckButton;
      
      private var _hideSuit:SelectedCheckButton;
      
      private var _hideWing:SelectedCheckButton;
      
      private var _cell:ColorEditCell;
      
      private var _cellBg:Scale9CornerImage;
      
      private var _colorEditor:ColorEditor;
      
      private var _model:ChangeColorModel;
      
      private var _checkBg:MovieImage;
      
      private var _itemChanged:Boolean;
      
      public function ChangeColorLeftView(){super();}
      
      public function dispose() : void{}
      
      public function set model(param1:ChangeColorModel) : void{}
      
      public function reset() : void{}
      
      public function setCurrentItem(param1:BagCell) : void{}
      
      private function __cellChangedHandler(param1:Event) : void{}
      
      private function __hideGalssChange(param1:MouseEvent) : void{}
      
      private function __hideHatChange(param1:MouseEvent) : void{}
      
      private function __hideSuitChange(param1:MouseEvent) : void{}
      
      private function __hideWingChange(param1:MouseEvent) : void{}
      
      private function __setColor(param1:Event) : void{}
      
      private function dataUpdate() : void{}
      
      private function initEvents() : void{}
      
      private function initView() : void{}
      
      private function removeEvents() : void{}
      
      private function restoreCharacter() : void{}
      
      private function restoreItem() : void{}
      
      private function savaItemInfo() : void{}
      
      private function setItemColor(param1:InventoryItemInfo, param2:String) : void{}
      
      private function setItemSkin(param1:InventoryItemInfo, param2:String) : void{}
      
      public function setInitColor() : void{}
      
      public function setInitSkinColor() : void{}
      
      private function checkColorChanged(param1:String, param2:String) : Boolean{return false;}
      
      protected function __reductiveColor(param1:Event) : void{}
      
      private function updateCharator() : void{}
      
      private function updateColorPanel() : void{}
   }
}
