package morn.editor{   import flash.display.BitmapData;   import morn.core.managers.AssetManager;   import morn.core.utils.BitmapUtils;      public class BuilderResManager extends AssetManager   {                   public function BuilderResManager() { super(); }
            override public function hasClass(name:String) : Boolean { return false; }
            override public function getClass(name:String) : Class { return null; }
            override public function getAsset(name:String) : * { return null; }
            override public function getBitmapData(name:String, cache:Boolean = true) : BitmapData { return null; }
            override public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = true, source:BitmapData = null) : Vector.<BitmapData> { return null; }
   }}