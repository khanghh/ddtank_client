package ddt.view.academyCommon.academyRequest
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   
   public class AcademyAnswerMasterFrame extends AcademyRequestMasterFrame implements Disposeable
   {
      
      public static const BINGIN_INDEX:int = 3;
       
      
      protected var _messageText:FilterFrameText;
      
      protected var _uid:int;
      
      protected var _name:String;
      
      protected var _message:String;
      
      protected var _nameLabel:TextFormat;
      
      protected var _lookBtn:TextButton;
      
      protected var _cancelBtn:TextButton;
      
      protected var _unAcceptBtn:SelectedCheckButton;
      
      public function AcademyAnswerMasterFrame(){super();}
      
      override public function show() : void{}
      
      override protected function initContent() : void{}
      
      override protected function initEvent() : void{}
      
      protected function notAcceptAnswer(param1:Event) : void{}
      
      protected function __onCancelBtnClick(param1:MouseEvent) : void{}
      
      protected function __onLookBtnClick(param1:MouseEvent) : void{}
      
      override protected function __onResponse(param1:FrameEvent) : void{}
      
      public function setMessage(param1:int, param2:String, param3:String) : void{}
      
      protected function update() : void{}
      
      protected function lookUpEquip() : void{}
      
      override protected function submit() : void{}
      
      override protected function hide() : void{}
      
      override public function dispose() : void{}
   }
}
