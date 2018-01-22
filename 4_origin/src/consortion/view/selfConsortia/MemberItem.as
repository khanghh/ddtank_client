package consortion.view.selfConsortia
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class MemberItem extends Sprite implements Disposeable, IListCell
   {
      
      public static const MAX_OFFLINE_HOURS:int = 720;
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _light:Scale9CornerImage;
      
      private var _name:FilterFrameText;
      
      private var _nameForVip:GradientText;
      
      private var _job:FilterFrameText;
      
      private var _offer:FilterFrameText;
      
      private var _week:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _offLine:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _playerInfo:ConsortiaPlayerInfo;
      
      private var _isSelected:Boolean;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function MemberItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("memberItem.BG");
         _name = ComponentFactory.Instance.creatComponentByStylename("memberItem.commonName");
         _job = ComponentFactory.Instance.creatComponentByStylename("memberItem.job");
         _offer = ComponentFactory.Instance.creatComponentByStylename("memberItem.offer");
         _week = ComponentFactory.Instance.creatComponentByStylename("memberItem.week");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("memberItem.fightPower");
         _offLine = ComponentFactory.Instance.creatComponentByStylename("memberItem.offline");
         _levelIcon = ComponentFactory.Instance.creatCustomObject("memberItem.level");
         _levelIcon.setSize(1);
         _light = ComponentFactory.Instance.creatComponentByStylename("consortion.memberItem.light");
         addChild(_itemBG);
         addChild(_job);
         addChild(_levelIcon);
         addChild(_offer);
         addChild(_week);
         addChild(_fightPower);
         addChild(_offLine);
         addChild(_light);
         var _loc1_:* = false;
         _light.visible = _loc1_;
         _loc1_ = _loc1_;
         _light.mouseEnabled = _loc1_;
         _light.mouseChildren = _loc1_;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__onItmeClickHandler);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onItmeClickHandler);
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__selfPropertyHanlder);
      }
      
      private function __onItmeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerTipManager.show(_playerInfo,StageReferance.stage.mouseY);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _light.visible = _isSelected;
      }
      
      public function isSelelct(param1:Boolean) : void
      {
         _isSelected = param1;
         _light.visible = param1;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         if(_playerInfo == null || _playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            if(param3 % 2 != 0)
            {
               _itemBG.setFrame(2);
            }
            else
            {
               _itemBG.setFrame(1);
            }
         }
         if(_playerInfo)
         {
            isSelelct(param2);
         }
      }
      
      public function getCellValue() : *
      {
         return _playerInfo;
      }
      
      public function setCellValue(param1:*) : void
      {
         _playerInfo = param1;
         if(_playerInfo == null)
         {
            isSelelct(false);
            mouseEnabled = false;
            mouseChildren = false;
            setVisible(false);
         }
         else
         {
            mouseEnabled = true;
            mouseChildren = true;
            setVisible(true);
            setName();
            if(_playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               _itemBG.setFrame(3);
               PlayerManager.Instance.Self.addEventListener("propertychange",__selfPropertyHanlder);
               _offer.text = String(PlayerManager.Instance.Self.UseOffer);
            }
            else
            {
               PlayerManager.Instance.Self.removeEventListener("propertychange",__selfPropertyHanlder);
               _offer.text = String(_playerInfo.UseOffer);
            }
            _week.text = String(_playerInfo.LastWeekRichesOffer);
            _job.text = _playerInfo.DutyName;
            _levelIcon.setInfo(_playerInfo.Grade,_playerInfo.ddtKingGrade,_playerInfo.Repute,_playerInfo.WinCount,_playerInfo.TotalCount,_playerInfo.FightPower,_playerInfo.Offer);
            _fightPower.text = String(_playerInfo.FightPower);
            if(_playerInfo.playerState.StateID != 0)
            {
               _offLine.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.offlineTxt");
            }
            else if(_playerInfo.playerState.StateID == 0)
            {
               if(_playerInfo.OffLineHour == -1)
               {
                  _offLine.text = _playerInfo.minute + LanguageMgr.GetTranslation("tank.hotSpring.room.time.minute");
               }
               else if(_playerInfo.OffLineHour >= 1 && _playerInfo.OffLineHour < 24)
               {
                  _offLine.text = _playerInfo.OffLineHour + LanguageMgr.GetTranslation("hours");
               }
               else if(_playerInfo.OffLineHour >= 24 && _playerInfo.OffLineHour < 720)
               {
                  _offLine.text = _playerInfo.day + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.day");
               }
               else if(_playerInfo.OffLineHour >= 720 && _playerInfo.OffLineHour < 999)
               {
                  _offLine.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.month");
               }
               else
               {
                  _offLine.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.long");
               }
            }
         }
      }
      
      private function __selfPropertyHanlder(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["RichesOffer"] || param1.changedProperties["UseOffer"])
         {
            _offer.text = String(PlayerManager.Instance.Self.UseOffer);
         }
         if(param1.changedProperties["isVip"])
         {
            setName();
         }
      }
      
      private function setVisible(param1:Boolean) : void
      {
         if(_nameForVip)
         {
            _nameForVip.visible = param1;
         }
         _name.visible = param1;
         _job.visible = param1;
         _levelIcon.visible = param1;
         _offer.visible = param1;
         _week.visible = param1;
         _fightPower.visible = param1;
         _offLine.visible = param1;
      }
      
      private function setName() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _loc2_ = PlayerManager.Instance.Self;
         }
         else
         {
            _loc2_ = _playerInfo;
         }
         ObjectUtils.disposeObject(_name);
         _name = ComponentFactory.Instance.creatComponentByStylename("memberItem.commonName");
         _name.text = _loc2_.NickName;
         addChild(_name);
         if(_loc2_.IsVIP)
         {
            ObjectUtils.disposeObject(_nameForVip);
            _nameForVip = VipController.instance.getVipNameTxt(124,_loc2_.typeVIP);
            _loc1_ = new TextFormat();
            _loc1_.align = "center";
            _loc1_.bold = true;
            _nameForVip.textField.defaultTextFormat = _loc1_;
            _nameForVip.textSize = 16;
            _nameForVip.x = _name.x;
            _nameForVip.y = _name.y;
            _nameForVip.text = _loc2_.NickName;
            addChild(_nameForVip);
         }
         PositionUtils.adaptNameStyle(_loc2_,_name,_nameForVip);
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_playerInfo.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
            }
            if(_playerInfo.IsVIP)
            {
               _attestBtn.x = _nameForVip.x + _nameForVip.width;
               _attestBtn.y = _nameForVip.y;
            }
            else
            {
               _attestBtn.x = _name.x + _name.width;
               _attestBtn.y = _name.y - 4;
            }
            _attestBtn.visible = true;
         }
         else if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _itemBG = null;
         _light.dispose();
         _light = null;
         _name = null;
         _nameForVip = null;
         _job = null;
         _offer = null;
         _week = null;
         _fightPower = null;
         _offLine = null;
         _levelIcon = null;
         _attestBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
