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
      
      public function HallPlayerDraw(playerInfo:PlayerInfo)
      {
         super();
         _playerInfo = playerInfo;
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
         var i:int = 0;
         var type:* = null;
         var index:int = 0;
         var data:* = null;
         var texture:* = null;
         var sortOrder:int = 0;
         var pos:* = null;
         var pointItem:* = null;
         var posIndex:int = 0;
         var actionList:Vector.<SceneCharacterActionItem> = _actionSet.getItems(_state);
         for(i = 0; i < actionList.length; )
         {
            type = actionList[i].type;
            index = _frames[type];
            if(index >= actionList[i].total)
            {
               if(actionList[i].repeat)
               {
                  index = 0;
               }
               else
               {
                  index = actionList[i].total - 1;
               }
            }
            data = getImage(type);
            if(data != null)
            {
               if(index >= actionList[i].frames.length)
               {
                  texture = data.frams[actionList[i].frames[actionList[i].frames.length - 1]];
               }
               else
               {
                  texture = data.frams[actionList[i].frames[index]];
               }
               if(texture != null)
               {
                  sortOrder = data.sortOrder;
                  if(actionList[i].state == "standBack" || actionList[i].state == "walkBack")
                  {
                     if(type == "head")
                     {
                        sortOrder = 1;
                     }
                     if(type == "body")
                     {
                        sortOrder = 0;
                     }
                  }
                  else if(type == "bodyBack")
                  {
                     sortOrder = 1;
                  }
                  else if(type == "mountSaddle")
                  {
                     sortOrder = 3;
                  }
                  pointItem = _actionPointSet.getItem(type);
                  if(pointItem)
                  {
                     posIndex = index % pointItem.amount;
                     pos = pointItem.getPoint(posIndex);
                  }
                  _frames[type] = index + 1;
                  drawCharacterItem(sortOrder,texture,data.w,data.h,pos);
               }
            }
            i++;
         }
      }
      
      override protected function getCharacterItem(sortOrder:int) : Image
      {
         if(sortOrder == 1)
         {
            return _bodyBackImage;
         }
         if(sortOrder == 2)
         {
            return _mountImage;
         }
         if(sortOrder == 3)
         {
            return _mountSImage;
         }
         return super.getCharacterItem(sortOrder);
      }
      
      private function getImage(type:String) : Object
      {
         var _loc2_:* = type;
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
