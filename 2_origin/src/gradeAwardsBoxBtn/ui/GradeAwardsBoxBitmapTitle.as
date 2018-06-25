package gradeAwardsBoxBtn.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class GradeAwardsBoxBitmapTitle implements Disposeable
   {
       
      
      public var _gradeBitmap:Bitmap;
      
      private var _gradeTextDic:Dictionary;
      
      public function GradeAwardsBoxBitmapTitle()
      {
         super();
         _gradeTextDic = new Dictionary();
         _gradeBitmap = new Bitmap();
      }
      
      public function init() : void
      {
         addGradeBitmap(10,ComponentFactory.Instance.creatBitmapData("asset.hall.grade10"));
         addGradeBitmap(12,ComponentFactory.Instance.creatBitmapData("asset.hall.grade12"));
         addGradeBitmap(16,ComponentFactory.Instance.creatBitmapData("asset.hall.grade16"));
         addGradeBitmap(19,ComponentFactory.Instance.creatBitmapData("asset.hall.grade19"));
      }
      
      public function addGradeBitmap(grade:int, bitmapData:BitmapData) : void
      {
         _gradeTextDic[grade] = bitmapData;
      }
      
      public function setBitmapData(grade:int) : void
      {
         var bmd:BitmapData = _gradeTextDic[grade];
         if(bmd != null)
         {
            _gradeBitmap.bitmapData = bmd;
         }
      }
      
      public function dispose() : void
      {
         if(_gradeBitmap.bitmapData)
         {
            _gradeBitmap.bitmapData.dispose();
         }
         _gradeBitmap = null;
         _gradeTextDic = null;
      }
   }
}
