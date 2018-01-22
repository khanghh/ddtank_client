package par
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ShapeManager
   {
      
      public static var list:Array = [];
      
      private static var _ready:Boolean;
      
      private static var objects:Dictionary = new Dictionary();
       
      
      public function ShapeManager()
      {
         super();
      }
      
      public static function get ready() : Boolean
      {
         return _ready;
      }
      
      public static function clear() : void
      {
         list = [];
         _ready = false;
         objects = new Dictionary();
      }
      
      public static function setup() : void
      {
         var _loc1_:* = null;
         try
         {
            _loc1_ = ParticleManager.Domain.getDefinition("ParticalShapLib");
            if(_loc1_["data"])
            {
               list = _loc1_["data"];
               _ready = true;
            }
            return;
         }
         catch(err:Error)
         {
            trace(err.message);
            return;
         }
      }
      
      public static function create(param1:uint) : DisplayObject
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1 < 0 || param1 >= list.length)
         {
            _loc3_ = new Sprite();
            _loc3_.graphics.beginFill(0);
            _loc3_.graphics.drawCircle(0,0,10);
            _loc3_.graphics.endFill();
            return _loc3_;
         }
         _loc2_ = list[param1]["data"];
         return creatShape(_loc2_);
      }
      
      private static function creatShape(param1:*) : DisplayObject
      {
         var _loc2_:* = null;
         if(param1 is String)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = getQualifiedClassName(param1);
         }
         if(objects[_loc2_] == null)
         {
            objects[_loc2_] = new Vector.<DisplayObject>();
         }
         var _loc3_:Vector.<DisplayObject> = objects[_loc2_];
         return getFreeObject(_loc3_,_loc2_);
      }
      
      private static function getFreeObject(param1:Vector.<DisplayObject>, param2:String) : DisplayObject
      {
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            if(param1[_loc6_].parent == null)
            {
               return param1[_loc6_];
            }
            _loc6_++;
         }
         var _loc3_:Class = ParticleManager.Domain.getDefinition(param2) as Class;
         try
         {
            _loc4_ = new _loc3_();
            param1.push(_loc4_);
         }
         catch(e:Error)
         {
            throw new Error(param2 + "isn\'t exist!");
         }
         return _loc4_;
      }
   }
}
