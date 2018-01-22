package com.pickgliss.ui.tip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BaseTip extends Component implements ITip
   {
      
      public static const P_tipbackgound:String = "tipbackgound";
       
      
      protected var _tipbackgound:Image;
      
      protected var _tipbackgoundstyle:String;
      
      public function BaseTip()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function dispose() : void
      {
         if(_tipbackgound)
         {
            ObjectUtils.disposeObject(_tipbackgound);
         }
         _tipbackgound = null;
         super.dispose();
      }
      
      public function set tipbackgound(param1:Image) : void
      {
         if(_tipbackgound == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_tipbackgound);
         _tipbackgound = param1;
         onPropertiesChanged("tipbackgound");
      }
      
      public function set tipbackgoundstyle(param1:String) : void
      {
         if(_tipbackgoundstyle == param1)
         {
            return;
         }
         _tipbackgoundstyle = param1;
         tipbackgound = ComponentFactory.Instance.creat(_tipbackgoundstyle);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_tipbackgound)
         {
            addChild(_tipbackgound);
         }
      }
   }
}
