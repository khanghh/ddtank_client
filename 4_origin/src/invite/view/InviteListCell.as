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
      
      public function InviteListCell()
      {
         super();
         configUi();
         addEvent();
         mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_titleBG)
         {
            ObjectUtils.disposeObject(_titleBG);
            _titleBG = null;
         }
         if(_triangle)
         {
            ObjectUtils.disposeObject(_triangle);
            _triangle = null;
         }
         if(_titleText)
         {
            ObjectUtils.disposeObject(_titleText);
            _titleText = null;
         }
         if(_numText)
         {
            ObjectUtils.disposeObject(_numText);
            _numText = null;
         }
         if(_inviteButton)
         {
            ObjectUtils.disposeObject(_inviteButton);
            _inviteButton = null;
         }
         if(_sexIcon)
         {
            ObjectUtils.disposeObject(_sexIcon);
            _sexIcon = null;
         }
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
            _name = null;
         }
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
            _attestBtn = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function configUi() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.cell.playerItemName");
         _levelIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtinvite.cell.LevelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = ComponentFactory.Instance.creatCustomObject("asset.ddtinvite.cell.SexIcon");
         addChild(_sexIcon);
         _masterIcon = UICreatShortcut.creatAndAdd("asset.ddtinvite.cell.masterRelationIcon",this);
         _inviteButton = ComponentFactory.Instance.creatComponentByStylename("asset.ddtinvite.cell.inviteBtn");
         _inviteButton.text = LanguageMgr.GetTranslation("im.InviteDialogFrame.Title");
         addChild(_inviteButton);
         _titleBG = ComponentFactory.Instance.creat("ddtinvite.titleItemBg");
         _titleBG.setFrame(1);
         addChild(_titleBG);
         _triangle = ComponentFactory.Instance.creatComponentByStylename("ddtinvite.triangle");
         _triangle.setFrame(1);
         addChild(_triangle);
         _titleText = ComponentFactory.Instance.creat("IM.item.title");
         PositionUtils.setPos(_titleText,"ddtinvite.titleTxtPos");
         _titleText.text = "";
         addChild(_titleText);
         _numText = ComponentFactory.Instance.creat("IM.item.title");
         _numText.text = "";
         _numText.y = _titleText.y;
         addChild(_numText);
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
         _inviteButton.addEventListener("click",__onInviteClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__itemOut);
         _inviteButton.removeEventListener("click",__onInviteClick);
      }
      
      private function __onInviteClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(_loc2_ != null)
         {
            if(_loc2_.placeCount < 1)
            {
               if(_loc2_.players.length > 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIBGView.room"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.noplacetoinvite"));
               }
               return;
            }
            _inviteButton.enable = false;
            _inviteButton.filters = [ComponentFactory.Instance.model.getSet("asset.ddtinvite.GF4")];
            _data.invited = true;
            if(_loc2_.type == 0)
            {
               if(inviteLvTip(6))
               {
                  return;
               }
            }
            else if(_loc2_.type == 1)
            {
               if(inviteLvTip(12))
               {
                  return;
               }
            }
            else if(_loc2_.type == 49)
            {
               if(inviteLvTip(20))
               {
                  return;
               }
            }
            if((_loc2_.type == 4 || _loc2_.type == 11 || _loc2_.type == 23 || _loc2_.type == 123) && _data.Grade < GameManager.MinLevelDuplicate)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.gradeLow",GameManager.MinLevelDuplicate));
               return;
            }
            if(_loc2_.type == 21 && _data.Grade < GameManager.MinLevelActivity)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.PlayerManager.activityLow",GameManager.MinLevelActivity));
               return;
            }
         }
         else
         {
            _inviteButton.enable = false;
            _inviteButton.filters = [ComponentFactory.Instance.model.getSet("asset.ddtinvite.GF4")];
            _data.invited = true;
            if(checkLevel(_data.Grade))
            {
               SocketManager.Instance.out.sendInviteYearFoodRoom(false,_data.ID);
            }
         }
         if(_data is ConsortiaPlayerInfo)
         {
            if(checkLevel(_data.info.Grade))
            {
               GameInSocketOut.sendInviteGame(_data.info.ID);
            }
         }
         else if(checkLevel(_data.Grade))
         {
            GameInSocketOut.sendInviteGame(_data.ID);
         }
      }
      
      private function inviteLvTip(param1:int) : Boolean
      {
         if(_data is ConsortiaPlayerInfo)
         {
            if(_data.info.Grade < param1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.invite.InvitePlayerItem.cannot",param1));
               return true;
            }
         }
         else if(_data.Grade < param1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.invite.InvitePlayerItem.cannot",param1));
            return true;
         }
         return false;
      }
      
      private function checkLevel(param1:int) : Boolean
      {
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(_loc2_ != null)
         {
            if(_loc2_.type > 2)
            {
               if(param1 < GameManager.MinLevelDuplicate)
               {
                  return false;
               }
            }
            else if(_loc2_.type == 2)
            {
               if((_loc2_.levelLimits - 1) * 10 > param1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         update();
      }
      
      private function update() : void
      {
         if(_data.type == 0)
         {
            updateTitle();
         }
         else
         {
            updatePlayer();
         }
         if(_triangle.visible)
         {
            updateItemState();
         }
      }
      
      private function updateItemState() : void
      {
         if(_data.titleIsSelected)
         {
            _triangle.setFrame(2);
            _titleBG.setFrame(2);
            _titleBG.alpha = 1;
         }
         else
         {
            _triangle.setFrame(1);
            _titleBG.setFrame(1);
            _titleBG.alpha = 0;
         }
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         _titleBG.alpha = 1;
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         if(_titleBG.visible && !_data.titleIsSelected)
         {
            _titleBG.alpha = 0;
         }
      }
      
      private function showTitle(param1:Boolean) : void
      {
         _name.visible = !param1;
         _levelIcon.visible = !param1;
         _sexIcon.visible = !param1;
         _masterIcon.visible = !param1;
         _inviteButton.visible = !param1;
         if(_attestBtn != null)
         {
            _attestBtn.visible = !param1;
         }
         if(_vipName)
         {
            _vipName.visible = !param1;
         }
         this.buttonMode = param1;
         _titleBG.visible = param1;
         _titleBG.alpha = 0;
         _triangle.visible = param1;
         _titleText.visible = param1;
         _numText.visible = param1;
      }
      
      private function updateTitle() : void
      {
         showTitle(true);
         _triangle.setFrame(1);
         _titleText.text = _data.titleText;
         _numText.text = _data.titleNumText;
         _numText.x = _titleText.x + _titleText.width;
      }
      
      private function updatePlayer() : void
      {
         showTitle(false);
         if(!_data.invited)
         {
            _inviteButton.enable = true;
            _inviteButton.filters = null;
         }
         _name.text = _data.NickName;
         if(_data.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(121,_data.typeVIP);
            _vipName.x = _name.x;
            _vipName.y = _name.y;
            _vipName.text = _name.text;
            addChild(_vipName);
            DisplayUtils.removeDisplay(_name);
         }
         addChild(_name);
         PositionUtils.adaptNameStyle(BasePlayer(_data),_name,_vipName);
         _sexIcon.setSex(_data.Sex);
         _levelIcon.setInfo(_data.Grade,_data.ddtKingGrade,_data.Repute,_data.WinCount,_data.TotalCount,_data.FightPower,_data.Offer,true,false);
         _masterIcon.visible = PlayerManager.Instance.Self.isMyApprent(_data.ID) || PlayerManager.Instance.Self.isMyMaster(_data.ID);
         _sexIcon.visible = !_masterIcon.visible;
         if(PlayerManager.Instance.Self.isMyMaster(_data.ID))
         {
            if(_data.Sex)
            {
               _masterIcon.setFrame(1);
            }
            else
            {
               _masterIcon.setFrame(2);
            }
         }
         else if(_data.Sex)
         {
            _masterIcon.setFrame(3);
         }
         else
         {
            _masterIcon.setFrame(4);
         }
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_data.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
               _attestBtn.x = _sexIcon.x - 4;
               _attestBtn.y = _sexIcon.y - 4;
            }
            _sexIcon.visible = false;
            _attestBtn.visible = true;
         }
         else
         {
            _sexIcon.visible = true;
            if(_attestBtn != null)
            {
               _attestBtn.visible = false;
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
