package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkProData;
   import mark.data.MarkSetTemplateData;
   import mark.data.MarkSuitTemplateData;
   import mark.event.MarkEvent;
   import mark.items.MarkChipItem;
   import mark.items.MarkEquipItem;
   import mark.items.MarkSuitProItem;
   import mark.mornUI.views.MarkLeftViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkLeftView extends MarkLeftViewUI
   {
       
      
      private var _items:Vector.<MarkChipItem> = null;
      
      private var _item:BaseCell = null;
      
      private var _bgEffect:MovieClip = null;
      
      public function MarkLeftView(){super();}
      
      override protected function initialize() : void{}
      
      private function suitRender(param1:MarkSuitProItem, param2:int) : void{}
      
      private function render(param1:MarkEquipItem, param2:int) : void{}
      
      private function chooseEquip(param1:MarkEvent) : void{}
      
      private function updateProps() : void{}
      
      private function select(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function updateMarkMoney(param1:MarkEvent = null) : void{}
      
      protected function __onClickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function putOnChip(param1:MarkEvent) : void{}
      
      private function playSuitEffect(param1:int = 0, param2:int = 0) : void{}
      
      private function clearEffect() : void{}
      
      private function putOffChip(param1:MarkEvent) : void{}
      
      private function disposeView(param1:MarkEvent) : void{}
      
      private function clearItems() : void{}
      
      override public function dispose() : void{}
   }
}
