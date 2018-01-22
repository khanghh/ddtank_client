package roomList.pvpRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerTipManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class RoomListPlayerItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _info:PlayerInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _name:FilterFrameText;
      
      private var _BG:Bitmap;
      
      private var _isSelected:Boolean;
      
      private var _vipName:GradientText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function RoomListPlayerItem(){super();}
      
      private function init() : void{}
      
      private function itemClick(param1:MouseEvent) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function get isSelected() : Boolean{return false;}
      
      private function update() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
