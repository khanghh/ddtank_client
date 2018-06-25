package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class ExpTotalCountingTxt extends ExpCountingTxt
   {
      
      public static const RED:uint = 16711680;
      
      public static const GREEN:uint = 65280;
       
      
      private var _bg:Bitmap;
      
      private var _color:uint;
      
      public function ExpTotalCountingTxt(textStyle:String, textFormatString:String, color:uint)
      {
         _color = color;
         super(textStyle,textFormatString);
      }
      
      override protected function init() : void
      {
         super.init();
         if(_color == 16711680)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.experience.TotalTxtRedBg");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.experience.TotalTxtGreenBg");
         }
         addChildAt(_bg,0);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         super.dispose();
      }
   }
}
