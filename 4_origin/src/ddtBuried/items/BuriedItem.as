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
      
      public function BuriedItem(txtstr:String, icon:String)
      {
         super();
         initView(txtstr,icon);
      }
      
      private function initView(txtstr:String, icon:String) : void
      {
         _back = ComponentFactory.Instance.creat("buried.item.back");
         addChild(_back);
         _icon = ComponentFactory.Instance.creat(icon);
         addChild(_icon);
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtburied.buriedItem.txt");
         addChild(_txt);
         _txt.text = txtstr;
      }
      
      public function upDateTxt(str:String) : void
      {
         _txt.text = str;
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
