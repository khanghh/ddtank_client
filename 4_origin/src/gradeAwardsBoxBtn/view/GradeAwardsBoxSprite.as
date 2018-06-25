package gradeAwardsBoxBtn.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import gradeAwardsBoxBtn.ui.GradeAwardsBoxBitmapTitle;
   import hall.HallStateView;
   
   public class GradeAwardsBoxSprite extends Sprite implements Disposeable
   {
      
      private static var instance:GradeAwardsBoxSprite;
       
      
      private var _gradeAwardsBoxBtn:MovieImage;
      
      private var _gradeBottomTimeTips:FilterFrameText;
      
      private var _gradeBG:ScaleLeftRightImage;
      
      private var _gradeBD:GradeAwardsBoxBitmapTitle;
      
      private var _gradeAwardsItem:BagCell;
      
      private var _isVisible:Boolean = false;
      
      private var _hall:HallStateView;
      
      public function GradeAwardsBoxSprite(single:inner)
      {
         super();
         init();
      }
      
      public static function getInstance() : GradeAwardsBoxSprite
      {
         if(!instance)
         {
            instance = new GradeAwardsBoxSprite(new inner());
         }
         return instance;
      }
      
      private function init() : void
      {
         _gradeAwardsBoxBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hall.gradeAwardsBoxBtn");
         _gradeBD = new GradeAwardsBoxBitmapTitle();
         _gradeBD.init();
         _gradeBD._gradeBitmap = _gradeAwardsBoxBtn.movie.getChildAt(1) as Bitmap;
         _gradeBottomTimeTips = ComponentFactory.Instance.creat("bossbox.gradeAwardBoxStyle");
         _gradeBG = ComponentFactory.Instance.creatComponentByStylename("hall.timeBox.LeftRightBG");
         _gradeAwardsItem = new BagCell(0);
         _gradeAwardsItem.alpha = 0;
         _gradeAwardsItem.x = 10;
         _gradeAwardsItem.y = 8;
         _gradeAwardsItem.buttonMode = true;
         _gradeAwardsItem.useHandCursor = true;
         addChild(_gradeAwardsBoxBtn);
         addChild(_gradeBG);
         addChild(_gradeBottomTimeTips);
         addChild(_gradeAwardsItem);
         _gradeAwardsBoxBtn.buttonMode = true;
         _gradeAwardsBoxBtn.useHandCursor = true;
         x = 18;
         y = 220;
      }
      
      public function updateText($text:String) : void
      {
         _gradeBottomTimeTips.text = $text;
      }
      
      public function show(info:InventoryItemInfo, shining:Boolean) : void
      {
         var movie:* = null;
         if(_hall != null)
         {
            if(_gradeBottomTimeTips == null)
            {
               return;
            }
            if(_gradeAwardsItem == null)
            {
               return;
            }
            _gradeAwardsItem.info = info;
            _gradeBD.setBitmapData(info.NeedLevel);
            movie = _gradeAwardsBoxBtn.movie.getChildAt(2) as MovieClip;
            if(shining)
            {
               movie.visible = true;
               movie.play();
            }
            else
            {
               movie.visible = false;
               movie.stop();
            }
            _hall.addChild(this);
            _isVisible = true;
         }
      }
      
      public function hide() : void
      {
         if(_hall == null)
         {
            return;
         }
         _isVisible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_gradeBD);
         _gradeBD = null;
         ObjectUtils.disposeObject(_gradeAwardsBoxBtn);
         _gradeAwardsBoxBtn = null;
         ObjectUtils.disposeObject(_gradeBG);
         _gradeBG = null;
         ObjectUtils.disposeObject(_gradeBottomTimeTips);
         _gradeBottomTimeTips = null;
         ObjectUtils.disposeObject(_gradeAwardsItem);
         _gradeAwardsItem = null;
         while(instance.numChildren > 0)
         {
            instance.removeChildAt(0);
         }
         _hall = null;
         instance = null;
      }
      
      public function setHall(value:HallStateView) : void
      {
         _hall = value;
      }
      
      public function get isVisible() : Boolean
      {
         return _isVisible;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
