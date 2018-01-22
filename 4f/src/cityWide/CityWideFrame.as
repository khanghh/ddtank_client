package cityWide
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class CityWideFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _vipName:GradientText;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipNamePoint:Point;
      
      private var _playerView:RoomCharacter;
      
      private var _cityWideText1:FilterFrameText;
      
      private var _cityWideText2:FilterFrameText;
      
      private var _cityWideText3:FilterFrameText;
      
      private var _addFriend:BaseButton;
      
      private var _addFriendBg2:ScaleBitmapImage;
      
      private var _addFriendSpeed:int;
      
      private var _playerViewPoint:Point;
      
      private var _cityWideBg:MovieClip;
      
      private var _playerInfo:PlayerInfo;
      
      public function CityWideFrame(){super();}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      private function setView() : void{}
      
      public function show() : void{}
      
      public function setList(param1:Array) : void{}
      
      private function _thisInFrame(param1:Event) : void{}
      
      private function _clickaddFriend(param1:MouseEvent) : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
