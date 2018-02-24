package gameCommon.view.playerThumbnail
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.BitmapManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.LevelTipInfo;
   import ddt.view.tips.MarriedTip;
   import ddt.view.tips.PetTip;
   import ddt.view.tips.TeamTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import room.RoomManager;
   import trainer.view.NewHandContainer;
   
   [Event(name="playerThumbnailEvent",type="flash.events.Event")]
   public class PlayerThumbnail extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _info:Player;
      
      private var _headFigure:HeadFigure;
      
      private var _blood:BloodItem;
      
      private var _bg:Bitmap;
      
      private var _fore:Bitmap;
      
      private var _shiner:IEffect;
      
      private var _selectShiner:IEffect;
      
      private var _digitalbg:Bitmap;
      
      private var _smallPlayerFP:FilterFrameText;
      
      private var lightingFilter:BitmapFilter;
      
      private var _marryTip:MarriedTip;
      
      private var _dirct:int;
      
      private var _vip:DisplayObject;
      
      private var _bitmapMgr:BitmapManager;
      
      private var _routeBtn:BaseButton;
      
      private var _effectTarget:Shape;
      
      private var _petTip:PetTip;
      
      private var _hpPercentTxt:FilterFrameText;
      
      private var _trusteeshipIcon:ScaleBitmapImage;
      
      private var _waitingIcon:Bitmap;
      
      private var _actionIcon:Bitmap;
      
      private var _flagBattleBg:Bitmap;
      
      private var _escapeBattleBg:Bitmap;
      
      private var _waitRevive:Bitmap;
      
      private var _flagCount:NumberImage;
      
      private var _teamTip:TeamTip;
      
      private var _levelTipInfo:LevelTipInfo;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      public function PlayerThumbnail(param1:Player, param2:int){super();}
      
      private function init() : void{}
      
      public function getInfo() : Player{return null;}
      
      public function get info() : PlayerInfo{return null;}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      private function createLevelTip() : void{}
      
      protected function overHandler(param1:MouseEvent) : void{}
      
      protected function outHandler(param1:MouseEvent) : void{}
      
      protected function clickHandler(param1:MouseEvent) : void{}
      
      private function removeTipTemp() : void{}
      
      public function recoverTip() : void{}
      
      private function initEvents() : void{}
      
      private function isShowTrusteeship() : Boolean{return false;}
      
      private function __playerChange(param1:CrazyTankSocketEvent) : void{}
      
      private function __routeLine(param1:MouseEvent) : void{}
      
      private function setUpLintingFilter() : void{}
      
      private function __setSmallFP(param1:LivingEvent) : void{}
      
      private function __setShiner(param1:LivingEvent) : void{}
      
      private function __shineChange(param1:LivingEvent) : void{}
      
      private function __trusteeshipChange(param1:GameEvent) : void{}
      
      private function __fightStatusChange(param1:GameEvent) : void{}
      
      private function __onUpdateFlagNum(param1:LivingEvent) : void{}
      
      private function updateFlagNum() : void{}
      
      private function __onUpdateState(param1:LivingEvent) : void{}
      
      private function createArrow() : void{}
      
      private function clearArrow() : void{}
      
      override public function set x(param1:Number) : void{}
      
      override public function set y(param1:Number) : void{}
      
      private function __die(param1:LivingEvent) : void{}
      
      private function __revive(param1:LivingEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __updateBlood(param1:LivingEvent) : void{}
      
      public function dispose() : void{}
      
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
   }
}
