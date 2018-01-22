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
      
      private function __onClicked(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _isClick = true;
         updateList();
      }
      
      protected function __onStageClicked(param1:MouseEvent) : void
      {
         hideList();
         _expanded = false;
      }
      
      private function __onListClicked(param1:ListItemEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ServerManager.Instance.refreshFlag = true;
         SystemOpenPromptManager.instance.isShowNewEuipTip = false;
         var _loc2_:ServerInfo = getServerByName(param1.cellValue);
         if(ServerManager.Instance.connentServer(_loc2_) == false)
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
         var _loc1_:VectorListModel = _cb.listPanel.vectorListModel;
         _loc1_.clear();
         var _loc4_:int = 0;
         var _loc3_:* = getServerList();
         for each(var _loc2_ in getServerList())
         {
            _loc1_.append(_loc2_.Name);
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
         var _loc2_:Vector.<ServerInfo> = ServerManager.Instance.list;
         var _loc1_:Vector.<ServerInfo> = new Vector.<ServerInfo>();
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Name != ServerManager.Instance.current.Name)
            {
               if(_loc3_.State != 1)
               {
                  _loc1_.push(_loc3_);
               }
            }
         }
         return _loc1_;
      }
      
      public function hideList() : void
      {
      }
      
      private function getServerByName(param1:String) : ServerInfo
      {
         var _loc2_:Vector.<ServerInfo> = ServerManager.Instance.list;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Name == param1)
            {
               return _loc3_;
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
      
      public function __onListLoadComplete(param1:LoaderEvent) : void
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
