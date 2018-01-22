package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class FineSuitTipsItem extends Sprite implements Disposeable
   {
       
      
      private var _title:FilterFrameText;
      
      private var _text:FilterFrameText;
      
      private var _image:ScaleFrameImage;
      
      private var _type:int;
      
      public function FineSuitTipsItem()
      {
         super();
         _title = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.item");
         addChild(_title);
         _text = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.itemProperty");
         addChild(_text);
         _image = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.image");
         addChild(_image);
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _image.setFrame(param1);
         _title.setFrame(param1);
         _text.setFrame(param1);
      }
      
      public function set complete(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         _text.setFrame(6);
      }
      
      public function set titleText(param1:String) : void
      {
         _title.text = param1;
      }
      
      public function set text(param1:String) : void
      {
         _text.text = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
