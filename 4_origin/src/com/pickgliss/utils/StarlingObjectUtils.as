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
      
      public static function disposeObject(target:Object, disposeTexture:Boolean = false) : void
      {
         var targetImage:* = null;
         var targetDisplay:* = null;
         var targetTexture:* = null;
         if(target == null)
         {
            return;
         }
         if(target is Image)
         {
            targetImage = target as Image;
            if(targetImage.parent)
            {
               targetImage.parent.removeChild(targetImage);
            }
            if(disposeTexture)
            {
               targetImage.texture.dispose();
            }
            targetImage.dispose();
         }
         else if(target is DisplayObject)
         {
            targetDisplay = target as DisplayObject;
            if(targetDisplay.parent)
            {
               targetDisplay.parent.removeChild(targetDisplay);
            }
            targetDisplay.dispose();
         }
         else if(target is Texture)
         {
            targetTexture = target as Texture;
            targetTexture.dispose();
         }
         else if(target is Disposeable)
         {
            Disposeable(target).dispose();
         }
      }
      
      public static function disposeAllChildren(container:DisplayObjectContainer, disposeTexture:Boolean = false) : void
      {
         var child:* = null;
         if(container == null)
         {
            return;
         }
         while(container.numChildren > 0)
         {
            child = container.getChildAt(0);
            disposeObject(child,disposeTexture);
         }
      }
      
      public static function removeObject(target:DisplayObject) : void
      {
         if(target == null)
         {
            return;
         }
         if(target is IBoneMovie)
         {
            (target as IBoneMovie).stop();
         }
         if(target is BoneMovieFastStarling)
         {
            (target as BoneMovieFastStarling).stop();
         }
         if(target.parent)
         {
            target.parent.removeChild(target);
         }
      }
      
      public static function removeChildAllChildren(container:DisplayObjectContainer, isDispose:Boolean = true) : void
      {
         if(container == null)
         {
            return;
         }
         while(container.numChildren > 0)
         {
            container.removeChildAt(0,isDispose);
         }
      }
   }
}
