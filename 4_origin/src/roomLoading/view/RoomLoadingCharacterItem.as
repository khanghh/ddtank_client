package roomLoading.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import ddt.view.common.DailyLeagueLevel;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import room.events.RoomPlayerEvent;
   import room.model.RoomPlayer;
   import vip.VipController;
   
   public class RoomLoadingCharacterItem extends Sprite implements Disposeable
   {
      
      public static const LOADING_FINISHED:String = "loadingFinished";
       
      
      private var _survivalFlag:Boolean;
      
      protected var _info:RoomPlayer;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      public var _perecentageTxt:FilterFrameText;
      
      protected var _okTxt:Bitmap;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _legaueLevel:DailyLeagueLevel;
      
      protected var _vipIcon:VipLevelIcon;
      
      protected var _marriedIcon:MarriedIcon;
      
      protected var _academyIcon:AcademyIcon;
      
      protected var _badge:Badge;
      
      protected var _iconContainer:VBox;
      
      protected var _iconPos:Point;
      
      protected var _loadingArr:Array;
      
      protected var _weapon:DisplayObject;
      
      protected var _displayMc:MovieClip;
      
      protected var _index:int = 1;
      
      protected var _animationFinish:Boolean = false;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _teamIcon:ScaleFrameImage;
      
      public function RoomLoadingCharacterItem(param1:RoomPlayer, param2:Boolean = false)
      {
         super();
         _info = param1;
         _survivalFlag = param2;
         init();
      }
      
      protected function init() : void
      {
         if(_info.team % 2 == 1)
         {
            _perecentageTxt = ComponentFactory.Instance.creatComponentByStylename("roomLoading.CharacterItemPercentageBlueTxt");
         }
         else
         {
            _perecentageTxt = ComponentFactory.Instance.creatComponentByStylename("roomLoading.CharacterItemPercentageRedTxt");
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("roomLoading.CharacterItemNameTxt");
         _nameTxt.text = _info.playerInfo.NickName;
         _perecentageTxt.text = "0%";
         _info.addEventListener("progressChange",__onProgress);
         _displayMc = ComponentFactory.Instance.creat("asset.roomloading.displayMC");
         _displayMc.addEventListener("appeared",__onAppeared);
         addChild(_displayMc);
         _displayMc.scaleX = _info.team % 2 == 1?1:-1;
         _displayMc["character"].addChild(_info.character);
         _info.character.stopAnimation();
         _info.character.setShowLight(false);
         addChild(_perecentageTxt);
         if(_info.playerInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(_nameTxt.width,_info.playerInfo.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
         }
         else
         {
            addChild(_nameTxt);
         }
         _iconContainer = ComponentFactory.Instance.creatComponentByStylename("asset.roomLoadingPlayerItem.iconContainer");
         _teamIcon = ComponentFactory.Instance.creatComponentByStylename("room.view.roomView.SingleRoomView.teamIcon");
         _teamIcon.setFrame(_info.playerInfo.teamDivision + 1);
         addChild(_teamIcon);
         creatTeamIcon();
         if(_survivalFlag)
         {
            addSurvivalIcon();
         }
         else
         {
            initIcons();
         }
         creatAttestBtn();
      }
      
      private function creatTeamIcon() : void
      {
         if(_info.playerInfo.teamID > 0)
         {
            _teamIcon.setFrame(_info.playerInfo.teamDivision + 2);
            _teamIcon.visible = true;
         }
         else
         {
            _teamIcon.visible = false;
         }
         _teamIcon.tipData = _info.playerInfo;
      }
      
      private function addSurvivalIcon() : void
      {
         _levelIcon = new LevelIcon();
         _levelIcon.setInfo(_info.playerInfo.Grade,_info.playerInfo.ddtKingGrade,_info.playerInfo.Repute,_info.playerInfo.WinCount,_info.playerInfo.TotalCount,_info.playerInfo.FightPower,_info.playerInfo.Offer,true,true,_info.team);
         addChild(_levelIcon);
         if(_info.team % 2 == 1)
         {
            PositionUtils.setPos(_levelIcon,"roomLoading.survival.leftLevelPos");
            PositionUtils.setPos(_perecentageTxt,"roomLoading.survival.leftPercentagePos");
            PositionUtils.setPos(!!_info.playerInfo.IsVIP?_vipName:_nameTxt,"roomLoading.survival.leftNamePos");
         }
         else
         {
            PositionUtils.setPos(_levelIcon,"roomLoading.survival.rightLevelPos");
            PositionUtils.setPos(_perecentageTxt,"roomLoading.survival.rightPercentagePos");
            PositionUtils.setPos(!!_info.playerInfo.IsVIP?_vipName:_nameTxt,"roomLoading.survival.rightNamePos");
         }
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.playerInfo.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            addChild(_attestBtn);
            if(_info.playerInfo.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _nameTxt.x + _nameTxt.width;
               _attestBtn.y = _nameTxt.y;
            }
         }
      }
      
      protected function __onAppeared(param1:Event) : void
      {
         _animationFinish = true;
      }
      
      public function get isAnimationFinished() : Boolean
      {
         return _animationFinish;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get displayMc() : DisplayObject
      {
         return _displayMc;
      }
      
      public function appear(param1:String) : void
      {
         _displayMc.gotoAndPlay("appear" + param1);
      }
      
      public function disappear(param1:String) : void
      {
         _displayMc.gotoAndPlay("disappear" + param1);
      }
      
      public function addWeapon(param1:Boolean, param2:int) : void
      {
         if(_info.playerInfo.WeaponID <= 0 || _info.playerInfo.WeaponID == 70016)
         {
            return;
         }
         if(_weapon)
         {
            ObjectUtils.disposeObject(_weapon);
         }
         var _loc4_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.playerInfo.WeaponID);
         var _loc5_:String = PathManager.solveGoodsPath(_loc4_.CategoryID,_loc4_.Pic,_info.playerInfo.Sex == 1,"show","A","1",_loc4_.Level);
         var _loc3_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.smallWeaponSize");
         var _loc6_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.bigWeaponSize");
         _weapon = new BitmapLoaderProxy(_loc5_,!!param1?_loc3_:_loc6_);
         _weapon.scaleX = param2;
         setWeaponPos(param1);
         _displayMc["character"].addChild(_weapon);
      }
      
      private function setWeaponPos(param1:Boolean) : void
      {
         var _loc2_:String = "";
         if(_survivalFlag)
         {
            _loc2_ = _info.team % 2 == 1?"survivalLeft":"survivalRight";
         }
         else
         {
            _loc2_ = _info.team == 1?"blueTeam":"redTeam";
         }
         if(!param1)
         {
            PositionUtils.setPos(_weapon,"asset.roomLoadingPlayerItem." + _loc2_ + ".bigWeaponPos");
            PositionUtils.setPos(_teamIcon,"room.view.roomView.SingleRoomView.teamIconPos1");
         }
         else
         {
            PositionUtils.setPos(_weapon,"asset.roomLoadingPlayerItem." + _loc2_ + ".smallWeaponPos");
            PositionUtils.setPos(_teamIcon,"room.view.roomView.SingleRoomView.teamIconPos2");
         }
      }
      
      protected function __onProgress(param1:RoomPlayerEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         _perecentageTxt.text = String(int(_info.progress)) + "%";
         if(_info.progress > 99)
         {
            _okTxt = ComponentFactory.Instance.creatBitmap("asset.roomLoading.LoadingOK");
            if(_survivalFlag)
            {
               _loc2_ = _info.team % 2 == 1?"roomLoading.survival.leftLoadingOkPos":"roomLoading.survival.rightLoadingOkPos";
               _loc3_ = ComponentFactory.Instance.creatCustomObject(_loc2_);
               PositionUtils.setPos(_okTxt,_loc3_);
            }
            else
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.LoadingOKStartPos");
            }
            TweenMax.from(_okTxt,0.5,{
               "alpha":0,
               "scaleX":2,
               "scaleY":2,
               "x":_loc3_.x,
               "y":_loc3_.y,
               "ease":Quint.easeIn,
               "onStart":finishTxt
            });
            addChild(_okTxt);
            _info.removeEventListener("progressChange",__onProgress);
            dispatchEvent(new Event("loadingFinished"));
         }
      }
      
      protected function finishTxt() : void
      {
         _perecentageTxt.text = "100%";
         removeTxt();
      }
      
      protected function removeTxt() : void
      {
         if(_perecentageTxt)
         {
            _perecentageTxt.parent.removeChild(_perecentageTxt);
         }
      }
      
      protected function initIcons() : void
      {
         _iconPos = ComponentFactory.Instance.creatCustomObject("roomLoading.CharacterItemIconStartPos");
         if(!_info.playerInfo.IsVIP)
         {
            _iconPos = ComponentFactory.Instance.creatCustomObject("roomLoading.CharacterItemIconStartPos2");
         }
         var _loc1_:int = 30;
         _levelIcon = new LevelIcon();
         _levelIcon.setInfo(_info.playerInfo.Grade,_info.playerInfo.ddtKingGrade,_info.playerInfo.Repute,_info.playerInfo.WinCount,_info.playerInfo.TotalCount,_info.playerInfo.FightPower,_info.playerInfo.Offer,true,true,_info.team);
         PositionUtils.setPos(_levelIcon,_iconPos);
         addChild(_levelIcon);
         _iconPos.y = _iconPos.y + _loc1_;
         _iconPos.x = _iconPos.x + 3;
         _vipIcon = new VipLevelIcon();
         if(_info.playerInfo.ID == PlayerManager.Instance.Self.ID || _info.playerInfo.IsVIP)
         {
            _vipIcon = new VipLevelIcon();
            _vipIcon.setInfo(_info.playerInfo);
            _vipIcon.filters = !_info.playerInfo.IsVIP?ComponentFactory.Instance.creatFilters("grayFilter"):null;
            _iconContainer.addChild(_vipIcon);
         }
         _marriedIcon = new MarriedIcon();
         if(_info.playerInfo.SpouseID > 0)
         {
            _marriedIcon = ComponentFactory.Instance.creatCustomObject("roomLoading.CharacterMarriedIcon");
            _marriedIcon.tipData = {
               "nickName":_info.playerInfo.SpouseName,
               "gender":_info.playerInfo.Sex
            };
            _iconContainer.addChild(_marriedIcon);
            _iconPos.y = _iconPos.y + _loc1_;
         }
         if(_info.playerInfo.shouldShowAcademyIcon())
         {
            _academyIcon = ComponentFactory.Instance.creatCustomObject("roomLoading.CharacterAcademyIcon");
            _academyIcon.tipData = _info.playerInfo;
            _iconContainer.addChild(_academyIcon);
         }
         if(_info.playerInfo.ConsortiaID > 0 && _info.playerInfo.badgeID > 0)
         {
            _badge = new Badge();
            _badge.badgeID = _info.playerInfo.badgeID;
            _badge.showTip = true;
            _badge.tipData = _info.playerInfo.ConsortiaName;
            _iconContainer.addChild(_badge);
         }
      }
      
      public function get info() : RoomPlayer
      {
         return _info;
      }
      
      public function dispose() : void
      {
         _info.removeEventListener("progressChange",__onProgress);
         if(_info.character && _info.character.parent)
         {
            _info.character.parent.removeChild(_info.character);
         }
         TweenMax.killTweensOf(_okTxt);
         ObjectUtils.disposeObject(_nameTxt);
         ObjectUtils.disposeObject(_vipName);
         ObjectUtils.disposeObject(_perecentageTxt);
         ObjectUtils.disposeObject(_okTxt);
         ObjectUtils.disposeObject(_levelIcon);
         if(_legaueLevel)
         {
            ObjectUtils.disposeObject(_legaueLevel);
            ShowTipManager.Instance.removeTip(_legaueLevel);
         }
         ObjectUtils.disposeObject(_vipIcon);
         ObjectUtils.disposeObject(_marriedIcon);
         ObjectUtils.disposeObject(_academyIcon);
         ObjectUtils.disposeObject(_badge);
         ObjectUtils.disposeObject(_iconContainer);
         ObjectUtils.disposeObject(_teamIcon);
         if(_displayMc)
         {
            _displayMc.removeEventListener("appeared",__onAppeared);
         }
         ObjectUtils.disposeObject(_displayMc);
         _displayMc = null;
         _info = null;
         _nameTxt = null;
         _vipName = null;
         _perecentageTxt = null;
         _okTxt = null;
         _levelIcon = null;
         _legaueLevel = null;
         _vipIcon = null;
         _marriedIcon = null;
         _academyIcon = null;
         _iconPos = null;
         _loadingArr = null;
         _badge = null;
         _iconContainer = null;
         _teamIcon = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function removePerecentageTxt() : void
      {
         if(_perecentageTxt)
         {
            ObjectUtils.disposeObject(_perecentageTxt);
         }
         _perecentageTxt = null;
      }
   }
}
