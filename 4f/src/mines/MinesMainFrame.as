package mines
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import labyrinth.LabyrinthManager;
   import mines.mornui.MinesMainFrameUI;
   import mines.view.DigView;
   import mines.view.EquipmentView;
   import mines.view.MinesBagView;
   import mines.view.ShopView;
   import mines.view.ToolView;
   import morn.core.handlers.Handler;
   
   public class MinesMainFrame extends MinesMainFrameUI
   {
       
      
      private var _bagView:MinesBagView;
      
      private var _digView:DigView;
      
      private var _shopView:ShopView;
      
      private var _toolView:ToolView;
      
      private var _equipmentView:EquipmentView;
      
      private var _index:int;
      
      public function MinesMainFrame(){super();}
      
      private function addEvent() : void{}
      
      private function chatHandler() : void{}
      
      private function select(param1:int) : void{}
      
      private function openShopView(param1:Event) : void{}
      
      override protected function initialize() : void{}
      
      private function doubleClick(param1:CellEvent) : void{}
      
      private function openHelp() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
