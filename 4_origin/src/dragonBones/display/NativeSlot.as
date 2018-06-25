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
      
      override function updateDisplay(value:Object) : void
      {
         _nativeDisplay = value as DisplayObject;
      }
      
      override function getDisplayIndex() : int
      {
         if(_nativeDisplay && _nativeDisplay.parent)
         {
            return _nativeDisplay.parent.getChildIndex(_nativeDisplay);
         }
         return -1;
      }
      
      override function addDisplayToContainer(container:Object, index:int = -1) : void
      {
         var nativeContainer:DisplayObjectContainer = container as DisplayObjectContainer;
         if(_nativeDisplay && nativeContainer)
         {
            if(index < 0)
            {
               nativeContainer.addChild(_nativeDisplay);
            }
            else
            {
               nativeContainer.addChildAt(_nativeDisplay,Math.min(index,nativeContainer.numChildren));
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
      
      override function updateDisplayVisible(value:Boolean) : void
      {
         if(_nativeDisplay)
         {
            _nativeDisplay.visible = this._parent.visible && this._visible && value;
         }
      }
      
      override function updateDisplayColor(aOffset:Number, rOffset:Number, gOffset:Number, bOffset:Number, aMultiplier:Number, rMultiplier:Number, gMultiplier:Number, bMultiplier:Number, colorChanged:Boolean = false) : void
      {
         if(_nativeDisplay)
         {
            super.updateDisplayColor(aOffset,rOffset,gOffset,bOffset,aMultiplier,rMultiplier,gMultiplier,bMultiplier,colorChanged);
            _nativeDisplay.transform.colorTransform = _colorTransform;
         }
      }
      
      override function updateDisplayBlendMode(value:String) : void
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
                                                   addr25:
                                                   _nativeDisplay.blendMode = blendMode;
                                                }
                                                addr24:
                                                §§goto(addr25);
                                             }
                                             addr23:
                                             §§goto(addr24);
                                          }
                                          addr22:
                                          §§goto(addr23);
                                       }
                                       addr21:
                                       §§goto(addr22);
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
            §§goto(addr13);
         }
      }
   }
}
