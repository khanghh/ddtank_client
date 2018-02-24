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
      
      public function LeftPlayerCartoonView(){super();}
      
      public function set isClose(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      private function addPet() : void{}
      
      private function removePet() : void{}
      
      private function __frameFunctionHandler(param1:Event) : void{}
      
      public function set info(param1:Living) : void{}
      
      public function get info() : Living{return null;}
      
      protected function update() : void{}
      
      private function showHonorName() : void{}
      
      private function setBodyBitmap(param1:DisplayObject, param2:Boolean = false) : void{}
      
      private function easingIn() : void{}
      
      private function easingOut() : void{}
      
      private function frameEasingIn() : void{}
      
      private function frameEasingOut() : void{}
      
      public function updateTimerState(param1:Boolean, param2:Boolean) : void{}
      
      private function __isAttackingChanged(param1:LivingEvent) : void{}
      
      private function __stopCountDown(param1:LivingEvent) : void{}
      
      private function __skip(param1:Event = null) : void{}
      
      public function skip() : void{}
      
      public function gameOver() : void{}
      
      public function dispose() : void{}
   }
}
