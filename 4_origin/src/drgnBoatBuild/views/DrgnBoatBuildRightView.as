package drgnBoatBuild.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import drgnBoatBuild.DrgnBoatBuildCellInfo;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import drgnBoatBuild.components.DrgnBoatBuildListCell;
   import drgnBoatBuild.event.DrgnBoatBuildEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DrgnBoatBuildRightView extends Sprite implements Disposeable
   {
       
      
      private var _rightBg:Bitmap;
      
      private var _listPanel:ListPanel;
      
      public function DrgnBoatBuildRightView()
      {
         super();
         initView();
         initEvents();
         DrgnBoatBuildManager.instance.updateDrgnBoatFriendList();
      }
      
      private function initView() : void
      {
         _rightBg = ComponentFactory.Instance.creat("drgnBoatBuild.rightViewBg");
         addChild(_rightBg);
         _listPanel = ComponentFactory.Instance.creat("drgnBoatBuild.listPanel");
         _listPanel.vScrollProxy = 0;
         addChild(_listPanel);
         _listPanel.list.updateListView();
      }
      
      private function initEvents() : void
      {
         DrgnBoatBuildManager.instance.addEventListener("updateFriendList",__updateFriendList);
      }
      
      protected function __updateFriendList(param1:DrgnBoatBuildEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc1_:* = null;
         _listPanel.vectorListModel.clear();
         var _loc4_:int = 0;
         var _loc3_:* = DrgnBoatBuildManager.instance.friendStateList;
         for each(var _loc2_ in DrgnBoatBuildManager.instance.friendStateList)
         {
            _loc1_ = _loc2_.playerinfo;
            if(_loc1_)
            {
               _listPanel.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc1_));
            }
         }
         _listPanel.list.updateListView();
      }
      
      private function getInsertIndex(param1:PlayerInfo) : int
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _listPanel.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = (_loc3_[_loc5_] as DrgnBoatBuildCellInfo).playerinfo;
            if(!(param1.IsVIP && !_loc4_.IsVIP))
            {
               if(!param1.IsVIP && _loc4_.IsVIP)
               {
                  return _loc5_ + 1;
               }
               if(param1.IsVIP == _loc4_.IsVIP)
               {
                  if(param1.Grade > _loc4_.Grade)
                  {
                     _loc2_ = _loc5_ - 1;
                  }
                  else
                  {
                     return _loc5_ + 1;
                  }
               }
            }
            _loc5_--;
         }
         return _loc2_ < 0?0:_loc2_;
      }
      
      private function removeEvents() : void
      {
         DrgnBoatBuildManager.instance.removeEventListener("updateFriendList",__updateFriendList);
      }
      
      public function dispose() : void
      {
         removeEvents();
         DrgnBoatBuildManager.instance.selectedId = 0;
         var _loc3_:int = 0;
         var _loc2_:* = _listPanel.list.cell;
         for each(var _loc1_ in _listPanel.list.cell)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _listPanel.vectorListModel.clear();
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
      }
   }
}
