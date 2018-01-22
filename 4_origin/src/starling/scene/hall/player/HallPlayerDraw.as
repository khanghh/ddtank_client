package starling.scene.hall.player
{
   import ddt.data.player.PlayerInfo;
   import flash.geom.Point;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.Image;
   import starling.display.sceneCharacter.SceneCharacterActionItem;
   import starling.display.sceneCharacter.SceneCharacterActionPointItem;
   import starling.display.sceneCharacter.SceneCharacterDrawBase;
   import starling.textures.Texture;
   
   public class HallPlayerDraw extends SceneCharacterDrawBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      protected var _bodyBackImage:Image;
      
      protected var _mountImage:Image;
      
      protected var _mountSImage:Image;
      
      public function HallPlayerDraw(param1:PlayerInfo)
      {
         super();
         _playerInfo = param1;
      }
      
      override protected function initialize() : void
      {
         if(!_headImage)
         {
            _headImage = StarlingMain.instance.createImage();
         }
         addChild(_headImage);
         if(!_bodyBackImage)
         {
            _bodyBackImage = StarlingMain.instance.createImage();
         }
         addChild(_bodyBackImage);
         if(!_mountImage)
         {
            _mountImage = StarlingMain.instance.createImage();
         }
         addChild(_mountImage);
         if(!_mountSImage)
         {
            _mountSImage = StarlingMain.instance.createImage();
         }
         addChild(_mountSImage);
         if(!_bodyImage)
         {
            _bodyImage = StarlingMain.instance.createImage();
         }
         addChild(_bodyImage);
         _frames = new DictionaryData();
         _isUpdate = true;
      }
      
      override public function update() : void
      {
         if(!_isUpdate)
         {
            return;
         }
         _headImage.visible = false;
         _bodyImage.visible = false;
         _bodyBackImage.visible = false;
         _mountImage.visible = false;
         _mountSImage.visible = false;
         if(_state == "standRide" || "walkRide")
         {
            updateMounts();
         }
         else
         {
            super.update();
         }
      }
      
      private function updateMounts() : void
      {
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc9_:* = null;
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc8_:Vector.<SceneCharacterActionItem> = _actionSet.getItems(_state);
         _loc10_ = 0;
         while(_loc10_ < _loc8_.length)
         {
            _loc6_ = _loc8_[_loc10_].type;
            _loc2_ = _frames[_loc6_];
            if(_loc2_ >= _loc8_[_loc10_].total)
            {
               if(_loc8_[_loc10_].repeat)
               {
                  _loc2_ = 0;
               }
               else
               {
                  _loc2_ = _loc8_[_loc10_].total - 1;
               }
            }
            _loc5_ = getImage(_loc6_);
            if(_loc5_ != null)
            {
               if(_loc2_ >= _loc8_[_loc10_].frames.length)
               {
                  _loc4_ = _loc5_.frams[_loc8_[_loc10_].frames[_loc8_[_loc10_].frames.length - 1]];
               }
               else
               {
                  _loc4_ = _loc5_.frams[_loc8_[_loc10_].frames[_loc2_]];
               }
               if(_loc4_ != null)
               {
                  _loc3_ = _loc5_.sortOrder;
                  if(_loc8_[_loc10_].state == "standBack" || _loc8_[_loc10_].state == "walkBack")
                  {
                     if(_loc6_ == "head")
                     {
                        _loc3_ = 1;
                     }
                     if(_loc6_ == "body")
                     {
                        _loc3_ = 0;
                     }
                  }
                  else if(_loc6_ == "bodyBack")
                  {
                     _loc3_ = 1;
                  }
                  else if(_loc6_ == "mountSaddle")
                  {
                     _loc3_ = 3;
                  }
                  _loc1_ = _actionPointSet.getItem(_loc6_);
                  if(_loc1_)
                  {
                     _loc7_ = _loc2_ % _loc1_.amount;
                     _loc9_ = _loc1_.getPoint(_loc7_);
                  }
                  _frames[_loc6_] = _loc2_ + 1;
                  drawCharacterItem(_loc3_,_loc4_,_loc5_.w,_loc5_.h,_loc9_);
               }
            }
            _loc10_++;
         }
      }
      
      override protected function getCharacterItem(param1:int) : Image
      {
         if(param1 == 1)
         {
            return _bodyBackImage;
         }
         if(param1 == 2)
         {
            return _mountImage;
         }
         if(param1 == 3)
         {
            return _mountSImage;
         }
         return super.getCharacterItem(param1);
      }
      
      private function getImage(param1:String) : Object
      {
         var _loc2_:* = param1;
         if("head" !== _loc2_)
         {
            if("body" !== _loc2_)
            {
               if("bodyBack" !== _loc2_)
               {
                  if("mount" !== _loc2_)
                  {
                     if("mountSaddle" !== _loc2_)
                     {
                        return null;
                     }
                  }
                  return _synthesis.getFramesObject("mount");
               }
            }
            return _synthesis.getFramesObject("body");
         }
         return _synthesis.getFramesObject("head");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _playerInfo = null;
         _bodyBackImage = null;
         _mountImage = null;
         _mountSImage = null;
      }
   }
}
