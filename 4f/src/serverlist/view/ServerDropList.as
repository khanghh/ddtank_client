package serverlist.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import trainer.controller.SystemOpenPromptManager;
   
   public class ServerDropList extends Frame
   {
       
      
      protected var _expanded:Boolean;
      
      protected var _bg:Bitmap;
      
      private var _loader:BaseLoader;
      
      protected var _cb:ComboBox;
      
      private var _isClick:Boolean;
      
      public function ServerDropList(){super();}
      
      protected function initView() : void{}
      
      protected function initEvent() : void{}
      
      private function __onClicked(param1:MouseEvent) : void{}
      
      protected function __onStageClicked(param1:MouseEvent) : void{}
      
      private function __onListClicked(param1:ListItemEvent) : void{}
      
      private function updateServerList() : void{}
      
      protected function getServerList() : Vector.<ServerInfo>{return null;}
      
      public function hideList() : void{}
      
      private function getServerByName(param1:String) : ServerInfo{return null;}
      
      public function refresh() : void{}
      
      public function updateList() : void{}
      
      public function __onListLoadComplete(param1:LoaderEvent) : void{}
      
      override public function dispose() : void{}
   }
}
