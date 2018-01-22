package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class GemstonTipItem extends Sprite
   {
       
      
      private var txt:FilterFrameText;
      
      private var bitMap:Bitmap;
      
      public function GemstonTipItem()
      {
         super();
      }
      
      public function setInfo(param1:Object) : void
      {
         if(bitMap)
         {
            ObjectUtils.disposeObject(bitMap);
         }
         if(txt)
         {
            ObjectUtils.disposeObject(txt);
         }
         var _loc2_:* = param1.id;
         if(100001 !== _loc2_)
         {
            if(100002 !== _loc2_)
            {
               if(100003 !== _loc2_)
               {
                  if(100004 !== _loc2_)
                  {
                     if(100005 === _loc2_)
                     {
                        txt = ComponentFactory.Instance.creatComponentByStylename("gemstone.purpleTxt");
                        bitMap = ComponentFactory.Instance.creatBitmap("gemstone.purpleIcon");
                     }
                  }
                  else
                  {
                     txt = ComponentFactory.Instance.creatComponentByStylename("gemstone.yelTxt");
                     bitMap = ComponentFactory.Instance.creatBitmap("gemstone.yelIcon");
                  }
               }
               else
               {
                  txt = ComponentFactory.Instance.creatComponentByStylename("gemstone.greTxt");
                  bitMap = ComponentFactory.Instance.creatBitmap("gemstone.greIcon");
               }
            }
            else
            {
               txt = ComponentFactory.Instance.creatComponentByStylename("gemstone.bluTxt");
               bitMap = ComponentFactory.Instance.creatBitmap("gemstone.bulIcon");
            }
         }
         else
         {
            txt = ComponentFactory.Instance.creatComponentByStylename("gemstone.redTxt");
            bitMap = ComponentFactory.Instance.creatBitmap("gemstone.redIcon");
         }
         addChild(txt);
         addChild(bitMap);
         txt.x = bitMap.width + 10;
         txt.y = txt.y + 4;
         txt.text = param1.str;
      }
      
      public function dispose() : void
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
