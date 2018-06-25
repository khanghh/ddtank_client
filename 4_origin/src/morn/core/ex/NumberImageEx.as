package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import morn.core.components.Clip;
   import morn.core.components.Component;
   
   public class NumberImageEx extends Component
   {
      
      public static const LEFT:String = "left";
      
      public static const CENTER:String = "center";
      
      public static const RIGHT:String = "right";
       
      
      private var _countList:Vector.<Clip>;
      
      private var _countSprite:Sprite;
      
      private var _count:int;
      
      private var _skin:String;
      
      private var _space:int;
      
      private var _clipsUrl:String;
      
      private var _clipsUrlSimple:String;
      
      private var _align:String;
      
      private var _skinType:String;
      
      public function NumberImageEx()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         _countList = new Vector.<Clip>();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _countSprite = new Sprite();
         addChild(_countSprite);
         _countSprite.x = 0;
         _countSprite.y = 0;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(value:int) : void
      {
         if(_count == value)
         {
            return;
         }
         _count = value;
         callLater(updateSize);
      }
      
      public function set space(value:int) : void
      {
         if(_space == value)
         {
            return;
         }
         _space = value;
         callLater(updateSize);
      }
      
      public function get space() : int
      {
         return _space;
      }
      
      public function get skin() : String
      {
         return _skin;
      }
      
      public function set skin(value:String) : void
      {
         if(_skin == value)
         {
            return;
         }
         _skin = value;
         updateSkin(_skin,0);
         callLater(updateSize);
      }
      
      public function set clipsUrl(value:String) : void
      {
         if(_clipsUrl == value)
         {
            return;
         }
         _clipsUrl = value;
         updateSkin(_clipsUrl,1);
         callLater(updateSize);
      }
      
      public function set clipsUrlSimple(value:String) : void
      {
         if(_clipsUrlSimple == value)
         {
            return;
         }
         _clipsUrlSimple = value;
         updateSkin(_clipsUrlSimple,2);
         callLater(updateSize);
      }
      
      public function set align(value:String) : void
      {
         if(_align == value)
         {
            return;
         }
         _align = value;
         callLater(updateSize);
      }
      
      private function updateSkin(changeStr:String, type:int) : void
      {
         var i:int = 0;
         if(type == 0)
         {
            _skinType = "skin";
         }
         else if(type == 1)
         {
            _skinType = "clipsUrl";
         }
         else if(type == 2)
         {
            _skinType = "clipsUrlSimple";
         }
         i = 0;
         while(i < _countList.length)
         {
            _countList[i][_skinType] = changeStr;
            i++;
         }
      }
      
      private function updateSize() : void
      {
         var i:int = 0;
         var index:int = 0;
         var len:int = _count.toString().length;
         var _countArr:Array = _count.toString().split("");
         while(len > _countList.length)
         {
            _countList.unshift(createCountClip(0));
            _countSprite.addChild(_countList[0]);
         }
         while(len < _countList.length)
         {
            _countSprite.removeChild(_countList[0]);
            _countList.shift();
         }
         var spriteX:int = 0;
         for(i = 0; i < _countList.length; )
         {
            _countList[i].x = spriteX;
            index = int(_countArr[i]) == 0?0:int(_countArr[i]);
            _countList[i].index = index;
            spriteX = spriteX + (_countList[i].width + _space);
            i++;
         }
         var countX:int = 0;
         if(width > spriteX)
         {
            var _loc7_:* = _align;
            if("left" !== _loc7_)
            {
               if("center" !== _loc7_)
               {
                  if("right" === _loc7_)
                  {
                     countX = width - spriteX;
                  }
               }
               else
               {
                  countX = (width - spriteX) / 2;
               }
            }
            else
            {
               countX = 0;
            }
         }
         _countSprite.x = countX;
      }
      
      private function createCountClip(frame:int) : Clip
      {
         var num:Clip = new Clip();
         var _loc3_:* = _skinType;
         if("skin" !== _loc3_)
         {
            if("clipsUrl" !== _loc3_)
            {
               if("clipsUrlSimple" === _loc3_)
               {
                  num.clipsUrlSimple = _clipsUrlSimple;
               }
            }
            else
            {
               num.clipsUrl = _clipsUrl;
            }
         }
         else
         {
            num.skin = _skin;
         }
         num.clipX = 10;
         num.clipY = 1;
         num.index = frame;
         addChild(num);
         return num;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(_countList.length)
         {
            ObjectUtils.disposeObject(_countList.shift());
         }
         _countList = null;
         ObjectUtils.disposeObject(_countSprite);
         _countSprite = null;
      }
   }
}
