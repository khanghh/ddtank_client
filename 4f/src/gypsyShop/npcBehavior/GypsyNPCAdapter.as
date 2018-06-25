package gypsyShop.npcBehavior{   import flash.display.InteractiveObject;   import flash.display.Sprite;   import hall.HallStateView;      public class GypsyNPCAdapter implements IGypsyNPCBehavior   {                   public function GypsyNPCAdapter(container:Sprite) { super(); }
            public function show() : void { }
            public function hide() : void { }
            public function dispose() : void { }
            public function set container(value:Sprite) : void { }
            public function set hotArea(value:InteractiveObject) : void { }
            public function set hallView(value:HallStateView) : void { }
   }}