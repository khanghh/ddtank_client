package gypsyShop.npcBehavior
{
   import com.pickgliss.ui.core.Component;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import hall.HallStateView;
   import road7th.StarlingMain;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   
   public class GypsyNPCBhvr implements IGypsyNPCBehavior
   {
       
      
      private var _hall:HallStateView;
      
      private var _container:Sprite;
      
      private var _hotArea:Component;
      
      private var _gypsyNPC:MovieClip;
      
      public function GypsyNPCBhvr(container:Sprite)
      {
         super();
         _container = container;
      }
      
      public function show() : void
      {
         var staticLayer:* = null;
         if(_hotArea == null)
         {
            return;
         }
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayer = currentScene.playerView.staticLayer;
            staticLayer.setBuildVisible("gypsy",true);
         }
         _hotArea.visible = true;
         _hotArea.mouseEnabled = true;
         var _loc3_:* = true;
         _hotArea.mouseEnabled = _loc3_;
         _loc3_ = _loc3_;
         _hotArea.mouseChildren = _loc3_;
         _hotArea.buttonMode = _loc3_;
         if(_hall)
         {
            _hall.setNPCBtnEnable(_hotArea as Component,true);
         }
      }
      
      public function hide() : void
      {
         var staticLayer:* = null;
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayer = currentScene.playerView.staticLayer;
            staticLayer.setBuildVisible("gypsy",false);
         }
         if(_hotArea != null)
         {
            _hotArea.visible = false;
            var _loc3_:* = false;
            _hotArea.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _hotArea.mouseChildren = _loc3_;
            _hotArea.buttonMode = _loc3_;
         }
         if(_hall)
         {
            _hall.setNPCBtnEnable(_hotArea as Component,false);
         }
      }
      
      public function dispose() : void
      {
         if(_gypsyNPC != null)
         {
            _gypsyNPC = null;
         }
         _container = null;
         _hall = null;
      }
      
      public function set container(value:Sprite) : void
      {
         _container = value;
      }
      
      public function set hotArea(value:InteractiveObject) : void
      {
         _hotArea = value as Component;
      }
      
      public function set hallView(value:HallStateView) : void
      {
         _hall = value;
      }
   }
}
