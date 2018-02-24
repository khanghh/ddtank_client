package invite.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import game.GameManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   import vip.VipController;
   
   public class InviteListCell extends Sprite implements Disposeable, IListCell
   {
      
      private static const LevelLimit:int = 6;
      
      private static const RoomTypeLimit:int = 2;
       
      
      public var roomType:int;
      
      private var _data:Object;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _masterIcon:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _BG:Bitmap;
      
      private var _BGII:Bitmap;
      
      private var _isSelected:Boolean;
      
      private var _inviteButton:TextButton;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _titleBG:ScaleFrameImage;
      
      private var _triangle:ScaleFrameImage;
      
      private var _titleText:FilterFrameText;
      
      private var _numText:FilterFrameText;
      
      public function InviteListCell(){super();}
      
      public function dispose() : void{}
      
      private function configUi() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onInviteClick(param1:MouseEvent) : void{}
      
      private function inviteLvTip(param1:int) : Boolean{return false;}
      
      private function checkLevel(param1:int) : Boolean{return false;}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function update() : void{}
      
      private function updateItemState() : void{}
      
      private function __itemOver(param1:MouseEvent) : void{}
      
      private function __itemOut(param1:MouseEvent) : void{}
      
      private function showTitle(param1:Boolean) : void{}
      
      private function updateTitle() : void{}
      
      private function updatePlayer() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
