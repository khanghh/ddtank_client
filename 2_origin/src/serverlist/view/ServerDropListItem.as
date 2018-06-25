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
      
      public function ServerDropListItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _text = ComponentFactory.Instance.creat("serverlist.hall.ServerNameText");
         addChild(_text);
      }
      
      public function set info(value:ServerInfo) : void
      {
         _info = value;
         _text.text = _info.Name;
         addEventListener("click",__onClick);
         addEventListener("mouseOver",__onMouseOver);
      }
      
      private function __onClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ServerManager.Instance.connentServer(_info);
      }
      
      private function __onMouseOver(e:MouseEvent) : void
      {
         addEventListener("mouseOut",__onMouseOut);
         _text.background = true;
         _text.textFormatStyle = "serverlist.ServerNameTextFormatHover";
      }
      
      private function __onMouseOut(e:MouseEvent) : void
      {
         removeEventListener("mouseOut",__onMouseOut);
         _text.background = false;
         _text.textFormatStyle = "serverlist.ServerNameTextFormat";
      }
   }
}
