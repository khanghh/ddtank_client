package com.pickgliss.utils
{
   import flash.errors.IllegalOperationError;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedSuperclassName;
   
   public final class ClassUtils
   {
      
      public static const INNERRECTANGLE:String = "com.pickgliss.geom.InnerRectangle";
      
      public static const OUTTERRECPOS:String = "com.pickgliss.geom.OuterRectPos";
      
      public static const RECTANGLE:String = "flash.geom.Rectangle";
      
      public static const COLOR_MATIX_FILTER:String = "flash.filters.ColorMatrixFilter";
      
      private static var _appDomain:ApplicationDomain;
       
      
      public function ClassUtils()
      {
         super();
      }
      
      public static function CreatInstance(className:String, args:Array = null) : *
      {
         var instance:* = null;
         var instanceClass:Object = getDefinitionByName(className);
         if(instanceClass == null)
         {
            throw new IllegalOperationError("can\'t find the class of\"" + className + "\"in current domain");
         }
         if(args == null || args.length == 0)
         {
            instance = new instanceClass();
         }
         else if(args.length == 1)
         {
            instance = new instanceClass(args[0]);
         }
         else if(args.length == 2)
         {
            instance = new instanceClass(args[0],args[1]);
         }
         else if(args.length == 3)
         {
            instance = new instanceClass(args[0],args[1],args[2]);
         }
         else if(args.length == 4)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3]);
         }
         else if(args.length == 5)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4]);
         }
         else if(args.length == 6)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5]);
         }
         else if(args.length == 7)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
         }
         else if(args.length == 8)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
         }
         else if(args.length == 9)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]);
         }
         else if(args.length == 10)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]);
         }
         else if(args.length == 11)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10]);
         }
         else if(args.length == 12)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11]);
         }
         else if(args.length == 13)
         {
            instance = new instanceClass(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12]);
         }
         else
         {
            throw new IllegalOperationError("arguments too long");
         }
         return instance;
      }
      
      public static function get uiSourceDomain() : ApplicationDomain
      {
         return _appDomain;
      }
      
      public static function set uiSourceDomain(domain:ApplicationDomain) : void
      {
         _appDomain = domain;
      }
      
      public static function getDefinition(classname:String) : Object
      {
         return getDefinitionByName(classname);
      }
      
      public static function classIsBitmapData(classname:String) : Boolean
      {
         if(!_appDomain.hasDefinition(classname))
         {
            return false;
         }
         var c:* = getDefinitionByName(classname);
         var superClassname:String = getQualifiedSuperclassName(c);
         return superClassname == "flash.display::BitmapData";
      }
      
      public static function classIsComponent(classname:String) : Boolean
      {
         if(classname == "com.pickgliss.ui.text.FilterFrameText" || classname == "com.pickgliss.ui.controls.SimpleDropListTarget" || classname == "ddt.view.FriendDropListTarget" || classname == "com.pickgliss.ui.FilterFrameTextWithTips" || classname == "eliteGame.view.EliteGamePaarungText")
         {
            return false;
         }
         return true;
      }
   }
}
