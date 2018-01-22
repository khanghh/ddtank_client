package civil.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import church.ChurchManager;
   import civil.CivilController;
   import civil.CivilEvent;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class CivilLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _headBg:Bitmap;
      
      private var _SmallBg1:Bitmap;
      
      private var _SmallBg2:Bitmap;
      
      private var _Introduction:Bitmap;
      
      private var _introBg:MovieClip;
      
      private var _buttonBg:MovieClip;
      
      private var _playerName:FilterFrameText;
      
      private var _guildName:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _married:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _sexBg:ScaleFrameImage;
      
      private var _vipName:GradientText;
      
      private var _introductionTxt:TextArea;
      
      private var _info:CivilPlayerInfo;
      
      private var _controller:CivilController;
      
      private var _levelIcon:LevelIcon;
      
      private var _model:CivilModel;
      
      private var _courtshipBtn:TextButton;
      
      private var _talkBtn:TextButton;
      
      private var _equipBtn:TextButton;
      
      private var _addBtn:TextButton;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _guildNameTxt:FilterFrameText;
      
      private var _reputeTxt:FilterFrameText;
      
      private var _marriedTxt:FilterFrameText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function CivilLeftView(param1:CivilController, param2:CivilModel){super();}
      
      public function dispose() : void{}
      
      private function init() : void{}
      
      private function initContent() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onButtonClick(param1:MouseEvent) : void{}
      
      private function __updateView(param1:CivilEvent) : void{}
      
      private function updatePlayerView() : void{}
      
      private function creatAttestBtn(param1:PlayerInfo) : void{}
      
      private function getCourtshipBtnEnable() : Boolean{return false;}
      
      private function refreshCharater() : void{}
   }
}
