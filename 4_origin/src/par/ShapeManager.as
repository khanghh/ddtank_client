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
         var cls:* = null;
         try
         {
            cls = ParticleManager.Domain.getDefinition("ParticalShapLib");
            if(cls["data"])
            {
               list = cls["data"];
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
      
      public static function create(id:uint) : DisplayObject
      {
         var sprit:* = null;
         var ator:* = null;
         if(id < 0 || id >= list.length)
         {
            sprit = new Sprite();
            sprit.graphics.beginFill(0);
            sprit.graphics.drawCircle(0,0,10);
            sprit.graphics.endFill();
            return sprit;
         }
         ator = list[id]["data"];
         return creatShape(ator);
      }
      
      private static function creatShape(clazz:*) : DisplayObject
      {
         var classname:* = null;
         if(clazz is String)
         {
            classname = clazz;
         }
         else
         {
            classname = getQualifiedClassName(clazz);
         }
         if(objects[classname] == null)
         {
            objects[classname] = new Vector.<DisplayObject>();
         }
         var list:Vector.<DisplayObject> = objects[classname];
         return getFreeObject(list,classname);
      }
      
      private static function getFreeObject(objects:Vector.<DisplayObject>, classname:String) : DisplayObject
      {
         var i:int = 0;
         var object:* = undefined;
         var len:int = objects.length;
         for(i = 0; i < objects.length; )
         {
            if(objects[i].parent == null)
            {
               return objects[i];
            }
            i++;
         }
         var objectClass:Class = ParticleManager.Domain.getDefinition(classname) as Class;
         try
         {
            object = new objectClass();
            objects.push(object);
         }
         catch(e:Error)
         {
            throw new Error(classname + "isn\'t exist!");
         }
         return object;
      }
   }
}
