package calendar.view
{
   import bagAndInfo.cell.BagCell;
   import calendar.CalendarControl;
   import calendar.CalendarManager;
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SignAwardBar extends Sprite implements Disposeable
   {
       
      
      private var _items:Vector.<NavigItem>;
      
      private var _itemsHbox:HBox;
      
      private var _current:NavigItem;
      
      private var _model:CalendarModel;
      
      private var _back:DisplayObject;
      
      private var _title:DisplayObject;
      
      private var _awardHolder:SignedAwardHolder;
      
      private var _signCoundField:FilterFrameText;
      
      private var _selectedItem:NavigItem;
      
      private var _signedTimesPanel:Image;
      
      public var _petBtn:SimpleBitmapButton;
      
      private var receivedBG:Bitmap;
      
      public function SignAwardBar(param1:CalendarModel){super();}
      
      private function configUI() : void{}
      
      private function returnPetIsShow(param1:int) : Boolean{return false;}
      
      private function returnPetID() : Object{return null;}
      
      private function drawCells() : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      private function reset() : void{}
      
      private function __signCountChanged(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onPetShow(param1:Event) : void{}
      
      private function __onPetBtnClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
