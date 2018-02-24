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
      
      public function DrgnBoatBuildRightView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __updateFriendList(param1:DrgnBoatBuildEvent) : void{}
      
      private function update() : void{}
      
      private function getInsertIndex(param1:PlayerInfo) : int{return 0;}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
