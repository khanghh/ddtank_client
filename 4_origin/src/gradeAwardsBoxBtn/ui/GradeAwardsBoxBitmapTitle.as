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
      
      public function addGradeBitmap(param1:int, param2:BitmapData) : void
      {
         _gradeTextDic[param1] = param2;
      }
      
      public function setBitmapData(param1:int) : void
      {
         var _loc2_:BitmapData = _gradeTextDic[param1];
         if(_loc2_ != null)
         {
            _gradeBitmap.bitmapData = _loc2_;
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
