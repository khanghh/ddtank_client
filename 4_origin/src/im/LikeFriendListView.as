package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.LikeFriendAnalyzer;
   import ddt.data.player.LikeFriendInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Sprite;
   import flash.net.URLVariables;
   
   public class LikeFriendListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      private var _likeFriendList:Array;
      
      private var _currentItem:LikeFriendInfo;
      
      private var _pos:int;
      
      public function LikeFriendListView()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get likeFriendList() : Array
      {
         return _likeFriendList;
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("IM.LikeFriendListPanel");
         _list.vScrollProxy = 1;
         addChild(_list);
         _list.list.updateListView();
         if(IMControl.Instance.likeFriendList != null)
         {
            _likeFriendList = IMControl.Instance.likeFriendList;
            __updateList();
         }
         creatItemTempleteLoader();
      }
      
      private function initEvents() : void
      {
         _list.list.addEventListener("listItemClick",__itemClick);
      }
      
      private function removeEvents() : void
      {
         _list.list.removeEventListener("listItemClick",__itemClick);
      }
      
      private function creatItemTempleteLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["selfid"] = PlayerManager.Instance.Self.ID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SameCityIMLoad.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingLikeFriendTemplateFailure");
         loader.analyzer = new LikeFriendAnalyzer(__loadComplete);
         LoadResourceManager.Instance.startLoad(loader);
         return loader;
      }
      
      private function __loadComplete(action:LikeFriendAnalyzer) : void
      {
         var _loc2_:* = action.likeFriendList;
         IMControl.Instance.likeFriendList = _loc2_;
         _likeFriendList = _loc2_;
         __updateList();
      }
      
      private function __itemClick(e:ListItemEvent) : void
      {
         if(!_currentItem)
         {
            _currentItem = e.cellValue as LikeFriendInfo;
            _currentItem.isSelected = true;
         }
         else if(_currentItem != e.cellValue as LikeFriendInfo)
         {
            _currentItem.isSelected = false;
            _currentItem = e.cellValue as LikeFriendInfo;
            _currentItem.isSelected = true;
         }
         _list.list.updateListView();
      }
      
      private function __updateList() : void
      {
         if(_list == null)
         {
            return;
         }
         _pos = _list.list.viewPosition.y;
         update();
         var intPoint:IntPoint = new IntPoint(0,_pos);
         _list.list.viewPosition = intPoint;
      }
      
      private function update() : void
      {
         var i:int = 0;
         var info:* = null;
         var tempArr:Array = [];
         var tempArr1:Array = [];
         for(i = 0; i < _likeFriendList.length; )
         {
            info = _likeFriendList[i];
            if(info.IsVIP)
            {
               tempArr.push(info);
            }
            else
            {
               tempArr1.push(info);
            }
            i++;
         }
         tempArr = tempArr.sortOn("Grade",16 | 2);
         tempArr1 = tempArr1.sortOn("Grade",16 | 2);
         _likeFriendList = tempArr.concat(tempArr1);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_likeFriendList);
         _list.list.updateListView();
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         _likeFriendList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
