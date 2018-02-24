package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class QualificationsFrame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _awardsBtn:BaseButton;
      
      private var _ruleTxt:FilterFrameText;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _points:FilterFrameText;
      
      private var _titleName:Array;
      
      private var _titleNameTxt:FilterFrameText;
      
      private var index:int;
      
      private var _numberImg:Bitmap;
      
      private var _numberTxt:FilterFrameText;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _consortionList:KingDivisionConsortionList;
      
      private var _consorPanel:ScrollPanel;
      
      private var _blind:Bitmap;
      
      private var _match:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timerUpdate:Timer;
      
      private var _proBar:ProgressBarView;
      
      private var _info:Vector.<KingDivisionConsortionItemInfo>;
      
      private var isConsortiaID:Boolean;
      
      private var isTrue:Boolean;
      
      public function QualificationsFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function playerIsConsortion() : void{}
      
      public function updateMessage(param1:int, param2:int) : void{}
      
      public function updateConsortiaMessage() : void{}
      
      private function __timer(param1:TimerEvent) : void{}
      
      public function updateButtons() : void{}
      
      private function isShowStartBtn() : void{}
      
      private function __onStartBtnClick(param1:MouseEvent) : void{}
      
      private function startGame() : void{}
      
      private function __onCancelBtnClick(param1:MouseEvent) : void{}
      
      private function __onClickAwardsBtn(param1:MouseEvent) : void{}
      
      private function addTitleName(param1:Array, param2:int) : void{}
      
      private function __updateConsortionMessage(param1:TimerEvent) : void{}
      
      public function set progressBarView(param1:ProgressBarView) : void{}
      
      public function setDateStages(param1:Array) : void{}
      
      public function cancelMatch() : void{}
      
      private function checkGameStartTimer() : void{}
      
      public function dispose() : void{}
   }
}
