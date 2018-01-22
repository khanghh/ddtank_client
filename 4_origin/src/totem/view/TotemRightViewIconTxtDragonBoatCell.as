package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class TotemRightViewIconTxtDragonBoatCell extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _iconDiscount:Bitmap;
      
      public function TotemRightViewIconTxtDragonBoatCell()
      {
         super();
         _txt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.iconCell.txt");
         _iconDiscount = ComponentFactory.Instance.creatBitmap("totem.rightView.iconDiscount");
         _iconDiscount.y = -10;
         addChild(_txt);
         addChild(_iconDiscount);
      }
      
      public function refresh(param1:int, param2:Boolean = false) : void
      {
         _txt.text = param1.toString();
         if(param2)
         {
            _txt.setTextFormat(new TextFormat(null,null,16711680));
         }
         _iconDiscount.x = _txt.x + _txt.textWidth + 5;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _iconDiscount = null;
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
