package drgnBoatBuild.views
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import drgnBoatBuild.DrgnBoatBuildCellInfo;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import drgnBoatBuild.components.BuildProgress;
   import drgnBoatBuild.event.DrgnBoatBuildEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DrgnBoatBuildLeftView extends Sprite implements Disposeable
   {
       
      
      private var _leftBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _progress:BuildProgress;
      
      private var _staticBuilding:MovieClip;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _ownImg:Bitmap;
      
      private var _ownedBeard:FilterFrameText;
      
      private var _ownedWood:FilterFrameText;
      
      private var _btn:SimpleBitmapButton;
      
      private var _itemBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _complete:Bitmap;
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _cell:BagCell;
      
      private var _tipTouchArea:Component;
      
      private var _stage:int;
      
      private var _isSelf:Boolean = true;
      
      private var _userId:int;
      
      public function DrgnBoatBuildLeftView(){super();}
      
      private function initView() : void{}
      
      public function setView() : void{}
      
      private function initEvents() : void{}
      
      protected function __backBtnClick(param1:MouseEvent) : void{}
      
      protected function __btnClick(param1:MouseEvent) : void{}
      
      protected function __update(param1:DrgnBoatBuildEvent) : void{}
      
      private function createTipArea() : void{}
      
      private function removeEvents() : void{}
      
      private function clear() : void{}
      
      public function dispose() : void{}
   }
}
