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
      
      protected function __updateFriendList(event:DrgnBoatBuildEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var player:* = null;
         _listPanel.vectorListModel.clear();
         var _loc4_:int = 0;
         var _loc3_:* = DrgnBoatBuildManager.instance.friendStateList;
         for each(var stateInfo in DrgnBoatBuildManager.instance.friendStateList)
         {
            player = stateInfo.playerinfo;
            if(player)
            {
               _listPanel.vectorListModel.insertElementAt(stateInfo,getInsertIndex(player));
            }
         }
         _listPanel.list.updateListView();
      }
      
      private function getInsertIndex(info:PlayerInfo) : int
      {
         var tempInfo:* = null;
         var i:int = 0;
         var tempIndex:int = 0;
         var tempArray:Array = _listPanel.vectorListModel.elements;
         if(tempArray.length == 0)
         {
            return 0;
         }
         for(i = tempArray.length - 1; i >= 0; )
         {
            tempInfo = (tempArray[i] as DrgnBoatBuildCellInfo).playerinfo;
            if(!(info.IsVIP && !tempInfo.IsVIP))
            {
               if(!info.IsVIP && tempInfo.IsVIP)
               {
                  return i + 1;
               }
               if(info.IsVIP == tempInfo.IsVIP)
               {
                  if(info.Grade > tempInfo.Grade)
                  {
                     tempIndex = i - 1;
                  }
                  else
                  {
                     return i + 1;
                  }
               }
            }
            i--;
         }
         return tempIndex < 0?0:tempIndex;
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
         for each(var cell in _listPanel.list.cell)
         {
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         _listPanel.vectorListModel.clear();
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
      }
   }
}
