package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import road7th.utils.StringHelper;
   
   public class InviteDialogFrame extends AddFriendFrame
   {
       
      
      private var _userName:String;
      
      private var _inviteCaption:String;
      
      private var _inputBG:Scale9CornerImage;
      
      private var _text:String;
      
      private var _initText:String;
      
      public function InviteDialogFrame(){super();}
      
      override protected function initContainer() : void{}
      
      protected function __inputChange(param1:Event) : void{}
      
      public function setInfo(param1:String) : void{}
      
      public function setText(param1:String = "") : void{}
      
      override protected function __fieldKeyDown(param1:KeyboardEvent) : void{}
      
      override protected function submit() : void{}
      
      private function onIOError(param1:IOErrorEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
