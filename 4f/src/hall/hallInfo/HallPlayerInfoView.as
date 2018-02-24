package hall.hallInfo
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.buff.BuffControl;
   import ddt.view.buff.BuffControlManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.hallInfo.playerInfo.HallRefreshableServerDropList;
   import hall.hallInfo.playerInfo.PlayerFighterPower;
   import hall.hallInfo.playerInfo.PlayerHead;
   import hall.hallInfo.playerInfo.PlayerTool;
   import hall.hallInfo.playerInfo.PlayerVIP;
   import playerDress.event.PlayerDressEvent;
   
   public class HallPlayerInfoView extends Sprite
   {
       
      
      private var _sprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _head:PlayerHead;
      
      private var _fighterPower:PlayerFighterPower;
      
      private var _vip:PlayerVIP;
      
      private var _buff:BuffControl;
      
      private var _toolBtn:PlayerTool;
      
      private var _showHideBtn:ScaleFrameImage;
      
      private var _showAnimation:MovieClip;
      
      private var _serverlist:HallRefreshableServerDropList;
      
      public function HallPlayerInfoView(){super();}
      
      private function initView() : void{}
      
      private function showShowHideAnimation() : void{}
      
      public function __updatePlayerInfo(param1:PlayerDressEvent) : void{}
      
      private function initEvent() : void{}
      
      protected function __onShowHideClick(param1:MouseEvent) : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      protected function __showBuffControl(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get toolBtn() : PlayerTool{return null;}
   }
}
