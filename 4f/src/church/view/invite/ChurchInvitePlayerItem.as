package church.view.invite
{
   import church.ChurchManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import invite.data.InvitePlayerInfo;
   import vip.VipController;
   
   public class ChurchInvitePlayerItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _playerInfo:InvitePlayerInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _inviteItemInfo:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _inviteBtn:TextButton;
      
      private var _itemLine:TiledImage;
      
      private var _isInvite:Boolean;
      
      private var _isSelected:Boolean;
      
      private var _masterIcon:ScaleFrameImage;
      
      private var _itemBG:DisplayObject;
      
      private var _data:Object;
      
      private var _index:int;
      
      public function ChurchInvitePlayerItem(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      public function set isInvite(param1:Boolean) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function get isSelected() : Boolean{return false;}
      
      private function update() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
