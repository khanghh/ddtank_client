package ddt.view.roulette
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class RouletteGoodsCell extends BaseCell
   {
       
      
      private var _selected:Boolean;
      
      private var _count:int;
      
      private var _boolCreep:Boolean;
      
      private var _selectMovie:MovieClip;
      
      private var count_txt:FilterFrameText;
      
      private var _text_x:int;
      
      private var _text_y:int;
      
      private var _bgW:int;
      
      private var _bgH:int;
      
      private var _stop:Bitmap;
      
      public function RouletteGoodsCell(bg:DisplayObject, text_x:int, text_y:int)
      {
         super(bg);
         _text_x = text_x;
         _text_y = text_y;
         initII();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _picPos = new Point(0,0);
      }
      
      protected function initII() : void
      {
         _stop = ComponentFactory.Instance.creat("asset.awardSystem.roulette.StopAsset");
         addChild(_stop);
         _selectMovie = ComponentFactory.Instance.creatCustomObject("awardSystem.roulette.SelectGlintAsset");
         addChild(_selectMovie);
         count_txt = ComponentFactory.Instance.creat("roulette.RouletteCellCount");
         count_txt.x = _text_x;
         count_txt.y = _text_y;
         addChild(count_txt);
         count = 0;
         tipDirctions = "1,2,7,0";
         _stop.visible = false;
      }
      
      public function setSparkle() : void
      {
         selected = true;
         _selectMovie.gotoAndStop(1);
      }
      
      public function set count(n:int) : void
      {
         _count = n;
         count_txt.parent.removeChild(count_txt);
         addChild(count_txt);
         if(n <= 1)
         {
            count_txt.text = "";
            return;
         }
         count_txt.text = String(n);
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
      
      public function addCellBg(value:DisplayObject) : void
      {
         addChildAt(value,0);
      }
      
      public function out() : void
      {
         _stop.visible = true;
         info = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_selectMovie)
         {
            ObjectUtils.disposeObject(_selectMovie);
         }
         _selectMovie = null;
         if(count_txt)
         {
            ObjectUtils.disposeObject(count_txt);
         }
         count_txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
