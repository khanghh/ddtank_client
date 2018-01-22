package foodActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   
   public class FoodActivityBox extends Component
   {
       
      
      private var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      private var _box:MovieClip;
      
      private var _bg:ScaleBitmapImage;
      
      private var _content:FilterFrameText;
      
      public function FoodActivityBox(){super();}
      
      override protected function addChildren() : void{}
      
      public function play(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
