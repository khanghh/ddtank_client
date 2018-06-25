package luckStar.cell
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import luckStar.event.LuckStarEvent;
   import luckStar.view.LuckStarAwardAction;
   
   public class LuckStarCell extends BaseCell
   {
       
      
      private var _maxAward:Bitmap;
      
      private var _cellFrame:Bitmap;
      
      private var _txtCount:FilterFrameText;
      
      private var _selectMovie:MovieClip;
      
      public var _isMaxAward:Boolean;
      
      private var _awardAction:LuckStarAwardAction;
      
      private var _selected:Boolean;
      
      private var _boolCreep:Boolean;
      
      public function LuckStarCell(bg:DisplayObject = null)
      {
         super(ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.cellBg"));
         initView();
      }
      
      private function initView() : void
      {
         _maxAward = ComponentFactory.Instance.creat("luckyStar.view.MaxAward");
         _cellFrame = ComponentFactory.Instance.creat("luckyStar.view.CellFrame");
         _txtCount = ComponentFactory.Instance.creat("luckyStar.view.cellCount");
         _selectMovie = ComponentFactory.Instance.creat("asset.awardSystem.roulette.SelectGlintAsset");
         _selectMovie.x = 5;
         _selectMovie.y = 6;
         addChild(_cellFrame);
         addChild(_maxAward);
         addChild(_selectMovie);
         var _loc1_:Boolean = false;
         _maxAward.visible = _loc1_;
         _cellFrame.visible = _loc1_;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         if(value == null)
         {
            return;
         }
         .super.info = value;
         if(value.Quality == 1)
         {
            _isMaxAward = true;
            _maxAward.visible = true;
            if(_pic)
            {
               _pic.visible = false;
            }
         }
         else if(value.Quality == 2)
         {
            _cellFrame.visible = true;
         }
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.width = 48;
            sp.height = 48;
            if(_picPos != null)
            {
               sp.x = _picPos.x;
            }
            else
            {
               sp.x = Math.abs(sp.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               sp.y = _picPos.y;
            }
            else
            {
               sp.y = Math.abs(sp.height - _contentHeight) / 2;
            }
         }
      }
      
      public function get isMaxAward() : Boolean
      {
         return _isMaxAward;
      }
      
      public function set count(value:int) : void
      {
         if(value <= 1)
         {
            _txtCount.text = "";
            return;
         }
         _txtCount.text = String(value);
         addChild(_txtCount);
      }
      
      public function playAction() : void
      {
         if(_awardAction)
         {
            _awardAction.dispose();
            _awardAction = null;
         }
         _awardAction = new LuckStarAwardAction();
         _awardAction.playAction(cell,createDragImg(),getMove(),isMaxAward);
         if(!isMaxAward)
         {
            addChild(_awardAction.actionDisplay);
         }
      }
      
      private function getMove() : Point
      {
         return globalToLocal(ComponentFactory.Instance.creatCustomObject("luckyStar.view.goalPos"));
      }
      
      private function cell() : void
      {
         ObjectUtils.disposeObject(_awardAction);
         _awardAction = null;
         dispatchEvent(new LuckStarEvent(4));
      }
      
      public function setSparkle() : void
      {
         selected = true;
         _selectMovie.gotoAndStop(1);
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
         if(_awardAction)
         {
            ObjectUtils.disposeObject(_awardAction);
            _awardAction = null;
         }
         ObjectUtils.disposeObject(_txtCount);
         _txtCount = null;
         ObjectUtils.disposeObject(_maxAward);
         _maxAward = null;
         ObjectUtils.disposeObject(_cellFrame);
         _cellFrame = null;
         super.dispose();
      }
   }
}
