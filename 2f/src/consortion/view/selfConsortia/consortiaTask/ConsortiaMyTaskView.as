package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaMyTaskView extends Sprite implements Disposeable
   {
       
      
      private var _taskInfo:ConsortiaTaskInfo;
      
      private var _vbox:VBox;
      
      private var _finishItemList:Vector.<ConsortiaMyTaskFinishItem>;
      
      private var _myFinishTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _offerTxt:FilterFrameText;
      
      private var _richesTxt:FilterFrameText;
      
      private var _skillNameTxt:FilterFrameText;
      
      private var _contentTxt1:FilterFrameText;
      
      private var _contentTxt2:FilterFrameText;
      
      private var _contentTxt3:FilterFrameText;
      
      private var _expText:FilterFrameText;
      
      private var _moneyText:FilterFrameText;
      
      private var _caiText:FilterFrameText;
      
      private var _skillText:FilterFrameText;
      
      private var _contributionLbl:FilterFrameText;
      
      private var _contributionTxt:FilterFrameText;
      
      private var _badgeLbl:FilterFrameText;
      
      private var _badgeText:FilterFrameText;
      
      private var _myReseBtn:TextButton;
      
      private var _contributionRankBtn:TextButton;
      
      private var _delayTimeBtn:TextButton;
      
      private var _reSetTaskMoney:int;
      
      public function ConsortiaMyTaskView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __taskRankClick(param1:MouseEvent) : void{}
      
      private function __delayTimeClick(param1:MouseEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
      
      private function getLockIdArr() : Array{return null;}
      
      private function __resetClick(param1:MouseEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __propChange(param1:PlayerPropertyEvent) : void{}
      
      private function update() : void{}
      
      public function set taskInfo(param1:ConsortiaTaskInfo) : void{}
      
      public function dispose() : void{}
   }
}
