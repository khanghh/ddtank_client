package store.newFusion.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import store.newFusion.FusionNewManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewUnitView extends Sprite implements Disposeable
   {
      
      public static const SELECTED_CHANGE:String = "fusionNewUnitView_selected_change";
       
      
      private var _index:int;
      
      private var _rightView:FusionNewRightView;
      
      private var _selectedBtn:SelectedButton;
      
      private var _bg:Bitmap;
      
      private var _list:ListPanel;
      
      private var _isFilter:Boolean = false;
      
      private var _dataList:Array;
      
      private var _selectedValue:FusionNewVo;
      
      public function FusionNewUnitView(param1:int, param2:FusionNewRightView){super();}
      
      private function initStatus() : void{}
      
      private function extendSelecteTheFirst() : void{}
      
      private function autoSelect() : void{}
      
      public function set isFilter(param1:Boolean) : void{}
      
      private function initData() : void{}
      
      private function refreshList() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function updateBag(param1:BagEvent) : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function extendHandler() : void{}
      
      public function unextendHandler() : void{}
      
      private function getDataList() : Array{return null;}
      
      private function getSelectedBtn() : SelectedButton{return null;}
      
      override public function get height() : Number{return 0;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
