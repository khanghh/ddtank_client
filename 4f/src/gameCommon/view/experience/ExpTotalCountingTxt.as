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
      
      public function ExpTotalCountingTxt(param1:String, param2:String, param3:uint){super(null,null);}
      
      override protected function init() : void{}
      
      override public function dispose() : void{}
   }
}
