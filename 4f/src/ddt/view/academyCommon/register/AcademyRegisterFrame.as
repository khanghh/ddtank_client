package ddt.view.academyCommon.register
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import road7th.utils.StringHelper;
   
   public class AcademyRegisterFrame extends BaseAlerFrame implements Disposeable
   {
       
      
      private var _titleImage:ScaleFrameImage;
      
      private var _nicknameLabel:FilterFrameText;
      
      private var _nicknameField:FilterFrameText;
      
      private var _academyHonorLabel:FilterFrameText;
      
      private var _academyHonorField:FilterFrameText;
      
      private var _introductionLabel:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _checkBoxLabel:FilterFrameText;
      
      private var _introductionField:TextArea;
      
      private var _alertInfo:AlertInfo;
      
      private var _selfInfo:SelfInfo;
      
      public function AcademyRegisterFrame(){super();}
      
      private function initContainer() : void{}
      
      public function show() : void{}
      
      public function isAmend(param1:Boolean) : void{}
      
      public function update() : void{}
      
      private function iniEvent() : void{}
      
      private function __limit(param1:TextEvent) : void{}
      
      private function __checkBoxLabelClick(param1:MouseEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
