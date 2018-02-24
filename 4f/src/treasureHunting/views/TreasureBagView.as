package treasureHunting.views
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import treasureHunting.TreasureControl;
   import treasureHunting.event.TreasureEvent;
   
   public class TreasureBagView extends Sprite implements Disposeable
   {
      
      public static const BAG_SIZE:int = 24;
       
      
      private var _bagBG:Bitmap;
      
      private var _baglist:BagListView;
      
      private var _getAllBtn:BaseButton;
      
      private var _convertBtn:BaseButton;
      
      private var _bagData:Dictionary;
      
      private var isBagUpdate:Boolean;
      
      public function TreasureBagView(){super();}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function updateData(param1:Dictionary) : void{}
      
      private function onMovieComplete(param1:TreasureEvent) : void{}
      
      private function updateBagFrame() : void{}
      
      private function onItemClick(param1:CellEvent) : void{}
      
      private function _getBagType(param1:InventoryItemInfo) : int{return 0;}
      
      private function onGetAllBtnClick(param1:MouseEvent) : void{}
      
      private function onConvertBtnClick(param1:MouseEvent) : void{}
      
      private function onAlertResponse(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
      
      public function get convertBtn() : BaseButton{return null;}
   }
}
