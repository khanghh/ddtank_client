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
      
      public static function creatAndAdd(param1:String = "", param2:DisplayObjectContainer = null) : *
      {
         var _loc3_:DisplayObject = ComponentFactory.Instance.creat(param1);
         if(param2 == null)
         {
            return _loc3_;
         }
         return param2.addChild(_loc3_);
      }
      
      public static function creatTextAndAdd(param1:String = "", param2:String = "", param3:DisplayObjectContainer = null) : *
      {
         var _loc4_:TextField = ComponentFactory.Instance.creat(param1);
         _loc4_.text = param2;
         if(param3 == null)
         {
            return _loc4_;
         }
         return param3.addChild(_loc4_);
      }
   }
}
