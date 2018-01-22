package ddtBuried.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuriedItem extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _back:Bitmap;
      
      private var _icon:Bitmap;
      
      public function BuriedItem(param1:String, param2:String)
      {
         super();
         initView(param1,param2);
      }
      
      private function initView(param1:String, param2:String) : void
      {
         _back = ComponentFactory.Instance.creat("buried.item.back");
         addChild(_back);
         _icon = ComponentFactory.Instance.creat(param2);
         addChild(_icon);
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtburied.buriedItem.txt");
         addChild(_txt);
         _txt.text = param1;
      }
      
      public function upDateTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
