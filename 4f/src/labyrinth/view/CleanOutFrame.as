package labyrinth.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerState;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import kingBless.KingBlessManager;
   import labyrinth.LabyrinthManager;
   import labyrinth.data.CleanOutInfo;
   import road7th.data.DictionaryEvent;
   
   public class CleanOutFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _rightBG:Bitmap;
      
      private var _leftBG:Bitmap;
      
      private var _startCleanOutBtn:SimpleBitmapButton;
      
      private var _speededUpBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _rightLabel:GradientText;
      
      private var _rightLabelI:GradientText;
      
      private var _rightLabelII:GradientText;
      
      private var _rightValue:FilterFrameText;
      
      private var _rightValueI:FilterFrameText;
      
      private var _rightValueII:FilterFrameText;
      
      private var _tipContainer:Sprite;
      
      private var _tipTitle:FilterFrameText;
      
      private var _tipContent:FilterFrameText;
      
      private var _list:ListPanel;
      
      private var _textFormat:TextFormat;
      
      private var _timer:Timer;
      
      private var _remainTime:int;
      
      private var _currentRemainTime:int;
      
      private var _chatBtn:SimpleBitmapButton;
      
      private var _vipIcon:Bitmap;
      
      private var _freeAccTips:FilterFrameText;
      
      private var _currentFloor:int = 0;
      
      private var _btnState:int;
      
      public function CleanOutFrame(){super();}
      
      override protected function init() : void{}
      
      private function initEvent() : void{}
      
      protected function __chatClick(param1:MouseEvent) : void{}
      
      protected function __updateInfo(param1:Event) : void{}
      
      protected function __updateRemainTime(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function updateRightValueI() : void{}
      
      protected function __updateTimer(param1:TimerEvent) : void{}
      
      protected function __addInfo(param1:DictionaryEvent) : void{}
      
      protected function __cancel(param1:MouseEvent) : void{}
      
      protected function __speededUp(param1:MouseEvent) : void{}
      
      protected function __onFrameEvent(param1:FrameEvent) : void{}
      
      private function onCheckComplete() : void{}
      
      private function reset() : void{}
      
      protected function __startCleanOut(param1:MouseEvent) : void{}
      
      private function set btnState(param1:int) : void{}
      
      private function updateTextVlaue() : void{}
      
      private function updateButton() : void{}
      
      public function continueCleanOut() : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
