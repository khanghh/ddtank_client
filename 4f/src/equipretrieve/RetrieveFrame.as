package equipretrieve
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import equipretrieve.view.RetrieveBagFrame;
   import equipretrieve.view.RetrieveBagView;
   import equipretrieve.view.RetrieveBgView;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class RetrieveFrame extends Frame
   {
       
      
      private var _retrieveBgView:RetrieveBgView;
      
      private var _retrieveBagView:RetrieveBagFrame;
      
      private var _alertInfo:AlertInfo;
      
      private var _BG:ScaleBitmapImage;
      
      public function RetrieveFrame(){super();}
      
      private function start() : void{}
      
      public function show() : void{}
      
      public function updateBag(param1:Dictionary) : void{}
      
      private function _updateStoreBag(param1:BagEvent) : void{}
      
      public function cellDoubleClick(param1:BagCell) : void{}
      
      public function set bagType(param1:int) : void{}
      
      public function set shine(param1:Boolean) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function clearItemCell() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function __onDoubleClick(param1:Event) : void{}
      
      private function __onRetrieveType(param1:Event) : void{}
      
      private function __onShine(param1:Event) : void{}
      
      private function __onMouseEnable(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
