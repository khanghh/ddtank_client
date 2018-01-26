package serverlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.ServerInfo;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ServerDropListItem extends Sprite
   {
       
      
      private var _info:ServerInfo;
      
      protected var _text:FilterFrameText;
      
      public function ServerDropListItem(){super();}
      
      protected function initView() : void{}
      
      public function set info(param1:ServerInfo) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      private function __onMouseOut(param1:MouseEvent) : void{}
   }
}
