package dragonBones.display
{
   import dragonBones.Slot;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class NativeSlot extends Slot
   {
       
      
      private var _nativeDisplay:DisplayObject;
      
      public function NativeSlot()
      {
         super(this);
         _nativeDisplay = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _nativeDisplay = null;
      }
      
      override function updateDisplay(param1:Object) : void
      {
         _nativeDisplay = param1 as DisplayObject;
      }
      
      override function getDisplayIndex() : int
      {
         if(_nativeDisplay && _nativeDisplay.parent)
         {
            return _nativeDisplay.parent.getChildIndex(_nativeDisplay);
         }
         return -1;
      }
      
      override function addDisplayToContainer(param1:Object, param2:int = -1) : void
      {
         var _loc3_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_nativeDisplay && _loc3_)
         {
            if(param2 < 0)
            {
               _loc3_.addChild(_nativeDisplay);
            }
            else
            {
               _loc3_.addChildAt(_nativeDisplay,Math.min(param2,_loc3_.numChildren));
            }
         }
      }
      
      override function removeDisplayFromContainer() : void
      {
         if(_nativeDisplay && _nativeDisplay.parent)
         {
            _nativeDisplay.parent.removeChild(_nativeDisplay);
         }
      }
      
      override function updateTransform() : void
      {
         if(_nativeDisplay)
         {
            _nativeDisplay.transform.matrix = this._globalTransformMatrix;
         }
      }
      
      override function updateDisplayVisible(param1:Boolean) : void
      {
         if(_nativeDisplay)
         {
            _nativeDisplay.visible = this._parent.visible && this._visible && param1;
         }
      }
      
      override function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void
      {
         if(_nativeDisplay)
         {
            super.updateDisplayColor(param1,param2,param3,param4,param5,param6,param7,param8,param9);
            _nativeDisplay.transform.colorTransform = _colorTransform;
         }
      }
      
      override function updateDisplayBlendMode(param1:String) : void
      {
         if(_nativeDisplay)
         {
            var _loc2_:* = blendMode;
            if("add" !== _loc2_)
            {
               if("alpha" !== _loc2_)
               {
                  if("darken" !== _loc2_)
                  {
                     if("difference" !== _loc2_)
                     {
                        if("erase" !== _loc2_)
                        {
                           if("hardlight" !== _loc2_)
                           {
                              if("invert" !== _loc2_)
                              {
                                 if("layer" !== _loc2_)
                                 {
                                    if("lighten" !== _loc2_)
                                    {
                                       if("multiply" !== _loc2_)
                                       {
                                          if("normal" !== _loc2_)
                                          {
                                             if("overlay" !== _loc2_)
                                             {
                                                if("screen" !== _loc2_)
                                                {
                                                   if("shader" !== _loc2_)
                                                   {
                                                      if("subtract" !== _loc2_)
                                                      {
                                                      }
                                                   }
                                                   addr21:
                                                   _nativeDisplay.blendMode = blendMode;
                                                }
                                                addr20:
                                                §§goto(addr21);
                                             }
                                             addr19:
                                             §§goto(addr20);
                                          }
                                          addr18:
                                          §§goto(addr19);
                                       }
                                       addr17:
                                       §§goto(addr18);
                                    }
                                    addr16:
                                    §§goto(addr17);
                                 }
                                 addr15:
                                 §§goto(addr16);
                              }
                              addr14:
                              §§goto(addr15);
                           }
                           addr13:
                           §§goto(addr14);
                        }
                        addr12:
                        §§goto(addr13);
                     }
                     addr11:
                     §§goto(addr12);
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            §§goto(addr9);
         }
      }
   }
}
