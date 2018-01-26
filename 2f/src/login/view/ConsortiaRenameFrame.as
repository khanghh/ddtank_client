package login.view
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.AccountInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.CrytoUtils;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class ConsortiaRenameFrame extends RoleRenameFrame
   {
       
      
      public function ConsortiaRenameFrame(){super();}
      
      override protected function configUi() : void{}
      
      override protected function __onModifyClick(param1:MouseEvent) : void{}
      
      override protected function doRename() : void{}
      
      override protected function createModifyLoader(param1:String, param2:URLVariables, param3:String, param4:Function) : RequestLoader{return null;}
      
      override protected function renameComplete() : void{}
   }
}
