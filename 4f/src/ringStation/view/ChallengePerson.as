package ringStation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hall.hallInfo.playerInfo.PlayerFighterPower;
   import ringStation.RingStationControl;
   import vip.VipController;
   
   public class ChallengePerson extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _waiting:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _rank:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _challengeBtn:MovieImage;
      
      private var _playerInfo:PlayerInfo;
      
      private var _clickDate:Number = 0;
      
      private var _signBG:Bitmap;
      
      private var _signBG2:Bitmap;
      
      private var _signText:FilterFrameText;
      
      private var _maskSprite:Sprite;
      
      private var _playerSprite:Sprite;
      
      private var _fightingBg:Bitmap;
      
      private var _fightPower:PlayerFighterPower;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function ChallengePerson(){super();}
      
      private function initView() : void{}
      
      private function creatAttestBtn() : void{}
      
      private function addSignCell() : void{}
      
      private function initEvent() : void{}
      
      public function setWaiting() : void{}
      
      public function updatePerson(param1:PlayerInfo) : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      protected function __onMouseOver(param1:MouseEvent) : void{}
      
      protected function __onMouseOut(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
