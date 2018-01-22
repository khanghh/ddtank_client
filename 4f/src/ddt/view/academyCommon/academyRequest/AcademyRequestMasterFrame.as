package ddt.view.academyCommon.academyRequest
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.MouseEvent;
   
   public class AcademyRequestMasterFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const MAX_CHAES:int = 30;
       
      
      protected var _inputText:FilterFrameText;
      
      protected var _explainText:FilterFrameText;
      
      protected var _inputBG:ScaleBitmapImage;
      
      protected var _inputBG2:ScaleBitmapImage;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _playerInfo:BasePlayer;
      
      protected var _isSelection:Boolean = false;
      
      public function AcademyRequestMasterFrame(){super();}
      
      public function show() : void{}
      
      protected function initContent() : void{}
      
      protected function initEvent() : void{}
      
      protected function __onInpotClick(param1:MouseEvent) : void{}
      
      public function setInfo(param1:BasePlayer) : void{}
      
      protected function __onResponse(param1:FrameEvent) : void{}
      
      protected function submit() : void{}
      
      protected function hide() : void{}
      
      override public function dispose() : void{}
   }
}
