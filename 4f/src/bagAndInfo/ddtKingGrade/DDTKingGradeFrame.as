package bagAndInfo.ddtKingGrade
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.utils.MovieClipWrapper;
   
   public class DDTKingGradeFrame extends Frame
   {
       
      
      private var _viewBg:Bitmap;
      
      private var _viewTitle:Bitmap;
      
      private var _propertyVBox:VBox;
      
      private var _propertyTextList:Vector.<FilterFrameText>;
      
      private var _usableNumText:FilterFrameText;
      
      private var _usableNum:int = 0;
      
      private var _currentExp:Number;
      
      private var _nextExp:Number;
      
      private var _tipsText:FilterFrameText;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _allBtn:SimpleBitmapButton;
      
      private var _breakBtn:MovieClip;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rotateBg:MovieClipWrapper;
      
      private var _progress:MovieClip;
      
      private var _progressText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _progressTips:Component;
      
      private var _btnHelp:BaseButton;
      
      private var _currentButton:DDTKingGradeSelectedButton;
      
      private var _currentTime:int;
      
      public function DDTKingGradeFrame(){super();}
      
      private function initView() : void{}
      
      private function __onBreak(param1:PkgEvent) : void{}
      
      private function __onUpdateInfo(param1:PkgEvent) : void{}
      
      private function updateView() : void{}
      
      public function playAction() : void{}
      
      private function __onPlayActionComplete(param1:Event) : void{}
      
      private function __onClickReset(param1:MouseEvent) : void{}
      
      private function __onReset(param1:FrameEvent) : void{}
      
      private function __onClickAllReset(param1:MouseEvent) : void{}
      
      private function __onAllReset(param1:FrameEvent) : void{}
      
      private function __onClickBreak(param1:MouseEvent) : void{}
      
      private function __onButtonChange(param1:Event) : void{}
      
      public function show() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
