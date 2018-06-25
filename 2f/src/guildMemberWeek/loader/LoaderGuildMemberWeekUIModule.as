package guildMemberWeek.loader{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.controls.Frame;   import ddt.view.UIModuleSmallLoading;      public class LoaderGuildMemberWeekUIModule extends Frame   {            private static var _instance:LoaderGuildMemberWeekUIModule;                   private var _func:Function;            private var _funcParams:Array;            private var _LoadResourseOK:Boolean = false;            public function LoaderGuildMemberWeekUIModule(pct:PrivateClass) { super(); }
            public static function get Instance() : LoaderGuildMemberWeekUIModule { return null; }
            public function loadUIModule(complete:Function = null, completeParams:Array = null) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}