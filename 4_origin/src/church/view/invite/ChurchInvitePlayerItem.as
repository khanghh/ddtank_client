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
      
      public function ChurchInvitePlayerItem()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _itemBG = ComponentFactory.Instance.creatCustomObject("church.ChurchInvitePlayerItem.listItemBG");
         addChild(_itemBG);
         _itemLine = ComponentFactory.Instance.creatComponentByStylename("church.ChurchInvitePlayerItem.VerticalLine");
         addChild(_itemLine);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomInviteItemLevelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomInviteItemSexIcon");
         _sexIcon.size = 0.8;
         addChild(_sexIcon);
         _masterIcon = UICreatShortcut.creatAndAdd("church.invite.masterRelationIcon",this);
         _masterIcon.visible = false;
         _inviteItemInfo = ComponentFactory.Instance.creat("church.room.inviteItemInfoAsset");
         addChild(_inviteItemInfo);
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("church.room.inviteItemInviteBtnAsset");
         _inviteBtn.text = LanguageMgr.GetTranslation("im.InviteDialogFrame.Title");
         addChild(_inviteBtn);
      }
      
      private function initEvent() : void
      {
         _inviteBtn.addEventListener("click",__mouseClick);
      }
      
      private function __mouseClick(evt:MouseEvent) : void
      {
         if(_playerInfo.invited)
         {
            return;
         }
         SoundManager.instance.play("008");
         _inviteBtn.enable = false;
         _inviteBtn.filters = [ComponentFactory.Instance.model.getSet("church.room.inviteItemInviteBtnAssetGF1")];
         _playerInfo.invited = true;
         var roominfo:ChurchRoomInfo = ChurchManager.instance.currentRoom;
         if(_playerInfo is ConsortiaPlayerInfo)
         {
            SocketManager.Instance.out.sendChurchInvite(_playerInfo.ID);
         }
         else
         {
            SocketManager.Instance.out.sendChurchInvite(_playerInfo.ID);
         }
         _playerInfo.invited = true;
      }
      
      public function set isInvite(value:Boolean) : void
      {
         _isInvite = value;
         if(_playerInfo.invited)
         {
            _inviteBtn.removeEventListener("click",__mouseClick);
         }
         else
         {
            _inviteBtn.addEventListener("click",__mouseClick);
         }
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _isSelected = isSelected;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value;
         _playerInfo = value.playerInfo;
         _index = value.index;
         update();
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      private function update() : void
      {
         _itemBG.visible = !!(_index % 2)?false:true;
         if(!_playerInfo.invited)
         {
            _inviteBtn.enable = true;
            _inviteBtn.filters = null;
         }
         _inviteItemInfo.text = _playerInfo.NickName;
         if(_playerInfo.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(115,_playerInfo.typeVIP);
            _vipName.x = _inviteItemInfo.x;
            _vipName.y = _inviteItemInfo.y;
            _vipName.text = _inviteItemInfo.text;
            addChild(_vipName);
            DisplayUtils.removeDisplay(_inviteItemInfo);
         }
         else
         {
            addChild(_inviteItemInfo);
            DisplayUtils.removeDisplay(_vipName);
         }
         _sexIcon.setSex(_playerInfo.Sex);
         _masterIcon.visible = PlayerManager.Instance.Self.ID != _playerInfo.ID && (PlayerManager.Instance.Self.isMyApprent(_playerInfo.ID) || PlayerManager.Instance.Self.isMyMaster(_playerInfo.ID));
         _sexIcon.visible = !_masterIcon.visible;
         _levelIcon.setInfo(_playerInfo.Grade,_playerInfo.ddtKingGrade,_playerInfo.Repute,_playerInfo.WinCount,_playerInfo.TotalCount,_playerInfo.FightPower,_playerInfo.Offer,true,false);
         if(PlayerManager.Instance.Self.isMyMaster(_playerInfo.ID))
         {
            if(_playerInfo.Sex)
            {
               _masterIcon.setFrame(1);
            }
            else
            {
               _masterIcon.setFrame(2);
            }
         }
         else if(_playerInfo.Sex)
         {
            _masterIcon.setFrame(3);
         }
         else
         {
            _masterIcon.setFrame(4);
         }
         initEvent();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         _inviteBtn.removeEventListener("click",__mouseClick);
         ObjectUtils.disposeObject(_itemBG);
         _itemBG = null;
         ObjectUtils.disposeObject(_itemLine);
         _itemLine = null;
         _playerInfo = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_sexIcon);
         _sexIcon = null;
         ObjectUtils.disposeObject(_masterIcon);
         _masterIcon = null;
         ObjectUtils.disposeObject(_inviteItemInfo);
         _inviteItemInfo = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_itemLine);
         _itemLine = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
