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
      
      public function set type(type:int) : void
      {
         _type = type;
         _image.setFrame(type);
         _title.setFrame(type);
         _text.setFrame(type);
      }
      
      public function set complete(value:Boolean) : void
      {
         if(!value)
         {
            return;
         }
         _text.setFrame(6);
      }
      
      public function set titleText(value:String) : void
      {
         _title.text = value;
      }
      
      public function set text(value:String) : void
      {
         _text.text = value;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
