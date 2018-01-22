package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkModel;
   import mark.event.MarkEvent;
   import mark.items.MarkChipItem;
   import mark.items.MarkEquipItem;
   import mark.mornUI.views.MarkOtherViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkOtherView extends MarkOtherViewUI
   {
       
      
      private var _items:Vector.<MarkChipItem> = null;
      
      private var _item:BaseCell = null;
      
      private var _info:PlayerInfo = null;
      
      public function MarkOtherView(param1:PlayerInfo){super();}
      
      override protected function initialize() : void{}
      
      private function get equipList() : Array{return null;}
      
      private function render(param1:MarkEquipItem, param2:int) : void{}
      
      private function select(param1:int) : void{}
      
      private function getSelfChips(param1:int) : Array{return null;}
      
      private function clearItems() : void{}
      
      private function disposeView(param1:MarkEvent) : void{}
      
      override public function dispose() : void{}
   }
}
