package fightLib.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import ddt.view.buff.BuffControl;
   import ddt.view.buff.BuffControlManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Sprite;
   import flash.geom.Point;
   import vip.VipController;
   
   public class FightLibPlayerInfoView extends Sprite implements Disposeable
   {
       
      
      private var _info:PlayerInfo;
      
      private var _nicknameField:FilterFrameText;
      
      private var _vipNameField:GradientText;
      
      private var _consortiaNameField:FilterFrameText;
      
      private var _reputeField:FilterFrameText;
      
      private var _reputeTitleField:FilterFrameText;
      
      private var _gesteTitleField:FilterFrameText;
      
      private var _gesteField:FilterFrameText;
      
      private var _figure:ICharacter;
      
      private var _playerContent:Sprite;
      
      private var _levelIcon:LevelIcon;
      
      private var _guildOffset:Point;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _marryIcon:MarriedIcon;
      
      private var _academyIcon:AcademyIcon;
      
      private var _badge:Badge;
      
      private var _iconContainer:VBox;
      
      private var _marryOffset:Point;
      
      private var _buff:BuffControl;
      
      private var _backgournd:MutipleImage;
      
      public function FightLibPlayerInfoView()
      {
         super();
         configUI();
         addEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_nicknameField)
         {
            ObjectUtils.disposeObject(_nicknameField);
            _nicknameField = null;
         }
         if(_consortiaNameField)
         {
            ObjectUtils.disposeObject(_consortiaNameField);
            _consortiaNameField = null;
         }
         if(_reputeField)
         {
            ObjectUtils.disposeObject(_reputeField);
            _reputeField = null;
         }
         if(_gesteField)
         {
            ObjectUtils.disposeObject(_gesteField);
            _gesteField = null;
         }
         if(_figure)
         {
            ObjectUtils.disposeObject(_figure);
            _figure = null;
         }
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_marryIcon)
         {
            ObjectUtils.disposeObject(_marryIcon);
            _marryIcon = null;
         }
         if(_buff)
         {
            ObjectUtils.disposeObject(_buff);
            _buff = null;
         }
         if(_vipIcon)
         {
            ObjectUtils.disposeObject(_vipIcon);
            _vipIcon = null;
         }
         if(_academyIcon)
         {
            ObjectUtils.disposeObject(_academyIcon);
            _academyIcon = null;
         }
         if(_backgournd)
         {
            ObjectUtils.disposeObject(_backgournd);
            _backgournd = null;
         }
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         ObjectUtils.disposeObject(_iconContainer);
         _iconContainer = null;
      }
      
      public function set info(val:PlayerInfo) : void
      {
         if(_info != null)
         {
            if(_info.ID == val.ID)
            {
               return;
            }
            _info.removeEventListener("propertychange",__propertyChanged);
         }
         _info = val;
         _info.addEventListener("propertychange",__propertyChanged);
         update();
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      private function configUI() : void
      {
         _backgournd = ComponentFactory.Instance.creat("asset.fightlib.playerinfoViewbgImg");
         addChild(_backgournd);
         _playerContent = new Sprite();
         addChild(_playerContent);
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.fightLibPlayerItem.iconContainer");
         addChild(_iconContainer);
         _nicknameField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.NicknameField");
         _consortiaNameField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.ConsortiaNameField");
         addChild(_consortiaNameField);
         _reputeTitleField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.ReputeTitleField");
         _reputeTitleField.text = LanguageMgr.GetTranslation("repute");
         addChild(_reputeTitleField);
         _reputeField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.ReputeField");
         addChild(_reputeField);
         _gesteTitleField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.GesteTitleField");
         _gesteTitleField.text = LanguageMgr.GetTranslation("offer");
         addChild(_gesteTitleField);
         _gesteField = ComponentFactory.Instance.creatComponentByStylename("fightLib.PlayerInfo.GesteField");
         addChild(_gesteField);
         _buff = BuffControlManager.instance.buff;
         _buff.boxSpacing = 10;
         PositionUtils.setPos(_buff,"fightLib.PlyerInfo.BuffPos");
         addChild(_buff);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("fightLib.PlyerInfo.LevelIcon");
         _levelIcon.setSize(0);
         addChild(_levelIcon);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_info)
         {
            _info.removeEventListener("propertychange",__propertyChanged);
         }
      }
      
      private function __propertyChanged(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Effectiveness"] || evt.changedProperties["DutyLevel"] || evt.changedProperties["ConsortiaName"] || evt.changedProperties["SpouseName"] || evt.changedProperties["Grade"] || evt.changedProperties["Repute"])
         {
            update();
         }
      }
      
      private function update() : void
      {
         if(_vipIcon == null)
         {
            _vipIcon = ComponentFactory.Instance.creatCustomObject("fightLib.PlayerInfo.VipIcon");
            _iconContainer.addChild(_vipIcon);
         }
         _vipIcon.setInfo(_info);
         if(_info.shouldShowAcademyIcon())
         {
            if(_academyIcon == null)
            {
               _academyIcon = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibPlayerInfoView.AcademyIcon");
               _iconContainer.addChild(_academyIcon);
            }
         }
         else
         {
            if(_academyIcon)
            {
               _academyIcon.dispose();
            }
            _academyIcon = null;
         }
         if(_info.SpouseName != null && _info.SpouseName != "")
         {
            if(_marryIcon == null)
            {
               _marryIcon = ComponentFactory.Instance.creatCustomObject("fightLib.PlyerInfo.MarriedIcon");
               _marryIcon.tipData = {
                  "nickName":_info.SpouseName,
                  "gender":_info.Sex
               };
               _iconContainer.addChild(_marryIcon);
            }
         }
         else
         {
            if(_marryIcon)
            {
               _marryIcon.dispose();
            }
            _marryIcon = null;
         }
         if(_info.badgeID > 0 && _info.ConsortiaID > 0)
         {
            if(_badge == null)
            {
               _badge = new Badge();
               _badge.badgeID = _info.badgeID;
               _badge.showTip = true;
               _badge.tipData = _info.ConsortiaName;
               _iconContainer.addChild(_badge);
            }
         }
         else if(_badge)
         {
            _badge.dispose();
            _badge = null;
         }
         _consortiaNameField.text = _info.ConsortiaName == null?"":_info.ConsortiaID > 0?"<" + _info.ConsortiaName + ">":"";
         _reputeField.text = String(_info.Repute);
         _gesteField.text = String(_info.Offer);
         if(_figure == null)
         {
            _figure = CharactoryFactory.createCharacter(_info,"room");
            _figure.showGun = true;
            PositionUtils.setPos(_figure,"fightLib.PlayerInfo.FigurePosition");
            _figure.show(true,-1);
            _figure.setShowLight(true,null);
            _playerContent.addChild(_figure as RoomCharacter);
         }
         _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
         if(_academyIcon)
         {
            _academyIcon.tipData = _info;
         }
         if(!_info.IsVIP)
         {
            _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _nicknameField.text = _info.NickName;
            addChild(_nicknameField);
            DisplayUtils.removeDisplay(_vipNameField);
         }
         else
         {
            ObjectUtils.disposeObject(_vipNameField);
            _vipNameField = VipController.instance.getVipNameTxt(101,_info.typeVIP);
            _vipNameField.x = _nicknameField.x;
            _vipNameField.y = _nicknameField.y;
            _vipNameField.text = _info.NickName;
            addChild(_vipNameField);
            DisplayUtils.removeDisplay(_nicknameField);
         }
      }
   }
}
