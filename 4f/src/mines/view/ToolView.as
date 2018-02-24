package mines.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import mines.MinesManager;
   import mines.mornui.view.ToolViewUI;
   import morn.core.handlers.Handler;
   
   public class ToolView extends ToolViewUI
   {
       
      
      private var shape:Shape;
      
      private var nameList:Array;
      
      private var cell:MinesCell;
      
      private var place:int;
      
      public function ToolView(){super();}
      
      override protected function initialize() : void{}
      
      private function levelUpTool(param1:Event) : void{}
      
      private function levelUp() : void{}
      
      public function cellChange(param1:BagCell) : void{}
      
      public function DrawSector(param1:Shape, param2:Number = 200, param3:Number = 200, param4:Number = 100, param5:Number = 27, param6:Number = 270, param7:Number = 16711680) : void{}
      
      private function setData() : void{}
      
      override public function dispose() : void{}
   }
}
