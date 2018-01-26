package trainer.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import org.aswing.KeyboardManager;
   import trainer.controller.WeakGuildManager;
   
   public class NewHandContainer
   {
      
      private static var _instance:NewHandContainer;
       
      
      private var _arrows:Dictionary;
      
      private var _movies:Dictionary;
      
      private var _guideCover:GuideCover;
      
      private var _isEscDisabled:Boolean = false;
      
      public function NewHandContainer(param1:NewHandContainerEnforcer){super();}
      
      public static function get Instance() : NewHandContainer{return null;}
      
      protected function onGuideRemoved(param1:Event) : void{}
      
      public function showGuideCover(param1:String, param2:Array, param3:int = 4, param4:Boolean = true) : void{}
      
      public function showGuideCoverMultiHoles(param1:int, param2:Boolean, ... rest) : void{}
      
      public function showCover(param1:uint, param2:Number, param3:int = 4, param4:Boolean = true) : void{}
      
      public function hideGuideCover() : void{}
      
      private function lockKeyBoard() : void{}
      
      private function unLockKeyBoard() : void{}
      
      protected function onKey(param1:KeyboardEvent) : void{}
      
      public function showArrow(param1:int, param2:int, param3:*, param4:String = "", param5:String = "", param6:DisplayObjectContainer = null, param7:int = 0, param8:Boolean = false) : void{}
      
      public function clearArrowByID(param1:int) : void{}
      
      public function hasArrow(param1:int) : Boolean{return false;}
      
      public function showMovie(param1:String, param2:String = "") : void{}
      
      public function hideMovie(param1:String) : void{}
      
      private function clearArrow(param1:int) : void{}
      
      private function clearMovie(param1:String) : void{}
      
      public function dispose() : void{}
   }
}

class NewHandContainerEnforcer
{
    
   
   function NewHandContainerEnforcer(){super();}
}
