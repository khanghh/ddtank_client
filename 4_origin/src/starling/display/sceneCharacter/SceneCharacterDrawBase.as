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
      
      public function setup(synthesis:SceneCharacterSynthesisBase, actionSet:SceneCharacterActionSet, actionPointSet:SceneCharacterActionPointSet) : void
      {
         _isUpdate = false;
         _synthesis = synthesis;
         _actionSet = actionSet;
         _actionPointSet = actionPointSet;
         initialize();
      }
      
      public function update() : void
      {
         var i:int = 0;
         var type:* = null;
         var index:int = 0;
         var data:* = null;
         var texture:* = null;
         var pos:* = null;
         var pointItem:* = null;
         var posIndex:int = 0;
         if(!_isUpdate)
         {
            return;
         }
         _headImage.visible = false;
         _bodyImage.visible = false;
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
            data = _synthesis.getFramesObject(type);
            if(index >= actionList[i].frames.length)
            {
               texture = data.frams[actionList[i].frames[actionList[i].frames.length - 1]];
            }
            else
            {
               texture = data.frams[actionList[i].frames[index]];
            }
            pointItem = _actionPointSet.getItem(type);
            if(pointItem)
            {
               posIndex = index % pointItem.amount;
               pos = pointItem.getPoint(posIndex);
            }
            _frames[type] = index + 1;
            drawCharacterItem(data.sortOrder,texture,data.w,data.h,pos);
            i++;
         }
      }
      
      protected function drawCharacterItem(sortOrder:int, texture:Texture, w:Number, h:Number, $pos:Point = null) : void
      {
         var pos:Point = $pos || new Point();
         var image:Image = getCharacterItem(sortOrder);
         if(image == null)
         {
            return;
         }
         image.texture = texture;
         image.readjustSize();
         PositionUtils.setPos(image,pos);
         image.visible = true;
      }
      
      protected function getCharacterItem(sortOrder:int) : Image
      {
         if(sortOrder == 0)
         {
            return _headImage;
         }
         if(sortOrder == 4)
         {
            return _bodyImage;
         }
         return null;
      }
      
      protected function sortOn(a:Object, b:Object) : Number
      {
         var result:int = 0;
         var dic:int = 1;
         if(_state == "standBack" || _state == "walkBack")
         {
            dic = -1;
         }
         if(a.sortOrder < b.sortOrder)
         {
            result = -1;
         }
         else if(a.sortOrder > b.sortOrder)
         {
            result = 1;
         }
         return result * dic;
      }
      
      public function set state(value:String) : void
      {
         _state = value;
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
