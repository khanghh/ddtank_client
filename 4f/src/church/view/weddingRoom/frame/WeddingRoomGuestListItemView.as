package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import church.view.menu.MenuView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class WeddingRoomGuestListItemView extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _playerInfo:PlayerInfo;
      
      private var _index:int;
      
      private var _levelIcon:LevelIcon;
      
      private var _txtItemInfo:FilterFrameText;
      
      private var _ltemBgAc:Bitmap;
      
      private var _sexIcon:SexIcon;
      
      private var _isSelected:Boolean;
      
      private var _vipName:GradientText;
      
      private var _itemBG:DisplayObject;
      
      private var _line:TiledImage;
      
      public function WeddingRoomGuestListItemView(){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      private function setEvent() : void{}
      
      private function itemClick(param1:MouseEvent) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function get isSelected() : Boolean{return false;}
      
      private function update() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      private function removeView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
