package tofflist.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import team.model.TeamRankInfo;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import vip.VipController;
   
   public class TofflistLeftCurrentCharcter extends Sprite implements Disposeable
   {
       
      
      private var _AchievementImg:Bitmap;
      
      private var _EXPImg:Bitmap;
      
      private var _LnTAImg:Bitmap;
      
      private var _NO1Mc:MovieClip;
      
      private var _chairmanNameTxt:FilterFrameText;
      
      private var _chairmanNameTxt2:FilterFrameText;
      
      private var _consortiaName:FilterFrameText;
      
      private var _exploitImg:Bitmap;
      
      private var _fightingImg:Bitmap;
      
      private var _mountsImg:Bitmap;
      
      private var _guildImg:Bitmap;
      
      private var _teamImg:Bitmap;
      
      private var _teamScoreImg:Bitmap;
      
      private var _info:PlayerInfo;
      
      private var _teamInfo:TeamRankInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _lookEquip_btn:TextButton;
      
      private var _applyJoinBtn:TextButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _rankNumber:Sprite;
      
      private var _text1:FilterFrameText;
      
      private var _textBg:Scale9CornerImage;
      
      private var _wealthImg:Bitmap;
      
      private var _vipName:GradientText;
      
      private var _chairmanVipName:GradientText;
      
      private var _scoreImg:Bitmap;
      
      private var _charmvalueImg:Bitmap;
      
      private var _levelStar:Bitmap;
      
      private var _mountsLevel:FilterFrameText;
      
      public function TofflistLeftCurrentCharcter(){super();}
      
      public function dispose() : void{}
      
      private function NO1Effect() : void{}
      
      private function __lookBtnClick(param1:Event) : void{}
      
      private function __upCurrentPlayerHandler(param1:TofflistEvent) : void{}
      
      private function addEvent() : void{}
      
      private function onApplyJoinClubBtnClick(param1:MouseEvent) : void{}
      
      private function getRank(param1:int) : void{}
      
      private function getRankBitmap(param1:int) : Bitmap{return null;}
      
      private function init() : void{}
      
      private function refreshCharater() : void{}
      
      private function removeEvent() : void{}
      
      private function upLevelIcon() : void{}
      
      private function upStyle() : void{}
      
      private function upView() : void{}
      
      private function refreshApplyJoinClubBtn() : void{}
      
      private function hasApplyJoinClub(param1:int = 0) : Boolean{return false;}
      
      private function getPlayerInfo(param1:TeamRankInfo) : PlayerInfo{return null;}
   }
}
