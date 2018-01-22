package road7th
{
   import flash.display.Stage;
   import flash.system.Capabilities;
   import starling.core.Starling;
   
   public class StarlingPre
   {
      
      public static var stageWidth:int;
      
      public static var stageHeight:int;
      
      public static var originalWidth:int;
      
      public static var originalHeight:int;
       
      
      public function StarlingPre()
      {
         super();
      }
      
      public function start(param1:Stage, param2:Function) : void
      {
         stage = param1;
         onComplete = param2;
         onRootCreate = function():void
         {
            mainStarling.stage.color = 4278190080;
            mainStarling.showStats = Capabilities.isDebugger;
            mainStarling.removeEventListener("rootCreated",onRootCreate);
            StarlingMain.instance.onStarlingCreate();
         };
         stageWidth = stage.stageWidth;
         stageHeight = stage.stageHeight;
         Starling.multitouchEnabled = false;
         Starling.handleLostContext = true;
         var mainStarling:Starling = new Starling(StarlingMain,stage,null,null,"auto","auto");
         mainStarling.simulateMultitouch = false;
         mainStarling.enableErrorChecking = Capabilities.isDebugger;
         mainStarling.addEventListener("rootCreated",onRootCreate);
         mainStarling.start();
      }
   }
}
