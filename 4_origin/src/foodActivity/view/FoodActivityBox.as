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
      
      public function FoodActivityBox()
      {
         super();
      }
      
      override protected function addChildren() : void
      {
         _box = ComponentFactory.Instance.creat("foodActivity.box");
         addChild(_box);
         width = _box.width + 2;
         height = _box.height + 2;
      }
      
      public function play(frame:int) : void
      {
         _box.gotoAndStop(frame);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _box.stop();
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         _data = null;
         super.dispose();
      }
   }
}
