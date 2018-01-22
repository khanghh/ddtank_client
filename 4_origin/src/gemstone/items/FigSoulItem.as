package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class FigSoulItem extends Component
   {
       
      
      private var _content:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function FigSoulItem(param1:String, param2:String)
      {
         super();
         _content = ComponentFactory.Instance.creatBitmap(param1);
         addChild(_content);
         _txt = ComponentFactory.Instance.creatComponentByStylename("zhanhunName");
         _txt.text = param2;
         addChild(_txt);
         tipStyle = "gemstone.items.GemstoneTip";
         tipGapV = 170;
         tipDirctions = "0,1,2";
      }
      
      override public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
