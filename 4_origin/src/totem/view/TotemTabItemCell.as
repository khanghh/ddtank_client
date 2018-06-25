package totem.view
{
   import totem.mornUI.TotemTabItemCellUI;
   
   public class TotemTabItemCell extends TotemTabItemCellUI
   {
       
      
      private var _quality:int = 0;
      
      public function TotemTabItemCell()
      {
         super();
         tipStyle = "ddt.view.tips.TotemLeftWindowChapterTipView";
         tipDirctions = "2,1";
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
      }
      
      public function set quality(value:int) : void
      {
         if(_quality == value)
         {
            return;
         }
         _quality = value;
         var borIndex:int = Math.max(0,value - 1) / 5 + 1;
         clip_cell.index = borIndex - 1;
      }
      
      public function get quality() : int
      {
         return _quality;
      }
      
      public function set chapter(page:int) : void
      {
         clip_chaampter.index = page - 1;
         tipData = page;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
