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
         mouseEnabled = mouseChildren = false;
         this._countList = new Vector.<Clip>();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._countSprite = new Sprite();
         addChild(this._countSprite);
         this._countSprite.x = 0;
         this._countSprite.y = 0;
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function set count(param1:int) : void
      {
         if(this._count == param1)
         {
            return;
         }
         this._count = param1;
         callLater(this.updateSize);
      }
      
      public function set space(param1:int) : void
      {
         if(this._space == param1)
         {
            return;
         }
         this._space = param1;
         callLater(this.updateSize);
      }
      
      public function get space() : int
      {
         return this._space;
      }
      
      public function get skin() : String
      {
         return this._skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(this._skin == param1)
         {
            return;
         }
         this._skin = param1;
         this.updateSkin(this._skin,0);
         callLater(this.updateSize);
      }
      
      public function set clipsUrl(param1:String) : void
      {
         if(this._clipsUrl == param1)
         {
            return;
         }
         this._clipsUrl = param1;
         this.updateSkin(this._clipsUrl,1);
         callLater(this.updateSize);
      }
      
      public function set clipsUrlSimple(param1:String) : void
      {
         if(this._clipsUrlSimple == param1)
         {
            return;
         }
         this._clipsUrlSimple = param1;
         this.updateSkin(this._clipsUrlSimple,2);
         callLater(this.updateSize);
      }
      
      public function set align(param1:String) : void
      {
         if(this._align == param1)
         {
            return;
         }
         this._align = param1;
         callLater(this.updateSize);
      }
      
      private function updateSkin(param1:String, param2:int) : void
      {
         if(param2 == 0)
         {
            this._skinType = "skin";
         }
         else if(param2 == 1)
         {
            this._skinType = "clipsUrl";
         }
         else if(param2 == 2)
         {
            this._skinType = "clipsUrlSimple";
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._countList.length)
         {
            this._countList[_loc3_][this._skinType] = param1;
            _loc3_++;
         }
      }
      
      private function updateSize() : void
      {
         var _loc6_:int = 0;
         var _loc1_:int = this._count.toString().length;
         var _loc2_:Array = this._count.toString().split("");
         while(_loc1_ > this._countList.length)
         {
            this._countList.unshift(this.createCountClip(0));
            this._countSprite.addChild(this._countList[0]);
         }
         while(_loc1_ < this._countList.length)
         {
            this._countSprite.removeChild(this._countList[0]);
            this._countList.shift();
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._countList.length)
         {
            this._countList[_loc4_].x = _loc3_;
            _loc6_ = int(_loc2_[_loc4_]) == 0?0:int(int(_loc2_[_loc4_]));
            this._countList[_loc4_].index = _loc6_;
            _loc3_ = _loc3_ + (this._countList[_loc4_].width + this._space);
            _loc4_++;
         }
         var _loc5_:int = 0;
         if(width > _loc3_)
         {
            switch(this._align)
            {
               case LEFT:
                  _loc5_ = 0;
                  break;
               case CENTER:
                  _loc5_ = (width - _loc3_) / 2;
                  break;
               case RIGHT:
                  _loc5_ = width - _loc3_;
            }
         }
         this._countSprite.x = _loc5_;
      }
      
      private function createCountClip(param1:int) : Clip
      {
         var _loc2_:Clip = new Clip();
         switch(this._skinType)
         {
            case "skin":
               _loc2_.skin = this._skin;
               break;
            case "clipsUrl":
               _loc2_.clipsUrl = this._clipsUrl;
               break;
            case "clipsUrlSimple":
               _loc2_.clipsUrlSimple = this._clipsUrlSimple;
         }
         _loc2_.clipX = 10;
         _loc2_.clipY = 1;
         _loc2_.index = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(this._countList.length)
         {
            ObjectUtils.disposeObject(this._countList.shift());
         }
         this._countList = null;
         ObjectUtils.disposeObject(this._countSprite);
         this._countSprite = null;
      }
   }
}
