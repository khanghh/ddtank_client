package ddt.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import im.CustomInfo;
   
   public class FriendGroupFrame extends Frame
   {
       
      
      private var _confirm:TextButton;
      
      private var _close:TextButton;
      
      private var _combox:ComboBox;
      
      public var nickName:String;
      
      private var _customList:Vector.<CustomInfo>;
      
      public function FriendGroupFrame(){super();}
      
      protected function __itemClick(param1:ListItemEvent) : void{}
      
      protected function __confirmHandler(param1:MouseEvent) : void{}
      
      protected function __clickHandler(param1:MouseEvent) : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      protected function __buttonClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
