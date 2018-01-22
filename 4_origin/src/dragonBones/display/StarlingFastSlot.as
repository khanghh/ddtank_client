package dragonBones.display
{
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import flash.geom.Matrix;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   
   public class StarlingFastSlot extends FastSlot
   {
       
      
      private var _starlingDisplay:DisplayObject;
      
      public var updateMatrix:Boolean;
      
      public function StarlingFastSlot()
      {
         super(this);
         _starlingDisplay = null;
         updateMatrix = false;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = this._displayList;
         for each(var _loc1_ in this._displayList)
         {
            if(_loc1_ is FastArmature)
            {
               (_loc1_ as FastArmature).dispose();
            }
            else if(_loc1_ is DisplayObject)
            {
               (_loc1_ as DisplayObject).dispose();
            }
         }
         super.dispose();
         _starlingDisplay = null;
      }
      
      override function updateDisplay(param1:Object) : void
      {
         _starlingDisplay = param1 as DisplayObject;
      }
      
      override function getDisplayIndex() : int
      {
         if(_starlingDisplay && _starlingDisplay.parent)
         {
            return _starlingDisplay.parent.getChildIndex(_starlingDisplay);
         }
         return -1;
      }
      
      override function addDisplayToContainer(param1:Object, param2:int = -1) : void
      {
         var _loc3_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_starlingDisplay && _loc3_)
         {
            if(param2 < 0)
            {
               _loc3_.addChild(_starlingDisplay);
            }
            else
            {
               _loc3_.addChildAt(_starlingDisplay,Math.min(param2,_loc3_.numChildren));
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
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         if(_starlingDisplay)
         {
            _loc1_ = _starlingDisplay.pivotX;
            _loc2_ = _starlingDisplay.pivotY;
            if(updateMatrix)
            {
               _starlingDisplay.transformationMatrix = _globalTransformMatrix;
               if(_loc1_ || Number(_loc2_))
               {
                  _starlingDisplay.pivotX = _loc1_;
                  _starlingDisplay.pivotY = _loc2_;
               }
            }
            else
            {
               _loc3_ = _starlingDisplay.transformationMatrix;
               _loc3_.a = _globalTransformMatrix.a;
               _loc3_.b = _globalTransformMatrix.b;
               _loc3_.c = _globalTransformMatrix.c;
               _loc3_.d = _globalTransformMatrix.d;
               if(_loc1_ || Number(_loc2_))
               {
                  _loc3_.tx = _globalTransformMatrix.tx - (_loc3_.a * _loc1_ + _loc3_.c * _loc2_);
                  _loc3_.ty = _globalTransformMatrix.ty - (_loc3_.b * _loc1_ + _loc3_.d * _loc2_);
               }
               else
               {
                  _loc3_.tx = _globalTransformMatrix.tx;
                  _loc3_.ty = _globalTransformMatrix.ty;
               }
            }
         }
      }
      
      override function updateDisplayVisible(param1:Boolean) : void
      {
      }
      
      override function updateDisplayColor(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : void
      {
         if(_starlingDisplay)
         {
            super.updateDisplayColor(param1,param2,param3,param4,param5,param6,param7,param8,param9);
            _starlingDisplay.alpha = param5;
            if(_starlingDisplay is Quad)
            {
               (_starlingDisplay as Quad).color = (uint(param6 * 255) << 16) + (uint(param7 * 255) << 8) + uint(param8 * 255);
            }
         }
      }
      
      override function updateDisplayBlendMode(param1:String) : void
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
                                                                        addr52:
                                                                     }
                                                                     addr51:
                                                                     §§goto(addr52);
                                                                  }
                                                                  addr50:
                                                                  §§goto(addr51);
                                                               }
                                                               addr49:
                                                               §§goto(addr50);
                                                            }
                                                            addr48:
                                                            §§goto(addr49);
                                                         }
                                                         addr47:
                                                         §§goto(addr48);
                                                      }
                                                      addr46:
                                                      §§goto(addr47);
                                                   }
                                                   addr45:
                                                   §§goto(addr46);
                                                }
                                                §§goto(addr45);
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
                           addr13:
                           _starlingDisplay.blendMode = blendMode;
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
