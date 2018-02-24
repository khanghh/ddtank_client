package rank.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rank.RankManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RankMenu extends Sprite implements Disposeable
   {
       
      
      private var _selectItem:RankCell;
      
      private var _cellArr:Array;
      
      public function RankMenu(){super();}
      
      private function createUI() : void{}
      
      private function _cellClickedHandle(param1:MouseEvent) : void{}
      
      public function init() : void{}
      
      private function setSelectItem(param1:RankCell) : void{}
      
      public function dispose() : void{}
   }
}
