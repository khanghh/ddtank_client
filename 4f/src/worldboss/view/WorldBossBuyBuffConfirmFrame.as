package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuyBuffConfirmFrame extends BaseAlerFrame
   {
       
      
      protected var _bgTitle:DisplayObject;
      
      protected var _alertTips:FilterFrameText;
      
      protected var _alertTips2:FilterFrameText;
      
      protected var _buyBtn:SelectedCheckButton;
      
      private var _type:int;
      
      private var _promptSCBGroup:SelectedButtonGroup;
      
      private var _promptSCB:SelectedCheckButton;
      
      private var _promptSCB2:SelectedCheckButton;
      
      public function WorldBossBuyBuffConfirmFrame(){super();}
      
      protected function initView() : void{}
      
      public function show(param1:int = 1) : void{}
      
      protected function initEvent() : void{}
      
      protected function __noAlertTip(param1:Event) : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      protected function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
