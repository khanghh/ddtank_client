package godCardRaise.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _list:ListPanel;
      
      private var dataList:Array;
      
      private var _updateFun:Function;
      
      private var _selectedValue:GodCardListGroupInfo;
      
      private var _currentID:int;
      
      public function GodCardRaiseExchangeLeftView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function setData(param1:Array, param2:Function) : void{}
      
      public function initData() : void{}
      
      public function updateView() : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
