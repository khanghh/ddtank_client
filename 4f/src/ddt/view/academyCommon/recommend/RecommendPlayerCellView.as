package ddt.view.academyCommon.recommend
{
   import academy.AcademyManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class RecommendPlayerCellView extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      protected var _cellBg:Bitmap;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      protected var _guildTxt:FilterFrameText;
      
      protected var _masterHonor:ScaleFrameImage;
      
      protected var _masterHonorText:GradientText;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _vipIcon:VipLevelIcon;
      
      protected var _marriedIcon:MarriedIcon;
      
      protected var _badge:Badge;
      
      protected var _player:RoomCharacter;
      
      protected var _characteContainer:Sprite;
      
      protected var _iconContainer:VBox;
      
      protected var _recommendBtn:TextButton;
      
      protected var _info:AcademyPlayerInfo;
      
      protected var _isSelect:Boolean;
      
      protected var _tipStyle:String;
      
      protected var _tipDirctions:String;
      
      protected var _tipData:Object;
      
      protected var _tipGapH:int;
      
      protected var _tipGapV:int;
      
      protected var _chat:BaseButton;
      
      public function RecommendPlayerCellView(){super();}
      
      private function init() : void{}
      
      protected function initRecommendBtn() : void{}
      
      protected function initEvent() : void{}
      
      protected function __chatHandler(param1:MouseEvent) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function __onOut(param1:MouseEvent) : void{}
      
      private function __onOver(param1:MouseEvent) : void{}
      
      public function set isSelect(param1:Boolean) : void{}
      
      public function get isSelect() : Boolean{return false;}
      
      private function createCharacter() : void{}
      
      protected function __recommendBtn(param1:MouseEvent) : void{}
      
      private function __characterComplete(param1:Event) : void{}
      
      private function update() : void{}
      
      protected function checkVip(param1:PlayerInfo) : void{}
      
      protected function updateIcon() : void{}
      
      public function set info(param1:AcademyPlayerInfo) : void{}
      
      public function get info() : AcademyPlayerInfo{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
