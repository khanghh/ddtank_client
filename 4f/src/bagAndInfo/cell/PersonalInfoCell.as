package bagAndInfo.cell
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gemstone.info.GemstoneInfo;
   import petsBag.PetsBagManager;
   
   public class PersonalInfoCell extends BagCell
   {
       
      
      public var gemstoneList:Vector.<GemstoneInfo>;
      
      private var _isGemstone:Boolean = false;
      
      private var _shineObject:MovieClip;
      
      public function PersonalInfoCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true){super(null,null,null);}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dragStart() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      protected function onClick(param1:InteractiveEvent) : void{}
      
      protected function onDoubleClick(param1:InteractiveEvent) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function createLoading() : void{}
      
      override public function checkOverDate() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onBindResponse(param1:FrameEvent) : void{}
      
      private function sendDefy() : void{}
      
      private function sendBindDefy() : void{}
      
      private function getCellIndex(param1:ItemTemplateInfo) : Array{return null;}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      public function shine() : void{}
      
      public function stopShine() : void{}
      
      override public function updateCount() : void{}
      
      override public function dispose() : void{}
   }
}
