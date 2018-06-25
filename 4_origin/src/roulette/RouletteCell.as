package roulette
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class RouletteCell extends BaseCell
   {
       
      
      private var _selected:Boolean;
      
      private var _count:int;
      
      private var _boolCreep:Boolean;
      
      private var _selectMovie:MovieClip;
      
      public function RouletteCell(bg:DisplayObject)
      {
         super(bg);
         initII();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _picPos = new Point(0,0);
      }
      
      protected function initII() : void
      {
         _selectMovie = ComponentFactory.Instance.creat("asset.roulette.GlintAsset");
         addChild(_selectMovie);
         count = 0;
         tipDirctions = "1,2,7,0";
      }
      
      public function setSparkle() : void
      {
         selected = true;
         _selectMovie.gotoAndStop(1);
      }
      
      public function set count(n:int) : void
      {
         _count = n;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function setGreep() : void
      {
         if(!_boolCreep && _selected)
         {
            _selectMovie.gotoAndPlay(2);
            _boolCreep = true;
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         _selected = value;
         _selectMovie.visible = _selected;
         if(_selected == false)
         {
            _boolCreep = false;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_selectMovie)
         {
            ObjectUtils.disposeObject(_selectMovie);
         }
         _selectMovie = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
