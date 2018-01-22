package dragonBones.utils
{
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public final class DBDataUtil
   {
       
      
      public function DBDataUtil()
      {
         super();
      }
      
      public static function transformArmatureData(param1:ArmatureData) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Vector.<BoneData> = param1.boneDataList;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _loc3_ = _loc4_[_loc5_];
            if(_loc3_.parent)
            {
               _loc2_ = param1.getBoneData(_loc3_.parent);
               if(_loc2_)
               {
                  _loc3_.transform.copy(_loc3_.global);
                  _loc3_.transform.divParent(_loc2_.global);
               }
            }
         }
      }
      
      public static function transformArmatureDataAnimations(param1:ArmatureData) : void
      {
         var _loc2_:Vector.<AnimationData> = param1.animationDataList;
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(!_loc3_)
            {
               break;
            }
            transformAnimationData(_loc2_[_loc3_],param1,false);
         }
      }
      
      public static function transformRelativeAnimationData(param1:AnimationData, param2:ArmatureData) : void
      {
      }
      
      public static function transformAnimationData(param1:AnimationData, param2:ArmatureData, param3:Boolean) : void
      {
         var _loc19_:* = undefined;
         var _loc14_:int = 0;
         var _loc13_:* = null;
         var _loc9_:* = null;
         var _loc15_:* = null;
         var _loc4_:* = null;
         var _loc21_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = null;
         var _loc18_:* = null;
         var _loc17_:* = null;
         var _loc6_:* = 0;
         var _loc11_:int = 0;
         var _loc16_:* = null;
         var _loc5_:Number = NaN;
         var _loc10_:* = null;
         if(!param3)
         {
            transformRelativeAnimationData(param1,param2);
            return;
         }
         var _loc20_:SkinData = param2.getSkinData(null);
         var _loc12_:Vector.<BoneData> = param2.boneDataList;
         if(_loc20_)
         {
            _loc19_ = param2.slotDataList;
         }
         _loc14_ = 0;
         while(_loc14_ < _loc12_.length)
         {
            _loc13_ = _loc12_[_loc14_];
            _loc9_ = param1.getTimeline(_loc13_.name);
            _loc15_ = param1.getSlotTimeline(_loc13_.name);
            if(!(!_loc9_ && !_loc15_))
            {
               _loc4_ = null;
               if(_loc19_)
               {
                  var _loc23_:int = 0;
                  var _loc22_:* = _loc19_;
                  for each(_loc4_ in _loc19_)
                  {
                     if(_loc4_.parent != _loc13_.name)
                     {
                        continue;
                     }
                     break;
                  }
               }
               _loc21_ = _loc9_.frameList;
               if(_loc15_)
               {
                  _loc7_ = _loc15_.frameList;
               }
               _loc8_ = null;
               _loc18_ = null;
               _loc17_ = null;
               _loc6_ = uint(_loc21_.length);
               _loc11_ = 0;
               while(_loc11_ < _loc6_)
               {
                  _loc16_ = _loc21_[_loc11_] as TransformFrame;
                  setFrameTransform(param1,param2,_loc13_,_loc16_);
                  _loc16_.transform.x = _loc16_.transform.x - _loc13_.transform.x;
                  _loc16_.transform.y = _loc16_.transform.y - _loc13_.transform.y;
                  _loc16_.transform.skewX = _loc16_.transform.skewX - _loc13_.transform.skewX;
                  _loc16_.transform.skewY = _loc16_.transform.skewY - _loc13_.transform.skewY;
                  _loc16_.transform.scaleX = _loc16_.transform.scaleX / _loc13_.transform.scaleX;
                  _loc16_.transform.scaleY = _loc16_.transform.scaleY / _loc13_.transform.scaleY;
                  if(_loc17_)
                  {
                     _loc5_ = _loc16_.transform.skewX - _loc17_.transform.skewX;
                     if(_loc17_.tweenRotate)
                     {
                        if(_loc17_.tweenRotate > 0)
                        {
                           if(_loc5_ < 0)
                           {
                              _loc16_.transform.skewX = _loc16_.transform.skewX + 3.14159265358979 * 2;
                              _loc16_.transform.skewY = _loc16_.transform.skewY + 3.14159265358979 * 2;
                           }
                           if(_loc17_.tweenRotate > 1)
                           {
                              _loc16_.transform.skewX = _loc16_.transform.skewX + 3.14159265358979 * 2 * (_loc17_.tweenRotate - 1);
                              _loc16_.transform.skewY = _loc16_.transform.skewY + 3.14159265358979 * 2 * (_loc17_.tweenRotate - 1);
                           }
                        }
                        else
                        {
                           if(_loc5_ > 0)
                           {
                              _loc16_.transform.skewX = _loc16_.transform.skewX - 3.14159265358979 * 2;
                              _loc16_.transform.skewY = _loc16_.transform.skewY - 3.14159265358979 * 2;
                           }
                           if(_loc17_.tweenRotate < 1)
                           {
                              _loc16_.transform.skewX = _loc16_.transform.skewX + 3.14159265358979 * 2 * (_loc17_.tweenRotate + 1);
                              _loc16_.transform.skewY = _loc16_.transform.skewY + 3.14159265358979 * 2 * (_loc17_.tweenRotate + 1);
                           }
                        }
                     }
                     else
                     {
                        _loc16_.transform.skewX = _loc17_.transform.skewX + TransformUtil.formatRadian(_loc16_.transform.skewX - _loc17_.transform.skewX);
                        _loc16_.transform.skewY = _loc17_.transform.skewY + TransformUtil.formatRadian(_loc16_.transform.skewY - _loc17_.transform.skewY);
                     }
                  }
                  _loc17_ = _loc16_;
                  _loc11_++;
               }
               if(_loc15_ && _loc7_)
               {
                  _loc6_ = uint(_loc7_.length);
                  _loc11_ = 0;
                  while(_loc11_ < _loc6_)
                  {
                     _loc10_ = _loc7_[_loc11_] as SlotFrame;
                     if(!_loc15_.transformed)
                     {
                        if(_loc4_)
                        {
                           _loc10_.zOrder = _loc10_.zOrder - _loc4_.zOrder;
                        }
                     }
                     _loc11_++;
                  }
                  _loc15_.transformed = true;
               }
               _loc9_.transformed = true;
            }
            _loc14_++;
         }
      }
      
      private static function setFrameTransform(param1:AnimationData, param2:ArmatureData, param3:BoneData, param4:TransformFrame) : void
      {
         var _loc12_:* = null;
         var _loc7_:* = undefined;
         var _loc5_:* = undefined;
         var _loc11_:int = 0;
         var _loc13_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc8_:* = null;
         param4.transform.copy(param4.global);
         var _loc9_:BoneData = param2.getBoneData(param3.parent);
         if(_loc9_)
         {
            _loc12_ = param1.getTimeline(_loc9_.name);
            if(_loc12_)
            {
               _loc7_ = new Vector.<TransformTimeline>();
               _loc5_ = new Vector.<BoneData>();
               while(_loc12_)
               {
                  _loc7_.push(_loc12_);
                  _loc5_.push(_loc9_);
                  _loc9_ = param2.getBoneData(_loc9_.parent);
                  if(_loc9_)
                  {
                     _loc12_ = param1.getTimeline(_loc9_.name);
                  }
                  else
                  {
                     _loc12_ = null;
                  }
               }
               _loc11_ = _loc7_.length;
               _loc6_ = new Matrix();
               _loc10_ = new DBTransform();
               _loc8_ = new Matrix();
               while(true)
               {
                  _loc11_--;
                  if(!_loc11_)
                  {
                     break;
                  }
                  _loc12_ = _loc7_[_loc11_];
                  _loc9_ = _loc5_[_loc11_];
                  getTimelineTransform(_loc12_,param4.position,_loc10_,!_loc13_);
                  if(!_loc13_)
                  {
                     _loc13_ = new DBTransform();
                     _loc13_.copy(_loc10_);
                  }
                  else
                  {
                     _loc10_.x = _loc10_.x + (_loc12_.originTransform.x + _loc9_.transform.x);
                     _loc10_.y = _loc10_.y + (_loc12_.originTransform.y + _loc9_.transform.y);
                     _loc10_.skewX = _loc10_.skewX + (_loc12_.originTransform.skewX + _loc9_.transform.skewX);
                     _loc10_.skewY = _loc10_.skewY + (_loc12_.originTransform.skewY + _loc9_.transform.skewY);
                     _loc10_.scaleX = _loc10_.scaleX * (_loc12_.originTransform.scaleX * _loc9_.transform.scaleX);
                     _loc10_.scaleY = _loc10_.scaleY * (_loc12_.originTransform.scaleY * _loc9_.transform.scaleY);
                     TransformUtil.transformToMatrix(_loc10_,_loc8_);
                     _loc8_.concat(_loc6_);
                     TransformUtil.matrixToTransform(_loc8_,_loc13_,_loc10_.scaleX * _loc13_.scaleX >= 0,_loc10_.scaleY * _loc13_.scaleY >= 0);
                  }
                  TransformUtil.transformToMatrix(_loc13_,_loc6_);
               }
               param4.transform.divParent(_loc13_);
            }
         }
      }
      
      private static function getTimelineTransform(param1:TransformTimeline, param2:int, param3:DBTransform, param4:Boolean) : void
      {
         var _loc10_:* = null;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         var _loc9_:Vector.<Frame> = param1.frameList;
         var _loc12_:int = _loc9_.length;
         while(true)
         {
            _loc12_--;
            if(_loc12_)
            {
               _loc10_ = _loc9_[_loc12_] as TransformFrame;
               if(_loc10_.position <= param2 && _loc10_.position + _loc10_.duration > param2)
               {
                  if(_loc12_ == _loc9_.length - 1 || param2 == _loc10_.position)
                  {
                     param3.copy(!!param4?_loc10_.global:_loc10_.transform);
                  }
                  else
                  {
                     _loc7_ = _loc10_.tweenEasing;
                     _loc5_ = (param2 - _loc10_.position) / _loc10_.duration;
                     if(_loc7_ && _loc7_ != 10)
                     {
                        _loc5_ = MathUtil.getEaseValue(_loc5_,_loc7_);
                     }
                     _loc6_ = _loc9_[_loc12_ + 1] as TransformFrame;
                     _loc11_ = !!param4?_loc10_.global:_loc10_.transform;
                     _loc8_ = !!param4?_loc6_.global:_loc6_.transform;
                     param3.x = _loc11_.x + (_loc8_.x - _loc11_.x) * _loc5_;
                     param3.y = _loc11_.y + (_loc8_.y - _loc11_.y) * _loc5_;
                     param3.skewX = TransformUtil.formatRadian(_loc11_.skewX + (_loc8_.skewX - _loc11_.skewX) * _loc5_);
                     param3.skewY = TransformUtil.formatRadian(_loc11_.skewY + (_loc8_.skewY - _loc11_.skewY) * _loc5_);
                     param3.scaleX = _loc11_.scaleX + (_loc8_.scaleX - _loc11_.scaleX) * _loc5_;
                     param3.scaleY = _loc11_.scaleY + (_loc8_.scaleY - _loc11_.scaleY) * _loc5_;
                  }
                  break;
               }
               continue;
            }
            break;
         }
      }
      
      public static function addHideTimeline(param1:AnimationData, param2:ArmatureData) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:Vector.<BoneData> = param2.boneDataList;
         var _loc6_:int = _loc5_.length;
         while(true)
         {
            _loc6_--;
            if(!_loc6_)
            {
               break;
            }
            _loc4_ = _loc5_[_loc6_];
            _loc3_ = _loc4_.name;
            if(!param1.getTimeline(_loc3_))
            {
               if(param1.hideTimelineNameMap.indexOf(_loc3_) < 0)
               {
                  param1.hideTimelineNameMap.fixed = false;
                  param1.hideTimelineNameMap.push(_loc3_);
                  param1.hideTimelineNameMap.fixed = true;
               }
            }
         }
      }
   }
}
