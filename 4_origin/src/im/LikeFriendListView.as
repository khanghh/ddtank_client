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
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc2_["selfid"] = PlayerManager.Instance.Self.ID;
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("SameCityIMLoad.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingLikeFriendTemplateFailure");
         _loc1_.analyzer = new LikeFriendAnalyzer(__loadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
         return _loc1_;
      }
      
      private function __loadComplete(param1:LikeFriendAnalyzer) : void
      {
         var _loc2_:* = param1.likeFriendList;
         IMControl.Instance.likeFriendList = _loc2_;
         _likeFriendList = _loc2_;
         __updateList();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         if(!_currentItem)
         {
            _currentItem = param1.cellValue as LikeFriendInfo;
            _currentItem.isSelected = true;
         }
         else if(_currentItem != param1.cellValue as LikeFriendInfo)
         {
            _currentItem.isSelected = false;
            _currentItem = param1.cellValue as LikeFriendInfo;
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
         var _loc1_:IntPoint = new IntPoint(0,_pos);
         _list.list.viewPosition = _loc1_;
      }
      
      private function update() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _likeFriendList.length)
         {
            _loc3_ = _likeFriendList[_loc4_];
            if(_loc3_.IsVIP)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc1_.push(_loc3_);
            }
            _loc4_++;
         }
         _loc2_ = _loc2_.sortOn("Grade",16 | 2);
         _loc1_ = _loc1_.sortOn("Grade",16 | 2);
         _likeFriendList = _loc2_.concat(_loc1_);
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
