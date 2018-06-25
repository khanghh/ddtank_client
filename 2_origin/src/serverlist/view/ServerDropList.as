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
      
      public function ServerDropList()
      {
         super();
         _expanded = false;
         initView();
         initEvent();
         _cb.textField.text = ServerManager.Instance.current.Name;
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.serverlist.hallBG");
         _cb = ComponentFactory.Instance.creat("serverlist.hall.DropListCombo");
         addChild(_cb);
      }
      
      protected function initEvent() : void
      {
         _cb.listPanel.list.addEventListener("listItemClick",__onListClicked);
         _cb.addEventListener("click",__onClicked);
      }
      
      private function __onClicked(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _isClick = true;
         updateList();
      }
      
      protected function __onStageClicked(e:MouseEvent) : void
      {
         hideList();
         _expanded = false;
      }
      
      private function __onListClicked(e:ListItemEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ServerManager.Instance.refreshFlag = true;
         SystemOpenPromptManager.instance.isShowNewEuipTip = false;
         var _info:ServerInfo = getServerByName(e.cellValue);
         if(ServerManager.Instance.connentServer(_info) == false)
         {
            refresh();
         }
         else
         {
            _cb.mouseChildren = false;
         }
      }
      
      private function updateServerList() : void
      {
         _cb.beginChanges();
         var comboxModel:VectorListModel = _cb.listPanel.vectorListModel;
         comboxModel.clear();
         var _loc4_:int = 0;
         var _loc3_:* = getServerList();
         for each(var info in getServerList())
         {
            comboxModel.append(info.Name);
         }
         _cb.commitChanges();
         if(_isClick)
         {
            _cb.doShow();
            _isClick = false;
         }
      }
      
      protected function getServerList() : Vector.<ServerInfo>
      {
         var list:Vector.<ServerInfo> = ServerManager.Instance.list;
         var result:Vector.<ServerInfo> = new Vector.<ServerInfo>();
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var info in list)
         {
            if(info.Name != ServerManager.Instance.current.Name)
            {
               if(info.State != 1)
               {
                  result.push(info);
               }
            }
         }
         return result;
      }
      
      public function hideList() : void
      {
      }
      
      private function getServerByName(serverName:String) : ServerInfo
      {
         var list:Vector.<ServerInfo> = ServerManager.Instance.list;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var info in list)
         {
            if(info.Name == serverName)
            {
               return info;
            }
         }
         return null;
      }
      
      public function refresh() : void
      {
         _cb.mouseChildren = true;
         updateList();
         _cb.textField.text = ServerManager.Instance.current.Name;
      }
      
      public function updateList() : void
      {
         _loader = LoaderCreate.Instance.creatServerListLoader();
         _loader.addEventListener("complete",__onListLoadComplete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      public function __onListLoadComplete(e:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__onListLoadComplete);
         updateServerList();
         _cb.textField.text = ServerManager.Instance.current.Name;
      }
      
      override public function dispose() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__onListLoadComplete);
         }
         _loader = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_cb)
         {
            _cb.listPanel.list.removeEventListener("listItemClick",__onListClicked);
            _cb.removeEventListener("click",__onClicked);
            _cb.dispose();
         }
         _cb = null;
         super.dispose();
      }
   }
}
