package dragonBones.display
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import flash.geom.Matrix;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   
   public class StarlingSlot extends Slot
   {
       
      
      private var _starlingDisplay:DisplayObject;
      
      public var updateMatrix:Boolean;
      
      public function StarlingSlot()
      {
         super(this);
         _starlingDisplay = null;
         updateMatrix = false;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = this._displayList;
         for each(var content in this._displayList)
         {
            if(content is Armature)
            {
               (content as Armature).dispose();
            }
            else if(content is DisplayObject)
            {
               (content as DisplayObject).dispose();
            }
         }
         super.dispose();
         _starlingDisplay = null;
      }
      
      override function updateDisplay(value:Object) : void
      {
         _starlingDisplay = value as DisplayObject;
      }
      
      override function getDisplayIndex() : int
      {
         if(_starlingDisplay && _starlingDisplay.parent)
         {
            return _starlingDisplay.parent.getChildIndex(_starlingDisplay);
         }
         return -1;
      }
      
      override function addDisplayToContainer(container:Object, index:int = -1) : void
      {
         var starlingContainer:DisplayObjectContainer = container as DisplayObjectContainer;
         if(_starlingDisplay && starlingContainer)
         {
            if(index < 0)
            {
               starlingContainer.addChild(_starlingDisplay);
            }
            else
            {
               starlingContainer.addChildAt(_starlingDisplay,Math.min(index,starlingContainer.numChildren));
            }
         }
      }
      
      override function removeDisplayFromContainer() : void
      {
         if(_starlingDisplay && _starlingDisplay.parent)
         {
            _starlingDisplay.parent.removeChild(_starlingDisplay);
         }
      }
      
      override function updateTransform() : void
      {
         var pivotX:Number = NaN;
         var pivotY:Number = NaN;
         var displayMatrix:* = null;
         if(_starlingDisplay)
         {
            pivotX = _starlingDisplay.pivotX;
            pivotY = _starlingDisplay.pivotY;
            if(updateMatrix)
            {
               _starlingDisplay.transformationMatrix = _globalTransformMatrix;
               if(pivotX || Number(pivotY))
               {
                  _starlingDisplay.pivotX = pivotX;
                  _starlingDisplay.pivotY = pivotY;
               }
            }
            else
            {
               displayMatrix = _starlingDisplay.transformationMatrix;
               displayMatrix.a = _globalTransformMatrix.a;
               displayMatrix.b = _globalTransformMatrix.b;
               displayMatrix.c = _globalTransformMatrix.c;
               displayMatrix.d = _globalTransformMatrix.d;
               if(pivotX || Number(pivotY))
               {
                  displayMatrix.tx = _globalTransformMatrix.tx - (displayMatrix.a * pivotX + displayMatrix.c * pivotY);
                  displayMatrix.ty = _globalTransformMatrix.ty - (displayMatrix.b * pivotX + displayMatrix.d * pivotY);
               }
               else
               {
                  displayMatrix.tx = _globalTransformMatrix.tx;
                  displayMatrix.ty = _globalTransformMatrix.ty;
               }
            }
         }
      }
      
      override function updateDisplayVisible(value:Boolean) : void
      {
         if(_starlingDisplay && this._parent)
         {
            _starlingDisplay.visible = this._parent.visible && this._visible && value;
         }
      }
      
      override function updateDisplayColor(aOffset:Number, rOffset:Number, gOffset:Number, bOffset:Number, aMultiplier:Number, rMultiplier:Number, gMultiplier:Number, bMultiplier:Number, colorChanged:Boolean = false) : void
      {
         if(_starlingDisplay)
         {
            super.updateDisplayColor(aOffset,rOffset,gOffset,bOffset,aMultiplier,rMultiplier,gMultiplier,bMultiplier,colorChanged);
            _starlingDisplay.alpha = aMultiplier;
            if(_starlingDisplay is Quad)
            {
               (_starlingDisplay as Quad).color = (uint(rMultiplier * 255) << 16) + (uint(gMultiplier * 255) << 8) + uint(bMultiplier * 255);
            }
         }
      }
      
      override function updateDisplayBlendMode(value:String) : void
      {
         if(_starlingDisplay)
         {
            var _loc2_:* = blendMode;
            if("none" !== _loc2_)
            {
               if("auto" !== _loc2_)
               {
                  if("add" !== _loc2_)
                  {
                     if("erase" !== _loc2_)
                     {
                        if("multiply" !== _loc2_)
                        {
                           if("normal" !== _loc2_)
                           {
                              if("screen" !== _loc2_)
                              {
                                 if("add" !== _loc2_)
                                 {
                                    if("erase" !== _loc2_)
                                    {
                                       if("multiply" !== _loc2_)
                                       {
                                          if("normal" !== _loc2_)
                                          {
                                             if("screen" !== _loc2_)
                                             {
                                                if("alpha" !== _loc2_)
                                                {
                                                   if("darken" !== _loc2_)
                                                   {
                                                      if("difference" !== _loc2_)
                                                      {
                                                         if("hardlight" !== _loc2_)
                                                         {
                                                            if("invert" !== _loc2_)
                                                            {
                                                               if("layer" !== _loc2_)
                                                               {
                                                                  if("lighten" !== _loc2_)
                                                                  {
                                                                     if("overlay" !== _loc2_)
                                                                     {
                                                                        if("shader" !== _loc2_)
                                                                        {
                                                                           if("subtract" !== _loc2_)
                                                                           {
                                                                           }
                                                                        }
                                                                        addr62:
                                                                     }
                                                                     addr61:
                                                                     §§goto(addr62);
                                                                  }
                                                                  addr60:
                                                                  §§goto(addr61);
                                                               }
                                                               addr59:
                                                               §§goto(addr60);
                                                            }
                                                            addr58:
                                                            §§goto(addr59);
                                                         }
                                                         addr57:
                                                         §§goto(addr58);
                                                      }
                                                      addr56:
                                                      §§goto(addr57);
                                                   }
                                                   addr55:
                                                   §§goto(addr56);
                                                }
                                                §§goto(addr55);
                                             }
                                             else
                                             {
                                                _starlingDisplay.blendMode = "screen";
                                             }
                                          }
                                          else
                                          {
                                             _starlingDisplay.blendMode = "normal";
                                          }
                                       }
                                       else
                                       {
                                          _starlingDisplay.blendMode = "multiply";
                                       }
                                    }
                                    else
                                    {
                                       _starlingDisplay.blendMode = "erase";
                                    }
                                 }
                                 else
                                 {
                                    _starlingDisplay.blendMode = "add";
                                 }
                              }
                           }
                           addr17:
                           _starlingDisplay.blendMode = blendMode;
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
