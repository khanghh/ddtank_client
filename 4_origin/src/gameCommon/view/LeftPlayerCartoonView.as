package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.events.LivingEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.TurnedLiving;
   import room.RoomManager;
   import room.view.RoomPlayerItemPet;
   import vip.VipController;
   
   public class LeftPlayerCartoonView extends Sprite implements Disposeable
   {
      
      public static const SHOW_BITMAP_WIDTH:int = 120;
      
      public static const SHOW_BITMAP_HEIGHT:int = 200;
       
      
      private var _movie:MovieClip;
      
      private var _nickName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _zoneName:FilterFrameText;
      
      private var _honorName:FilterFrameText;
      
      private var _team:ScaleFrameImage;
      
      private var _info:Living;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _badge:Badge;
      
      private var _roomPlayerItemPet:RoomPlayerItemPet;
      
      private var _petHeadFrameBg:Bitmap;
      
      private var _recordInfo:Player;
      
      private var _body:DisplayObject;
      
      private var _isClose:Boolean = false;
      
      private var _showLightPoint:Point;
      
      public function LeftPlayerCartoonView()
      {
         _showLightPoint = new Point(0,2);
         super();
         initView();
      }
      
      public function set isClose(b:Boolean) : void
      {
         _isClose = b;
      }
      
      private function initView() : void
      {
         _movie = ClassUtils.CreatInstance("asset.game.LeftPlayerCiteAsset");
         _movie.x = -6;
         addChild(_movie);
         _team = ComponentFactory.Instance.creatComponentByStylename("asset.game.leftPlayerViewTitle");
         _movie["leftCite"].addChild(_team);
         _nickName = ComponentFactory.Instance.creatComponentByStylename("asset.game.leftPlayerViewNKNTxt");
         _movie["leftCite"].addChild(_nickName);
         _zoneName = ComponentFactory.Instance.creatComponentByStylename("asset.game.leftPlayerViewZNTxt");
         _movie["leftCite"].addChild(_zoneName);
         _honorName = ComponentFactory.Instance.creatComponentByStylename("asset.game.leftPlayerViewHNNTxt");
         _movie["leftCite"].addChild(_honorName);
         _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.game.VipIcon");
         _movie["leftCite"].addChild(_vipIcon);
         _badge = new Badge();
         _movie.gotoAndStop(1);
         var time:int = RoomManager.getTurnTimeByType(RoomManager.Instance.current.timeType);
         update();
         addEventListener("enterFrame",__frameFunctionHandler);
      }
      
      private function addPet() : void
      {
         trace(RoomManager.Instance.current.type);
         if(RoomManager.Instance.current.type != 5 && RoomManager.Instance.current.type != 21 && _info && _info.playerInfo && _info.playerInfo.currentPet && _info.playerInfo.currentPet.IsEquip)
         {
            if(!_roomPlayerItemPet)
            {
               _petHeadFrameBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.playerItem.petHeadFrame2");
               PositionUtils.setPos(_petHeadFrameBg,"assets.leftPlayerCartoonView.roomPlayerItemPetHeadFramePos");
               addChild(_petHeadFrameBg);
               _roomPlayerItemPet = new RoomPlayerItemPet(_petHeadFrameBg.width,_petHeadFrameBg.height);
               PositionUtils.setPos(_roomPlayerItemPet,"assets.leftPlayerCartoonView.roomPlayerItemPetPos");
               addChild(_roomPlayerItemPet);
            }
            _roomPlayerItemPet.updateView(_info.playerInfo.currentPet);
         }
         else
         {
            removePet();
         }
      }
      
      private function removePet() : void
      {
         if(_petHeadFrameBg)
         {
            ObjectUtils.disposeObject(_petHeadFrameBg);
         }
         _petHeadFrameBg = null;
         if(_roomPlayerItemPet)
         {
            ObjectUtils.disposeObject(_roomPlayerItemPet);
         }
         _roomPlayerItemPet = null;
      }
      
      private function __frameFunctionHandler(event:Event) : void
      {
         if(_movie.currentFrame == 7)
         {
            frameEasingIn();
         }
         if(_movie.currentFrame == _movie.totalFrames - 1)
         {
            frameEasingOut();
         }
      }
      
      public function set info(living:Living) : void
      {
         updateTimerState(false,false);
         var needEasingOut:* = _info != null;
         if(_info != living)
         {
            if(_info)
            {
               if(_info.isSelf)
               {
                  _info.removeEventListener("beginShoot",__stopCountDown);
                  _info.removeEventListener("attackingChanged",__isAttackingChanged);
               }
            }
            _info = living;
            if(_info)
            {
               if(_info.isSelf && !_isClose)
               {
                  _info.addEventListener("beginShoot",__stopCountDown);
                  _info.addEventListener("attackingChanged",__isAttackingChanged);
               }
               else if(_isClose)
               {
                  _info.addEventListener("beginShoot",__stopCountDown);
                  _info.addEventListener("attackingChanged",__isAttackingChanged);
               }
            }
         }
         if(needEasingOut)
         {
            easingOut();
         }
         else
         {
            easingIn();
         }
      }
      
      public function get info() : Living
      {
         return _info;
      }
      
      protected function update() : void
      {
         if(_info)
         {
            _honorName.text = "";
            if(_info.isSelf)
            {
               (_info as LocalPlayer).shootTime = 0;
            }
            if(_info.isPlayer())
            {
               if(_info.playerInfo)
               {
                  if(RoomManager.Instance.current.isCrossZone && _info.team != GameControl.Instance.Current.selfGamePlayer.team)
                  {
                     _nickName.text = "";
                     _nickName.text = _info.playerInfo.NickName;
                     _zoneName.text = "<" + (_info as Player).zoneName + ">";
                  }
                  else
                  {
                     _nickName.text = _info.playerInfo.NickName;
                     _zoneName.text = "";
                  }
                  if(_info.playerInfo.showDesignation)
                  {
                     _honorName.text = _info.playerInfo.showDesignation;
                     _nickName.x = _honorName.x + _honorName.width;
                  }
                  else
                  {
                     _nickName.x = _honorName.x;
                  }
                  if(_info.playerInfo.IsVIP)
                  {
                     ObjectUtils.disposeObject(_vipName);
                     _vipName = VipController.instance.getVipNameTxt(133,_info.playerInfo.typeVIP);
                     _vipName.x = _nickName.x;
                     _vipName.y = _nickName.y;
                     _vipName.text = _nickName.text;
                     _vipIcon.setInfo(_info.playerInfo,false);
                     _movie["leftCite"].addChild(_vipName);
                     _movie["leftCite"].addChild(_vipIcon);
                     DisplayUtils.removeDisplay(_nickName);
                     PositionUtils.setPos(_badge,"leftPlayerCartoon.BadgePos");
                  }
                  else
                  {
                     _movie["leftCite"].addChild(_nickName);
                     DisplayUtils.removeDisplay(_vipName,_vipIcon);
                     PositionUtils.setPos(_badge,_vipIcon);
                  }
                  addPet();
                  if(_roomPlayerItemPet)
                  {
                     _roomPlayerItemPet.visible = true;
                  }
                  if(_petHeadFrameBg)
                  {
                     _petHeadFrameBg.visible = true;
                  }
               }
               if(_info.playerInfo.badgeID > 0)
               {
                  _badge.badgeID = _info.playerInfo.badgeID;
                  _movie["leftCite"].addChild(_badge);
               }
               else if(_badge.parent)
               {
                  _badge.parent.removeChild(_badge);
               }
               if(_info.character)
               {
                  _info.character.showGun = false;
                  _info.character.showWing = false;
                  _info.character.setShowLight(true,_showLightPoint);
                  setBodyBitmap(_info.character.getShowBitmapBig(),true);
               }
            }
            else
            {
               _nickName.x = _honorName.x;
               _nickName.y = _honorName.y;
               _nickName.text = _info.name;
               _movie["leftCite"].addChild(_nickName);
               setBodyBitmap(_info.actionMovieBitmap);
               DisplayUtils.removeDisplay(_vipIcon,_vipName,_badge);
               if(_roomPlayerItemPet)
               {
                  _roomPlayerItemPet.visible = false;
               }
               if(_petHeadFrameBg)
               {
                  _petHeadFrameBg.visible = false;
               }
            }
            _team.setFrame(_info.team);
         }
         else
         {
            setBodyBitmap(null);
            _nickName.text = "";
            DisplayUtils.removeDisplay(_vipIcon,_vipName,_badge);
         }
      }
      
      private function showHonorName() : void
      {
         if(_info.playerInfo.honor == "" || !_info.playerInfo.honor)
         {
            _honorName.text = "";
            var _loc1_:* = _honorName.x;
            _vipName.x = _loc1_;
            _nickName.x = _loc1_;
            _loc1_ = _honorName.y;
            _vipName.y = _loc1_;
            _nickName.y = _loc1_;
         }
         else
         {
            _honorName.text = _info.playerInfo.honor;
            _loc1_ = _honorName.x + _honorName.width;
            _vipName.x = _loc1_;
            _nickName.x = _loc1_;
         }
      }
      
      private function setBodyBitmap(value:DisplayObject, isPlayer:Boolean = false) : void
      {
         if(_body != value)
         {
            if(_body && _body.parent)
            {
               _movie["leftCite"].removeChild(_body);
            }
            _body = value;
            if(_body)
            {
               if(isPlayer)
               {
                  _body.scaleX = -1;
                  if(_info.playerInfo.getShowSuits() && _info.playerInfo.getSuitsType() == 1)
                  {
                     _body.y = -18;
                  }
                  else
                  {
                     _body.y = -3;
                  }
                  _body.x = _body.width * 0.5 + 65;
               }
               else if(_body.height > 120)
               {
                  _body.x = 10;
                  _body.y = 35 - _body.height + 112;
               }
               else
               {
                  _body.x = 80 - _body.width * 0.5;
                  _body.y = 85 - _body.height * 0.5;
               }
               _movie["leftCite"].addChildAt(_body,1);
            }
         }
      }
      
      private function easingIn() : void
      {
         update();
         _movie.gotoAndPlay(1);
      }
      
      private function easingOut() : void
      {
         _movie.gotoAndPlay(8);
      }
      
      private function frameEasingIn() : void
      {
         _movie.stop();
      }
      
      private function frameEasingOut() : void
      {
         if(_info)
         {
            easingIn();
         }
         else
         {
            _movie.stop();
         }
      }
      
      public function updateTimerState(visible:Boolean, enabled:Boolean) : void
      {
         if(visible)
         {
            if(_info && _info.isSelf)
            {
            }
            if(enabled)
            {
            }
         }
      }
      
      private function __isAttackingChanged(event:LivingEvent) : void
      {
         if((_info as TurnedLiving).isAttacking)
         {
            updateTimerState(true,true);
            if(!_info.isSelf)
            {
            }
         }
         else
         {
            updateTimerState(true,false);
         }
      }
      
      private function __stopCountDown(event:LivingEvent) : void
      {
      }
      
      private function __skip(event:Event = null) : void
      {
         if(_info && _info.isSelf)
         {
            SoundManager.instance.play("008");
            skip();
         }
      }
      
      public function skip() : void
      {
         updateTimerState(true,false);
         (_info as LocalPlayer).skip();
      }
      
      public function gameOver() : void
      {
         info = null;
      }
      
      public function dispose() : void
      {
         if(_info)
         {
            _info.removeEventListener("beginShoot",__stopCountDown);
            _info.removeEventListener("attackingChanged",__isAttackingChanged);
         }
         _info = null;
         if(_badge)
         {
            _badge.dispose();
         }
         _badge = null;
         if(_vipIcon)
         {
            _vipIcon.dispose();
         }
         _vipIcon = null;
         _movie["leftCite"].gotoAndStop(1);
         removeChild(_movie);
         _movie = null;
         _showLightPoint = null;
         _team.dispose();
         _team = null;
         _nickName.dispose();
         _nickName = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         _zoneName.dispose();
         _zoneName = null;
         _honorName.dispose();
         _honorName = null;
         removeEventListener("enterFrame",__frameFunctionHandler);
         removePet();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
