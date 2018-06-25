package com.pickgliss.ui
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   
   public class UICreatShortcut
   {
       
      
      public function UICreatShortcut()
      {
         super();
      }
      
      public static function creatAndAdd(stylename:String = "", container:DisplayObjectContainer = null) : *
      {
         var component:DisplayObject = ComponentFactory.Instance.creat(stylename);
         if(container == null)
         {
            return component;
         }
         return container.addChild(component);
      }
      
      public static function creatTextAndAdd(stylename:String = "", label:String = "", container:DisplayObjectContainer = null) : *
      {
         var component:TextField = ComponentFactory.Instance.creat(stylename);
         component.text = label;
         if(container == null)
         {
            return component;
         }
         return container.addChild(component);
      }
   }
}
