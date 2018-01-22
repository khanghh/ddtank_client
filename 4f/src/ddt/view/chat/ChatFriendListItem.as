package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ChatFriendListItem extends Sprite implements IListCell, Disposeable
   {
      
      public static const SELECT:String = "select";
       
      
      private var _bg:Bitmap;
      
      private var _contentTxt:TextField;
      
      private var _fun:Function;
      
      private var _info:BasePlayer;
      
      private var _spaceLine:Bitmap;
      
      public function ChatFriendListItem(){super();}
      
      public function dispose() : void{}
      
      public function get info() : BasePlayer{return null;}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function updateItem() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
