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
      
      public function GypsyNPCBhvr(param1:Sprite)
      {
         super();
         _container = param1;
      }
      
      public function show() : void
      {
         var _loc1_:* = null;
         if(_hotArea == null)
         {
            return;
         }
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.setBuildVisible("gypsy",true);
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
         var _loc1_:* = null;
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.setBuildVisible("gypsy",false);
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
      
      public function set container(param1:Sprite) : void
      {
         _container = param1;
      }
      
      public function set hotArea(param1:InteractiveObject) : void
      {
         _hotArea = param1 as Component;
      }
      
      public function set hallView(param1:HallStateView) : void
      {
         _hall = param1;
      }
   }
}
