package starling.display.sceneCharacter
{
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class SceneCharacterDrawBase extends Sprite
   {
      
      public static const S_HEAD:int = 0;
      
      public static const S_BODY_BACK:int = 1;
      
      public static const S_MOUNT:int = 2;
      
      public static const S_MOUNT_S:int = 3;
      
      public static const S_BODY:int = 4;
       
      
      protected var _synthesis:SceneCharacterSynthesisBase;
      
      protected var _actionSet:SceneCharacterActionSet;
      
      protected var _actionPointSet:SceneCharacterActionPointSet;
      
      protected var _state:String;
      
      protected var _frames:DictionaryData;
      
      protected var _isUpdate:Boolean;
      
      protected var _headImage:Image;
      
      protected var _bodyImage:Image;
      
      public function SceneCharacterDrawBase()
      {
         super();
      }
      
      protected function initialize() : void
      {
         if(!_headImage)
         {
            _headImage = StarlingMain.instance.createImage();
         }
         addChild(_headImage);
         if(!_bodyImage)
         {
            _bodyImage = StarlingMain.instance.createImage();
         }
         addChild(_bodyImage);
         _frames = new DictionaryData();
         _isUpdate = true;
      }
      
      public function setup(param1:SceneCharacterSynthesisBase, param2:SceneCharacterActionSet, param3:SceneCharacterActionPointSet) : void
      {
         _isUpdate = false;
         _synthesis = param1;
         _actionSet = param2;
         _actionPointSet = param3;
         initialize();
      }
      
      public function update() : void
      {
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         if(!_isUpdate)
         {
            return;
         }
         _headImage.visible = false;
         _bodyImage.visible = false;
         var _loc7_:Vector.<SceneCharacterActionItem> = _actionSet.getItems(_state);
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc5_ = _loc7_[_loc9_].type;
            _loc2_ = _frames[_loc5_];
            if(_loc2_ >= _loc7_[_loc9_].total)
            {
               if(_loc7_[_loc9_].repeat)
               {
                  _loc2_ = 0;
               }
               else
               {
                  _loc2_ = _loc7_[_loc9_].total - 1;
               }
            }
            _loc4_ = _synthesis.getFramesObject(_loc5_);
            if(_loc2_ >= _loc7_[_loc9_].frames.length)
            {
               _loc3_ = _loc4_.frams[_loc7_[_loc9_].frames[_loc7_[_loc9_].frames.length - 1]];
            }
            else
            {
               _loc3_ = _loc4_.frams[_loc7_[_loc9_].frames[_loc2_]];
            }
            _loc1_ = _actionPointSet.getItem(_loc5_);
            if(_loc1_)
            {
               _loc6_ = _loc2_ % _loc1_.amount;
               _loc8_ = _loc1_.getPoint(_loc6_);
            }
            _frames[_loc5_] = _loc2_ + 1;
            drawCharacterItem(_loc4_.sortOrder,_loc3_,_loc4_.w,_loc4_.h,_loc8_);
            _loc9_++;
         }
      }
      
      protected function drawCharacterItem(param1:int, param2:Texture, param3:Number, param4:Number, param5:Point = null) : void
      {
         var _loc7_:Point = param5 || new Point();
         var _loc6_:Image = getCharacterItem(param1);
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.texture = param2;
         _loc6_.readjustSize();
         PositionUtils.setPos(_loc6_,_loc7_);
         _loc6_.visible = true;
      }
      
      protected function getCharacterItem(param1:int) : Image
      {
         if(param1 == 0)
         {
            return _headImage;
         }
         if(param1 == 4)
         {
            return _bodyImage;
         }
         return null;
      }
      
      protected function sortOn(param1:Object, param2:Object) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 1;
         if(_state == "standBack" || _state == "walkBack")
         {
            _loc4_ = -1;
         }
         if(param1.sortOrder < param2.sortOrder)
         {
            _loc3_ = -1;
         }
         else if(param1.sortOrder > param2.sortOrder)
         {
            _loc3_ = 1;
         }
         return _loc3_ * _loc4_;
      }
      
      public function set state(param1:String) : void
      {
         _state = param1;
         reset();
      }
      
      public function reset() : void
      {
         _frames && _frames.clear();
         _frames = new DictionaryData();
      }
      
      override public function dispose() : void
      {
         _isUpdate = false;
         while(this.numChildren > 0 && this.getChildAt(0))
         {
            removeChildAt(0,true);
         }
         _headImage = null;
         _bodyImage = null;
         _synthesis = null;
         _actionSet = null;
         _actionPointSet = null;
         _frames.clear();
         _frames = null;
         super.dispose();
      }
   }
}
