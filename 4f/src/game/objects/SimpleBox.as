package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.objects.GhostBoxModel;
   import gameCommon.view.smallMap.SmallBox;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class SimpleBox extends SimpleObject
   {
       
      
      private var _dieMC:MovieClipWrapper;
      
      private var _box:ScaleFrameImage;
      
      private var _ghostBox:MovieClip;
      
      private var _smallBox:SmallObject;
      
      private var _isGhostBox:Boolean;
      
      private var _subType:int = 0;
      
      private var _localVisible:Boolean = true;
      
      private var _constainer:DisplayObjectContainer;
      
      private var _self:LocalPlayer;
      
      private var _visible:Boolean = true;
      
      public function SimpleBox(param1:int, param2:String, param3:int = 1){super(null,null,null,null);}
      
      override public function get smallView() : SmallObject{return null;}
      
      override public function get layer() : int{return 0;}
      
      private function addEvent() : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function get isGhost() : Boolean{return false;}
      
      public function get subType() : int{return 0;}
      
      public function get psychic() : int{return 0;}
      
      protected function setIsGhost(param1:Boolean) : void{}
      
      public function pickByLiving(param1:Living) : void{}
      
      override protected function creatMovie(param1:String) : void{}
      
      public function setContainer(param1:DisplayObjectContainer) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      override public function collidedByObject(param1:PhysicalObj) : void{}
      
      override public function die() : void{}
      
      protected function __boxDieComplete(param1:Event) : void{}
      
      override public function isBox() : Boolean{return false;}
      
      override public function get canCollided() : Boolean{return false;}
      
      override public function dispose() : void{}
      
      override public function playAction(param1:String) : void{}
      
      private function __onSelfPlayerDie(param1:Event) : void{}
      
      private function __onSelfPlayerRevive(param1:Event) : void{}
   }
}
