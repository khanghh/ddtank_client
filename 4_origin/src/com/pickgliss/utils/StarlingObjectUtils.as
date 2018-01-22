package com.pickgliss.utils
{
   import bones.display.BoneMovieFastStarling;
   import bones.display.IBoneMovie;
   import com.pickgliss.ui.core.Disposeable;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class StarlingObjectUtils
   {
       
      
      public function StarlingObjectUtils()
      {
         super();
      }
      
      public static function disposeObject(param1:Object, param2:Boolean = false) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is Image)
         {
            _loc5_ = param1 as Image;
            if(_loc5_.parent)
            {
               _loc5_.parent.removeChild(_loc5_);
            }
            if(param2)
            {
               _loc5_.texture.dispose();
            }
            _loc5_.dispose();
         }
         else if(param1 is DisplayObject)
         {
            _loc4_ = param1 as DisplayObject;
            if(_loc4_.parent)
            {
               _loc4_.parent.removeChild(_loc4_);
            }
            _loc4_.dispose();
         }
         else if(param1 is Texture)
         {
            _loc3_ = param1 as Texture;
            _loc3_.dispose();
         }
         else if(param1 is Disposeable)
         {
            Disposeable(param1).dispose();
         }
      }
      
      public static function disposeAllChildren(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            _loc3_ = param1.getChildAt(0);
            disposeObject(_loc3_,param2);
         }
      }
      
      public static function removeObject(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IBoneMovie)
         {
            (param1 as IBoneMovie).stop();
         }
         if(param1 is BoneMovieFastStarling)
         {
            (param1 as BoneMovieFastStarling).stop();
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function removeChildAllChildren(param1:DisplayObjectContainer, param2:Boolean = true) : void
      {
         if(param1 == null)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0,param2);
         }
      }
   }
}
