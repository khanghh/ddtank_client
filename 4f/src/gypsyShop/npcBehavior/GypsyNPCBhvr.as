package gypsyShop.npcBehavior{   import com.pickgliss.ui.core.Component;   import flash.display.InteractiveObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import hall.HallStateView;   import road7th.StarlingMain;   import starling.scene.hall.HallScene;   import starling.scene.hall.StaticLayer;      public class GypsyNPCBhvr implements IGypsyNPCBehavior   {                   private var _hall:HallStateView;            private var _container:Sprite;            private var _hotArea:Component;            private var _gypsyNPC:MovieClip;            public function GypsyNPCBhvr(container:Sprite) { super(); }
            public function show() : void { }
            public function hide() : void { }
            public function dispose() : void { }
            public function set container(value:Sprite) : void { }
            public function set hotArea(value:InteractiveObject) : void { }
            public function set hallView(value:HallStateView) : void { }
   }}