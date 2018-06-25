package trainer.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.PlayerManager;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import flash.utils.setTimeout;   import org.aswing.KeyboardManager;   import trainer.controller.WeakGuildManager;      public class NewHandContainer   {            private static var _instance:NewHandContainer;                   private var _arrows:Dictionary;            private var _movies:Dictionary;            private var _guideCover:GuideCover;            private var _isEscDisabled:Boolean = false;            public function NewHandContainer(enforcer:NewHandContainerEnforcer) { super(); }
            public static function get Instance() : NewHandContainer { return null; }
            protected function onGuideRemoved(e:Event) : void { }
            public function showGuideCover(guideCoverType:String, args:Array, layer:int = 4, isDisableESC:Boolean = true) : void { }
            public function showGuideCoverMultiHoles(layer:int, isDisableESC:Boolean, ... args) : void { }
            public function showCover($color:uint, $alpha:Number, layer:int = 4, isDisableESC:Boolean = true) : void { }
            public function hideGuideCover() : void { }
            private function lockKeyBoard() : void { }
            private function unLockKeyBoard() : void { }
            protected function onKey(e:KeyboardEvent) : void { }
            public function showArrow(id:int, rotation:int, arrowPos:*, tip:String = "", tipPos:String = "", con:DisplayObjectContainer = null, delay:int = 0, isFarmGuild:Boolean = false) : void { }
            public function clearArrowByID(id:int) : void { }
            public function hasArrow(id:int) : Boolean { return false; }
            public function showMovie(styleName:String, pos:String = "") : void { }
            public function hideMovie(styleName:String) : void { }
            private function clearArrow(id:int) : void { }
            private function clearMovie(styleName:String) : void { }
            public function dispose() : void { }
   }}class NewHandContainerEnforcer{          function NewHandContainerEnforcer() { super(); }
}